
using Steamworks;
using Steamworks.Data;
using UnityEngine;

// Token: 0x020000B8 RID: 184
public class SteamPacketManager : MonoBehaviour
{
	// Token: 0x060005E5 RID: 1509 RVA: 0x0001E3F2 File Offset: 0x0001C5F2
	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
		Server.InitializeServerPackets();
		LocalClient.InitializeClientData();
	}

	// Token: 0x060005E6 RID: 1510 RVA: 0x0001E409 File Offset: 0x0001C609
	private void Update()
	{
		SteamClient.RunCallbacks();
		this.CheckForPackets();
	}

	// Token: 0x060005E7 RID: 1511 RVA: 0x0001E418 File Offset: 0x0001C618
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

	// Token: 0x060005E8 RID: 1512 RVA: 0x0001E450 File Offset: 0x0001C650
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

	// Token: 0x060005E9 RID: 1513 RVA: 0x0001E550 File Offset: 0x0001C750
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

	// Token: 0x060005EA RID: 1514 RVA: 0x0001E5C6 File Offset: 0x0001C7C6
	private void OnApplicationQuit()
	{
		SteamPacketManager.CloseConnections();
	}

	// Token: 0x060005EB RID: 1515 RVA: 0x0001E5D0 File Offset: 0x0001C7D0
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

	// Token: 0x0200012F RID: 303
	public enum NetworkChannel
	{
		// Token: 0x040007BD RID: 1981
		ToClient,
		// Token: 0x040007BE RID: 1982
		ToServer
	}
}
