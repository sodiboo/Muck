using Steamworks;
using Steamworks.Data;
using UnityEngine;

public class SteamPacketManager : MonoBehaviour
{
    public enum NetworkChannel
    {
        ToClient,
        ToServer
    }

    private void Start()
    {
        Object.DontDestroyOnLoad(base.gameObject);
        Server.InitializeServerPackets();
        LocalClient.InitializeClientData();
    }

    private void Update()
    {
        SteamClient.RunCallbacks();
        CheckForPackets();
    }

    private void CheckForPackets()
    {
        for (int i = 0; i < 2; i++)
        {
            if (SteamNetworking.IsP2PPacketAvailable(i))
            {
                while (SteamNetworking.IsP2PPacketAvailable(i))
                {
                    HandlePacket(SteamNetworking.ReadP2PPacket(i), i);
                }
            }
        }
    }

    private static void HandlePacket(P2Packet? p2Packet, int channel)
    {
        if (!p2Packet.HasValue)
        {
            return;
        }
        SteamId steamid = p2Packet.Value.SteamId.Value;
        byte[] data = p2Packet.Value.Data;
        if (!LocalClient.serverOwner && steamid.Value != LocalClient.instance.serverHost.Value)
        {
            Debug.LogError("Received packet from someone other than server: " + new Friend(steamid).Name + "\nDenying packet...");
            return;
        }
        Packet packet = new Packet();
        packet.SetBytes(data);
        int num = packet.Length();
        int num2 = packet.ReadInt();
        if (num != num2 + 4)
        {
            Debug.LogError("didnt read entire packet");
        }
        int key = packet.ReadInt();
        if (channel == 0)
        {
            if (steamid.Value == LocalClient.instance.serverHost.Value)
            {
                LocalClient.packetHandlers[key](packet);
            }
        }
        else
        {
            Server.PacketHandlers[key](SteamLobby.steamIdToClientId[steamid.Value], packet);
        }
    }

    public static void SendPacket(SteamId steamId, Packet p, P2PSend p2pSend, NetworkChannel channel)
    {
        int length = p.Length();
        byte[] data = p.CloneBytes();
        new Packet(data);
        if (steamId.Value != SteamManager.Instance.PlayerSteamId.Value)
        {
            SteamNetworking.SendP2PPacket(steamId.Value, data, length, (int)channel, p2pSend);
            return;
        }
        P2Packet value = default(P2Packet);
        value.SteamId = steamId.Value;
        value.Data = data;
        HandlePacket(value, (int)channel);
    }

    private void OnApplicationQuit()
    {
        CloseConnections();
    }

    public static void CloseConnections()
    {
        foreach (ulong key in SteamLobby.steamIdToClientId.Keys)
        {
            SteamNetworking.CloseP2PSessionWithUser(key);
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
}
