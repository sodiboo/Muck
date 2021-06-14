using Steamworks;
using Steamworks.Data;
using UnityEngine;

// Token: 0x020000F4 RID: 244
public class SteamPacketManager : MonoBehaviour
{
	// Token: 0x06000678 RID: 1656 RVA: 0x00006279 File Offset: 0x00004479
	private void Start()
	{
		DontDestroyOnLoad(base.gameObject);
		Server.InitializeServerPackets();
		LocalClient.InitializeClientData();
	}

	// Token: 0x06000679 RID: 1657 RVA: 0x00006290 File Offset: 0x00004490
	private void Update()
	{
		SteamClient.RunCallbacks();
		this.CheckForPackets();
	}

	// Token: 0x0600067A RID: 1658 RVA: 0x00021F90 File Offset: 0x00020190
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

	// Token: 0x0600067B RID: 1659 RVA: 0x00021FC8 File Offset: 0x000201C8
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

	// Token: 0x0600067C RID: 1660 RVA: 0x000220C8 File Offset: 0x000202C8
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

	// Token: 0x0600067D RID: 1661 RVA: 0x0000629D File Offset: 0x0000449D
	private void OnApplicationQuit()
	{
		SteamPacketManager.CloseConnections();
	}

	// Token: 0x0600067E RID: 1662 RVA: 0x00022140 File Offset: 0x00020340
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

	// Token: 0x020000F5 RID: 245
	public enum NetworkChannel
	{
		// Token: 0x04000668 RID: 1640
		ToClient,
		// Token: 0x04000669 RID: 1641
		ToServer
	}
}
