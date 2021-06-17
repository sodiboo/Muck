using System;
using Steamworks;
using Steamworks.Data;
using UnityEngine;


public class SteamPacketManager : MonoBehaviour
{

	private void Start()
	{
		DontDestroyOnLoad(base.gameObject);
		Server.InitializeServerPackets();
		LocalClient.InitializeClientData();
	}


	private void Update()
	{
		SteamClient.RunCallbacks();
		this.CheckForPackets();
	}


	private void CheckForPackets()
	{
		for (int i = 0; i < 2; i++)
		{
			if (SteamNetworking.IsP2PPacketAvailable(i))
			{
				while (SteamNetworking.IsP2PPacketAvailable(i))
				{
					SteamPacketManager.HandlePacket(SteamNetworking.ReadP2PPacket(i), i);
				}
			}
		}
	}


	private static void HandlePacket(P2Packet? p2Packet, int channel)
	{
		if (p2Packet == null)
		{
			return;
		}
		SteamId steamId = p2Packet.Value.SteamId.Value;
		byte[] data = p2Packet.Value.Data;
		if (!LocalClient.serverOwner && steamId.Value != LocalClient.instance.serverHost.Value)
		{
			Debug.LogError("Received packet from someone other than server: " + new Friend(steamId).Name + "\nDenying packet...");
			return;
		}
		Packet packet = new Packet();
		packet.SetBytes(data);
		int num = packet.Length();
		int num2 = packet.ReadInt(true);
		if (num != num2 + 4)
		{
			Debug.LogError("didnt read entire packet");
		}
		int key = packet.ReadInt(true);
		if (channel != 0)
		{
			Server.PacketHandlers[key](SteamLobby.steamIdToClientId[steamId.Value], packet);
			return;
		}
		if (steamId.Value != LocalClient.instance.serverHost.Value)
		{
			return;
		}
		LocalClient.packetHandlers[key](packet);
	}


	public static void SendPacket(SteamId steamId, Packet p, P2PSend p2pSend, SteamPacketManager.NetworkChannel channel)
	{
		int length = p.Length();
		byte[] data = p.CloneBytes();
		if (steamId.Value != SteamManager.Instance.PlayerSteamId.Value)
		{
			SteamNetworking.SendP2PPacket(steamId.Value, data, length, (int)channel, p2pSend);
			return;
		}
		SteamPacketManager.HandlePacket(new P2Packet?(new P2Packet
		{
			SteamId = steamId.Value,
			Data = data
		}), (int)channel);
	}


	private void OnApplicationQuit()
	{
		SteamPacketManager.CloseConnections();
	}


	public static void CloseConnections()
	{
		foreach (ulong value in SteamLobby.steamIdToClientId.Keys)
		{
			SteamNetworking.CloseP2PSessionWithUser(value);
		}
		try
		{
			SteamNetworking.CloseP2PSessionWithUser(LocalClient.instance.serverHost);
		}
		catch
		{
			Debug.Log("Failed to close p2p with host");
		}
		SteamClient.Shutdown();
	}


	public enum NetworkChannel
	{

		ToClient,

		ToServer
	}
}
