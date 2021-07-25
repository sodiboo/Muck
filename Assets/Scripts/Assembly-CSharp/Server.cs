using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using UnityEngine;

public class Server
{
    public delegate void PacketHandler(int fromClient, Packet packet);

    public static Dictionary<int, Client> clients = new Dictionary<int, Client>();

    public static Dictionary<int, PacketHandler> PacketHandlers;

    public static int idCounter;

    private static TcpListener tcpListener;

    private static UdpClient udpListener;

    public static IPAddress ipAddress = IPAddress.Any;

    public static int MaxPlayers { get; private set; }

    public static int Port { get; private set; }

    public static int GetNextId()
    {
        int result = idCounter;
        idCounter++;
        return result;
    }

    public static void Start(int maxPlayers, int port)
    {
        MaxPlayers = maxPlayers;
        Port = port;
        Debug.Log("Starting server.. ver.0.7");
        InitializeServerData();
        tcpListener = new TcpListener(ipAddress, Port);
        Debug.Log($"TclpListener on IP: {ipAddress}.");
        tcpListener.Start();
        tcpListener.BeginAcceptTcpClient(TCPConnectCallback, null);
        udpListener = new UdpClient(Port);
        udpListener.BeginReceive(UDPReceiveCallback, null);
        Debug.Log("Server started on port:" + Port);
        ThreadManagerServer.Instance.ResetGame();
    }

    private static void TCPConnectCallback(IAsyncResult result)
    {
        TcpClient tcpClient = tcpListener.EndAcceptTcpClient(result);
        tcpListener.BeginAcceptTcpClient(TCPConnectCallback, null);
        Debug.Log($"Incoming connection from {tcpClient.Client.RemoteEndPoint}...");
        for (int i = 1; i <= MaxPlayers; i++)
        {
            if (clients[i].tcp.socket == null)
            {
                clients[i].tcp.Connect(tcpClient);
                return;
            }
        }
        Debug.Log($"{tcpClient.Client.RemoteEndPoint} failed to connect: Server full! f");
    }

    private static void UDPReceiveCallback(IAsyncResult result)
    {
        try
        {
            IPEndPoint remoteEP = new IPEndPoint(IPAddress.Any, 0);
            byte[] array = udpListener.EndReceive(result, ref remoteEP);
            udpListener.BeginReceive(UDPReceiveCallback, null);
            if (array.Length < 4)
            {
                return;
            }
            using (Packet packet = new Packet(array))
            {
                int num = packet.ReadInt();
                if (num != 0)
                {
                    if (clients[num].udp.endPoint == null)
                    {
                        clients[num].udp.Connect(remoteEP);
                    }
                    else if (clients[num].udp.endPoint.ToString() == remoteEP.ToString())
                    {
                        clients[num].udp.HandleData(packet);
                    }
                }
            }
        }
        catch (Exception arg)
        {
            Debug.Log($"Catching error receiving UDP data: {arg}");
            Debug.Log("This error message can be ignored if just closing server. Server has been closed successfully.");
        }
    }

    public static void SendUDPData(IPEndPoint clientEndPoint, Packet packet)
    {
        try
        {
            if (clientEndPoint != null)
            {
                udpListener.BeginSend(packet.ToArray(), packet.Length(), clientEndPoint, null, null);
            }
        }
        catch (Exception arg)
        {
            Debug.Log($"Error sending data to {clientEndPoint} via UDP: {arg}.");
        }
    }

    public static void InitializeServerData()
    {
        for (int i = 1; i <= MaxPlayers; i++)
        {
            clients.Add(i, new Client(i));
        }
        InitializeServerPackets();
        Debug.Log("Initialized Packets.");
    }

    public static void InitializeServerPackets()
    {
        PacketHandlers = new Dictionary<int, PacketHandler>
        {
            { (int)ClientPackets.welcomeReceived, ServerHandle.WelcomeReceived },
            { (int)ClientPackets.joinLobby, ServerHandle.JoinRequest },
            { (int)ClientPackets.playerPosition, ServerHandle.PlayerPosition },
            { (int)ClientPackets.playerRotation, ServerHandle.PlayerRotation },
            { (int)ClientPackets.sendDisconnect, ServerHandle.PlayerDisconnect },
            { (int)ClientPackets.sendPing, ServerHandle.PingReceived },
            // playerKilled
            { (int)ClientPackets.ready, ServerHandle.Ready },
            { (int)ClientPackets.requestSpawns, ServerHandle.PlayerRequestedSpawns },
            { (int)ClientPackets.dropItem, ServerHandle.ItemDropped },
            { (int)ClientPackets.dropItemAtPosition, ServerHandle.ItemDroppedAtPosition },
            { (int)ClientPackets.pickupItem, ServerHandle.ItemPickedUp },
            { (int)ClientPackets.weaponInHand, ServerHandle.WeaponInHand },
            { (int)ClientPackets.playerHitObject, ServerHandle.PlayerHitObject },
            { (int)ClientPackets.animationUpdate, ServerHandle.AnimationUpdate },
            { (int)ClientPackets.requestBuild, ServerHandle.RequestBuild },
            { (int)ClientPackets.requestChest, ServerHandle.RequestChest },
            { (int)ClientPackets.updateChest, ServerHandle.UpdateChest },
            { (int)ClientPackets.pickupInteract, ServerHandle.ItemInteract },
            { (int)ClientPackets.playerHit, ServerHandle.PlayerHit },
            { (int)ClientPackets.playerDamageMob, ServerHandle.PlayerDamageMob },
            { (int)ClientPackets.shrineCombatStart, ServerHandle.ShrineCombatStartRequest },
            { (int)ClientPackets.sendChatMessage, ServerHandle.ReceiveChatMessage },
            { (int)ClientPackets.playerPing, ServerHandle.ReceivePing },
            { (int)ClientPackets.sendArmor, ServerHandle.ReceiveArmor },
            { (int)ClientPackets.playerHp, ServerHandle.PlayerHp },
            { (int)ClientPackets.playerDied, ServerHandle.PlayerDied },
            { (int)ClientPackets.shootArrow, ServerHandle.ShootArrow },
            { (int)ClientPackets.finishedLoading, ServerHandle.PlayerFinishedLoading },
            { (int)ClientPackets.spawnEffect, ServerHandle.SpawnEffect },
            { (int)ClientPackets.reviveRequest, ServerHandle.RevivePlayer },
            { (int)ClientPackets.interact, ServerHandle.Interact },
            { (int)ClientPackets.startedLoading, ServerHandle.StartedLoading },
            { (int)ClientPackets.shipUpdate, ServerHandle.ReceiveShipUpdate },
        };
    }

    public static void Stop()
    {
        tcpListener.Stop();
        udpListener.Close();
    }
}
