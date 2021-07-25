using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

public class LocalClient : MonoBehaviour
{
    public delegate void PacketHandler(Packet packet);

    public class TCP
    {
        public TcpClient socket;

        private NetworkStream stream;

        private Packet receivedData;

        private byte[] receiveBuffer;

        public void Connect()
        {
            socket = new TcpClient
            {
                ReceiveBufferSize = dataBufferSize,
                SendBufferSize = dataBufferSize
            };
            receiveBuffer = new byte[dataBufferSize];
            socket.BeginConnect(instance.ip, instance.port, ConnectCallback, socket);
        }

        private void ConnectCallback(IAsyncResult result)
        {
            socket.EndConnect(result);
            if (socket.Connected)
            {
                stream = socket.GetStream();
                receivedData = new Packet();
                stream.BeginRead(receiveBuffer, 0, dataBufferSize, ReceiveCallback, null);
            }
        }

        public void SendData(Packet packet)
        {
            try
            {
                if (socket != null)
                {
                    stream.BeginWrite(packet.ToArray(), 0, packet.Length(), null, null);
                }
            }
            catch (Exception arg)
            {
                Debug.Log($"Error sending data to server via TCP: {arg}");
            }
        }

        private void ReceiveCallback(IAsyncResult result)
        {
            try
            {
                int num = stream.EndRead(result);
                if (num <= 0)
                {
                    instance.Disconnect();
                    return;
                }
                byte[] array = new byte[num];
                Array.Copy(receiveBuffer, array, num);
                receivedData.Reset(HandleData(array));
                stream.BeginRead(receiveBuffer, 0, dataBufferSize, ReceiveCallback, null);
            }
            catch
            {
                Disconnect();
            }
        }

        private bool HandleData(byte[] data)
        {
            packetsReceived++;
            int packetLength = 0;
            receivedData.SetBytes(data);
            if (receivedData.UnreadLength() >= 4)
            {
                packetLength = receivedData.ReadInt();
                if (packetLength <= 0)
                {
                    return true;
                }
            }
            while (packetLength > 0 && packetLength <= receivedData.UnreadLength())
            {
                byte[] packetBytes = receivedData.ReadBytes(packetLength);
                ThreadManagerClient.ExecuteOnMainThread(delegate
                {
                    using (Packet packet = new Packet(packetBytes))
                    {
                        int num = packet.ReadInt();
                        byteDown += packetLength;
                        Debug.Log("received packet: " + (ServerPackets)num);
                        packetHandlers[num](packet);
                    }
                });
                packetLength = 0;
                if (receivedData.UnreadLength() >= 4)
                {
                    packetLength = receivedData.ReadInt();
                    if (packetLength <= 0)
                    {
                        return true;
                    }
                }
            }
            if (packetLength <= 1)
            {
                return true;
            }
            return false;
        }

        private void Disconnect()
        {
            instance.Disconnect();
            stream = null;
            receivedData = null;
            receiveBuffer = null;
            socket = null;
        }
    }

    public class UDP
    {
        public UdpClient socket;

        public IPEndPoint endPoint;

        public UDP()
        {
            endPoint = new IPEndPoint(IPAddress.Parse(instance.ip), instance.port);
        }

        public void Connect(int localPort)
        {
            socket = new UdpClient(localPort);
            socket.Connect(endPoint);
            socket.BeginReceive(ReceiveCallback, null);
            using (Packet packet = new Packet())
            {
                SendData(packet);
            }
        }

        public void SendData(Packet packet)
        {
            try
            {
                packet.InsertInt(instance.myId);
                if (socket != null)
                {
                    socket.BeginSend(packet.ToArray(), packet.Length(), null, null);
                }
            }
            catch (Exception arg)
            {
                Debug.Log($"Error sending data to server via UDP: {arg}");
            }
        }

        private void ReceiveCallback(IAsyncResult result)
        {
            try
            {
                byte[] array = socket.EndReceive(result, ref endPoint);
                socket.BeginReceive(ReceiveCallback, null);
                if (array.Length < 4)
                {
                    instance.Disconnect();
                    Debug.Log("UDP failed due to packets being split, in Client class");
                }
                else
                {
                    HandleData(array);
                }
            }
            catch
            {
                Disconnect();
            }
        }

        private void HandleData(byte[] data)
        {
            packetsReceived++;
            using (Packet packet = new Packet(data))
            {
                int num = packet.ReadInt();
                byteDown += num;
                data = packet.ReadBytes(num);
            }
            ThreadManagerClient.ExecuteOnMainThread(delegate
            {
                using (Packet packet2 = new Packet(data))
                {
                    int key = packet2.ReadInt();
                    packetHandlers[key](packet2);
                }
            });
        }

        private void Disconnect()
        {
            instance.Disconnect();
            endPoint = null;
            socket = null;
        }
    }

    public static LocalClient instance;

    public static int dataBufferSize = 4096;

    public SteamId serverHost;

    public string ip = "127.0.0.1";

    public int port = 26950;

    public int myId;

    public TCP tcp;

    public UDP udp;

    public static bool serverOwner;

    private bool isConnected;

    public static Dictionary<int, PacketHandler> packetHandlers;

    public static int byteDown;

