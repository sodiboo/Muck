using System;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

// Token: 0x020000E0 RID: 224
public class SteamPacketManager : MonoBehaviour
{
	// Token: 0x060006FA RID: 1786 RVA: 0x0002426A File Offset: 0x0002246A
	private void Start()
	{
		DontDestroyOnLoad(base.gameObject);
		Server.InitializeServerPackets();
		LocalClient.InitializeClientData();
	}

	// Token: 0x060006FB RID: 1787 RVA: 0x00024281 File Offset: 0x00022481
	private void Update()
	{
		SteamClient.RunCallbacks();
		this.CheckForPackets();
	}

	// Token: 0x060006FC RID: 1788 RVA: 0x00024290 File Offset: 0x00022490
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

	// Token: 0x060006FD RID: 1789 RVA: 0x000242C8 File Offset: 0x000224C8
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

	// Token: 0x060006FE RID: 1790 RVA: 0x000243C8 File Offset: 0x000225C8
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

	// Token: 0x060006FF RID: 1791 RVA: 0x0002443E File Offset: 0x0002263E
	private void OnApplicationQuit()
	{
		SteamPacketManager.CloseConnections();
	}

	// Token: 0x06000700 RID: 1792 RVA: 0x00024448 File Offset: 0x00022648
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

	// Token: 0x0200016E RID: 366
	public enum NetworkChannel
	{
		// Token: 0x0400093C RID: 2364
		ToClient,
		// Token: 0x0400093D RID: 2365
		ToServer
	}
}
