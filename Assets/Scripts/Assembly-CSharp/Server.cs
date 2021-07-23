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
            {
                1,
                ServerHandle.WelcomeReceived
            },
            {
                2,
                ServerHandle.JoinRequest
            },
            {
                33,
                ServerHandle.StartedLoading
            },
            {
                29,
                ServerHandle.PlayerFinishedLoading
            },
            {
                5,
                ServerHandle.PlayerDisconnect
            },
            {
                3,
                ServerHandle.PlayerPosition
            },
            {
                26,
                ServerHandle.PlayerHp
            },
            {
                27,
                ServerHandle.PlayerDied
            },
            {
                31,
                ServerHandle.RevivePlayer
            },
            {
                4,
                ServerHandle.PlayerRotation
            },
            {
                6,
                ServerHandle.PingReceived
            },
            {
                9,
                ServerHandle.PlayerRequestedSpawns
            },
            {
                8,
                ServerHandle.Ready
            },
            {
                10,
                ServerHandle.ItemDropped
            },
            {
                11,
                ServerHandle.ItemDroppedAtPosition
            },
            {
                12,
                ServerHandle.ItemPickedUp
            },
            {
                13,
                ServerHandle.WeaponInHand
            },
            {
                15,
                ServerHandle.AnimationUpdate
            },
            {
                28,
                ServerHandle.ShootArrow
            },
            {
                14,
                ServerHandle.PlayerHitObject
            },
            {
                30,
                ServerHandle.SpawnEffect
            },
            {
                20,
                ServerHandle.PlayerHit
            },
            {
                16,
                ServerHandle.RequestBuild
            },
            {
                17,
                ServerHandle.RequestChest
            },
            {
                18,
                ServerHandle.UpdateChest
            },
            {
                19,
                ServerHandle.ItemInteract
            },
            {
                21,
                ServerHandle.PlayerDamageMob
            },
            {
                22,
                ServerHandle.ShrineCombatStartRequest
            },
            {
                32,
                ServerHandle.Interact
            },
            {
                23,
                ServerHandle.ReceiveChatMessage
            },
            {
                24,
                ServerHandle.ReceivePing
            },
            {
                25,
                ServerHandle.ReceiveArmor
            },
            {
                34,
                ServerHandle.ReceiveShipUpdate
            }
        };
    }

    public static void Stop()
    {
        tcpListener.Stop();
        udpListener.Close();
    }
}