    public static int packetsReceived;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            Debug.Log("Instance already exists, destroying object");
            UnityEngine.Object.Destroy(this);
        }
    }

    private void Start()
    {
        StartProtocols();
    }

    private void StartProtocols()
    {
        tcp = new TCP();
        udp = new UDP();
    }

    public void ConnectToServer(string ip, string username)
    {
        this.ip = ip;
        StartProtocols();
        InitializeClientData();
        isConnected = true;
        tcp.Connect();
    }

    public static void InitializeClientData()
    {
        packetHandlers = new Dictionary<int, PacketHandler>
        {
            { (int)ServerPackets.welcome, ClientHandle.Welcome },
            { (int)ServerPackets.spawnPlayer, ClientHandle.SpawnPlayer },
            { (int)ServerPackets.playerPosition, ClientHandle.PlayerPosition },
            { (int)ServerPackets.playerRotation, ClientHandle.PlayerRotation },
            { (int)ServerPackets.playerDisconnect, ClientHandle.DisconnectPlayer },
            { (int)ServerPackets.playerKick, ClientHandle.KickPlayer },
            { (int)ServerPackets.playerDied, ClientHandle.PlayerDied },
            { (int)ServerPackets.pingPlayer, ClientHandle.ReceivePing },
            { (int)ServerPackets.connectionSuccessful, ClientHandle.ConnectionEstablished },
            // sendLevel
            { (int)ServerPackets.sendStatus, ClientHandle.ReceiveStatus },
            { (int)ServerPackets.gameOver, ClientHandle.GameOver },
            { (int)ServerPackets.startGame, ClientHandle.StartGame },
            { (int)ServerPackets.clock, ClientHandle.Clock },
            { (int)ServerPackets.openDoor, ClientHandle.OpenDoor },
            { (int)ServerPackets.ready, ClientHandle.Ready },
            // taskProgress
            { (int)ServerPackets.dropItem, ClientHandle.DropItem },
            { (int)ServerPackets.pickupItem, ClientHandle.PickupItem },
            { (int)ServerPackets.weaponInHand, ClientHandle.WeaponInHand },
            { (int)ServerPackets.playerHitObject, ClientHandle.PlayerHitObject },
            { (int)ServerPackets.dropResources, ClientHandle.DropResources },
            { (int)ServerPackets.animationUpdate, ClientHandle.AnimationUpdate },
            { (int)ServerPackets.finalizeBuild, ClientHandle.FinalizeBuild },
            { (int)ServerPackets.openChest, ClientHandle.OpenChest },
            { (int)ServerPackets.updateChest, ClientHandle.UpdateChest },
            { (int)ServerPackets.pickupInteract, ClientHandle.PickupInteract },
            { (int)ServerPackets.dropItemAtPosition, ClientHandle.DropItemAtPosition },
            { (int)ServerPackets.playerHit, ClientHandle.PlayerHit },
            { (int)ServerPackets.mobSpawn, ClientHandle.MobSpawn },
            { (int)ServerPackets.mobMove, ClientHandle.MobMove },
            { (int)ServerPackets.mobSetDestination, ClientHandle.MobSetDestination },
            { (int)ServerPackets.mobAttack, ClientHandle.MobAttack },
            { (int)ServerPackets.playerDamageMob, ClientHandle.PlayerDamageMob },
            { (int)ServerPackets.shrineCombatStart, ClientHandle.ShrineCombatStart },
            { (int)ServerPackets.dropPowerupAtPosition, ClientHandle.DropPowerupAtPosition },
            { (int)ServerPackets.MobZoneSpawn, ClientHandle.MobZoneSpawn },
            { (int)ServerPackets.MobZoneToggle, ClientHandle.MobZoneToggle },
            { (int)ServerPackets.PickupZoneSpawn, ClientHandle.PickupSpawnZone },
            { (int)ServerPackets.SendMessage, ClientHandle.ReceiveChatMessage },
            { (int)ServerPackets.playerPing, ClientHandle.ReceivePlayerPing },
            { (int)ServerPackets.sendArmor, ClientHandle.ReceivePlayerArmor },
            { (int)ServerPackets.playerHp, ClientHandle.PlayerHp },
            { (int)ServerPackets.respawnPlayer, ClientHandle.RespawnPlayer },
            { (int)ServerPackets.shootArrow, ClientHandle.ShootArrowFromPlayer },
            { (int)ServerPackets.removeResource, ClientHandle.RemoveResource },
            { (int)ServerPackets.mobProjectile, ClientHandle.MobSpawnProjectile },
            { (int)ServerPackets.newDay, ClientHandle.NewDay },
            { (int)ServerPackets.knockbackMob, ClientHandle.KnockbackMob },
            { (int)ServerPackets.spawnEffect, ClientHandle.SpawnEffect },
            { (int)ServerPackets.playerFinishedLoading, ClientHandle.PlayerFinishedLoading },
            { (int)ServerPackets.revivePlayer, ClientHandle.RevivePlayer },
            { (int)ServerPackets.spawnGrave, ClientHandle.SpawnGrave },
            { (int)ServerPackets.interact, ClientHandle.Interact },
            { (int)ServerPackets.setTarget, ClientHandle.MobSetTarget },
            { (int)ServerPackets.shipUpdate, ClientHandle.ShipUpdate },
            { (int)ServerPackets.dragonUpdate, ClientHandle.DragonUpdate },
            { (int)ServerPackets.sendStats, ClientHandle.ReceiveStats },
        };
        Debug.Log("Initializing packets.");
    }

    private void OnApplicationQuit()
    {
        Disconnect();
    }

    public void Disconnect()
    {
        if (isConnected)
        {
            ClientSend.PlayerDisconnect();
            isConnected = false;
            tcp.socket.Close();
            udp.socket.Close();
            Debug.Log("Disconnected from server.");
        }
    }
}
