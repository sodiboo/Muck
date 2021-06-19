using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;


public class LocalClient : MonoBehaviour
{

    private void Awake()
    {
        if (LocalClient.instance == null)
        {
            LocalClient.instance = this;
            return;
        }
        if (LocalClient.instance != this)
        {
            Debug.Log("Instance already exists, destroying object");
            Destroy(this);
        }
    }


    private void Start()
    {
        this.StartProtocols();
    }


    private void StartProtocols()
    {
        this.tcp = new LocalClient.TCP();
        this.udp = new LocalClient.UDP();
    }


    public void ConnectToServer(string ip, string username)
    {
        this.ip = ip;
        this.StartProtocols();
        LocalClient.InitializeClientData();
        this.isConnected = true;
        this.tcp.Connect();
    }


    public static void InitializeClientData()
    {
        LocalClient.packetHandlers = new Dictionary<int, LocalClient.PacketHandler>
        {
            { (int)ServerPackets.welcome, new LocalClient.PacketHandler(ClientHandle.Welcome) },
            { (int)ServerPackets.spawnPlayer, new LocalClient.PacketHandler(ClientHandle.SpawnPlayer) },
            { (int)ServerPackets.playerPosition, new LocalClient.PacketHandler(ClientHandle.PlayerPosition) },
            { (int)ServerPackets.playerRotation, new LocalClient.PacketHandler(ClientHandle.PlayerRotation) },
            { (int)ServerPackets.playerDisconnect, new LocalClient.PacketHandler(ClientHandle.DisconnectPlayer) },
            { (int)ServerPackets.playerDied, new LocalClient.PacketHandler(ClientHandle.PlayerDied) },
            { (int)ServerPackets.pingPlayer, new LocalClient.PacketHandler(ClientHandle.ReceivePing) },
            { (int)ServerPackets.connectionSuccessful, new LocalClient.PacketHandler(ClientHandle.ConnectionEstablished) },
            // ServerPackets.sendLevel
            { (int)ServerPackets.sendStatus, new LocalClient.PacketHandler(ClientHandle.ReceiveStatus) },
            { (int)ServerPackets.gameOver, new LocalClient.PacketHandler(ClientHandle.GameOver) },
            { (int)ServerPackets.startGame, new LocalClient.PacketHandler(ClientHandle.StartGame) },
            { (int)ServerPackets.clock, new LocalClient.PacketHandler(ClientHandle.Clock) },
            { (int)ServerPackets.openDoor, new LocalClient.PacketHandler(ClientHandle.OpenDoor) },
            { (int)ServerPackets.ready, new LocalClient.PacketHandler(ClientHandle.Ready) },
            // ServerPackets.taskProgress
            { (int)ServerPackets.dropItem, new LocalClient.PacketHandler(ClientHandle.DropItem) },
            { (int)ServerPackets.pickupItem, new LocalClient.PacketHandler(ClientHandle.PickupItem) },
            { (int)ServerPackets.weaponInHand, new LocalClient.PacketHandler(ClientHandle.WeaponInHand) },
            { (int)ServerPackets.playerHitObject, new LocalClient.PacketHandler(ClientHandle.PlayerHitObject) },
            { (int)ServerPackets.dropResources, new LocalClient.PacketHandler(ClientHandle.DropResources) },
            { (int)ServerPackets.animationUpdate, new LocalClient.PacketHandler(ClientHandle.AnimationUpdate) },
            { (int)ServerPackets.finalizeBuild, new LocalClient.PacketHandler(ClientHandle.FinalizeBuild) },
            { (int)ServerPackets.openChest, new LocalClient.PacketHandler(ClientHandle.OpenChest) },
            { (int)ServerPackets.updateChest, new LocalClient.PacketHandler(ClientHandle.UpdateChest) },
            { (int)ServerPackets.pickupInteract, new LocalClient.PacketHandler(ClientHandle.PickupInteract) },
            { (int)ServerPackets.dropItemAtPosition, new LocalClient.PacketHandler(ClientHandle.DropItemAtPosition) },
            { (int)ServerPackets.playerHit, new LocalClient.PacketHandler(ClientHandle.PlayerHit) },
            { (int)ServerPackets.mobSpawn, new LocalClient.PacketHandler(ClientHandle.MobSpawn) },
            { (int)ServerPackets.mobMove, new LocalClient.PacketHandler(ClientHandle.MobMove) },
            { (int)ServerPackets.mobSetDestination, new LocalClient.PacketHandler(ClientHandle.MobSetDestination) },
            { (int)ServerPackets.mobAttack, new LocalClient.PacketHandler(ClientHandle.MobAttack) },
            { (int)ServerPackets.playerDamageMob, new LocalClient.PacketHandler(ClientHandle.PlayerDamageMob) },
            { (int)ServerPackets.shrineCombatStart, new LocalClient.PacketHandler(ClientHandle.ShrineCombatStart) },
            { (int)ServerPackets.dropPowerupAtPosition, new LocalClient.PacketHandler(ClientHandle.DropPowerupAtPosition) },
            { (int)ServerPackets.MobZoneSpawn, new LocalClient.PacketHandler(ClientHandle.MobZoneSpawn) },
            { (int)ServerPackets.MobZoneToggle, new LocalClient.PacketHandler(ClientHandle.MobZoneToggle) },
            { (int)ServerPackets.PickupZoneSpawn, new LocalClient.PacketHandler(ClientHandle.PickupSpawnZone) },
            { (int)ServerPackets.SendMessage, new LocalClient.PacketHandler(ClientHandle.ReceiveChatMessage) },
            { (int)ServerPackets.playerPing, new LocalClient.PacketHandler(ClientHandle.ReceivePlayerPing) },
            { (int)ServerPackets.sendArmor, new LocalClient.PacketHandler(ClientHandle.ReceivePlayerArmor) },
            { (int)ServerPackets.playerHp, new LocalClient.PacketHandler(ClientHandle.PlayerHp) },
            { (int)ServerPackets.respawnPlayer, new LocalClient.PacketHandler(ClientHandle.RespawnPlayer) },
            { (int)ServerPackets.shootArrow, new LocalClient.PacketHandler(ClientHandle.ShootArrowFromPlayer) },
            { (int)ServerPackets.removeResource, new LocalClient.PacketHandler(ClientHandle.RemoveResource) },
            { (int)ServerPackets.mobProjectile, new LocalClient.PacketHandler(ClientHandle.MobSpawnProjectile) },
            { (int)ServerPackets.newDay, new LocalClient.PacketHandler(ClientHandle.NewDay) },
            { (int)ServerPackets.knockbackMob, new LocalClient.PacketHandler(ClientHandle.KnockbackMob) },
            { (int)ServerPackets.spawnEffect, new LocalClient.PacketHandler(ClientHandle.SpawnEffect) },
            { (int)ServerPackets.playerFinishedLoading, new LocalClient.PacketHandler(ClientHandle.PlayerFinishedLoading) },
            { (int)ServerPackets.revivePlayer, new LocalClient.PacketHandler(ClientHandle.RevivePlayer) },
            { (int)ServerPackets.spawnGrave, new LocalClient.PacketHandler(ClientHandle.SpawnGrave) },
            { (int)ServerPackets.interact, new LocalClient.PacketHandler(ClientHandle.Interact) },
            { (int)ServerPackets.setTarget, new LocalClient.PacketHandler(ClientHandle.MobSetTarget) },

            { (int)ServerPackets.moveVehicle, ClientHandle.UpdateCar },
            { (int)ServerPackets.enterVehicle, ClientHandle.EnterVehicle },
			{ (int)ServerPackets.exitVehicle, ClientHandle.ExitVehicle },
        };
        Debug.Log("Initializing packets.");
    }


    private void OnApplicationQuit()
    {
        this.Disconnect();
    }


    public void Disconnect()
    {
        if (this.isConnected)
        {
            ClientSend.PlayerDisconnect();
            this.isConnected = false;
            this.tcp.socket.Close();
            this.udp.socket.Close();
            Debug.Log("Disconnected from server.");
        }
    }


    public static LocalClient instance;


    public static int dataBufferSize = 4096;


    public SteamId serverHost;


    public string ip = "127.0.0.1";


    public int port = 26950;


    public int myId;


    public LocalClient.TCP tcp;


    public LocalClient.UDP udp;


    public static bool serverOwner;


    private bool isConnected;


    public static Dictionary<int, LocalClient.PacketHandler> packetHandlers;


    public static int byteDown;


    public static int packetsReceived;



    public delegate void PacketHandler(Packet packet);


    public class TCP
    {

        public void Connect()
        {
            this.socket = new TcpClient
            {
                ReceiveBufferSize = LocalClient.dataBufferSize,
                SendBufferSize = LocalClient.dataBufferSize
            };
            this.receiveBuffer = new byte[LocalClient.dataBufferSize];
            this.socket.BeginConnect(LocalClient.instance.ip, LocalClient.instance.port, new AsyncCallback(this.ConnectCallback), this.socket);
        }


        private void ConnectCallback(IAsyncResult result)
        {
            this.socket.EndConnect(result);
            if (!this.socket.Connected)
            {
                return;
            }
            this.stream = this.socket.GetStream();
            this.receivedData = new Packet();
            this.stream.BeginRead(this.receiveBuffer, 0, LocalClient.dataBufferSize, new AsyncCallback(this.ReceiveCallback), null);
        }


        public void SendData(Packet packet)
        {
            try
            {
                if (this.socket != null)
                {
                    this.stream.BeginWrite(packet.ToArray(), 0, packet.Length(), null, null);
                }
            }
            catch (Exception arg)
            {
                Debug.Log(string.Format("Error sending data to server via TCP: {0}", arg));
            }
        }


        private void ReceiveCallback(IAsyncResult result)
        {
            try
            {
                int num = this.stream.EndRead(result);
                if (num <= 0)
                {
                    LocalClient.instance.Disconnect();
                }
                else
                {
                    byte[] array = new byte[num];
                    Array.Copy(this.receiveBuffer, array, num);
                    this.receivedData.Reset(this.HandleData(array));
                    this.stream.BeginRead(this.receiveBuffer, 0, LocalClient.dataBufferSize, new AsyncCallback(this.ReceiveCallback), null);
                }
            }
            catch
            {
                this.Disconnect();
            }
        }


        private bool HandleData(byte[] data)
        {
            LocalClient.packetsReceived++;
            int packetLength = 0;
            this.receivedData.SetBytes(data);
            if (this.receivedData.UnreadLength() >= 4)
            {
                packetLength = this.receivedData.ReadInt(true);
                if (packetLength <= 0)
                {
                    return true;
                }
            }
            while (packetLength > 0 && packetLength <= this.receivedData.UnreadLength())
            {
                byte[] packetBytes = this.receivedData.ReadBytes(packetLength, true);
                ThreadManagerClient.ExecuteOnMainThread(delegate
                {
                    using (Packet packet = new Packet(packetBytes))
                    {
                        int num = packet.ReadInt(true);
                        LocalClient.byteDown += packetLength;
                        Debug.Log("received packet: " + (ServerPackets)num);
                        LocalClient.packetHandlers[num](packet);
                    }
                });
                packetLength = 0;
                if (this.receivedData.UnreadLength() >= 4)
                {
                    packetLength = this.receivedData.ReadInt(true);
                    if (packetLength <= 0)
                    {
                        return true;
                    }
                }
            }
            return packetLength <= 1;
        }


        private void Disconnect()
        {
            LocalClient.instance.Disconnect();
            this.stream = null;
            this.receivedData = null;
            this.receiveBuffer = null;
            this.socket = null;
        }


        public TcpClient socket;


        private NetworkStream stream;


        private Packet receivedData;


        private byte[] receiveBuffer;
    }


    public class UDP
    {

        public UDP()
        {
            this.endPoint = new IPEndPoint(IPAddress.Parse(LocalClient.instance.ip), LocalClient.instance.port);
        }


        public void Connect(int localPort)
        {
            this.socket = new UdpClient(localPort);
            this.socket.Connect(this.endPoint);
            this.socket.BeginReceive(new AsyncCallback(this.ReceiveCallback), null);
            using (Packet packet = new Packet())
            {
                this.SendData(packet);
            }
        }


        public void SendData(Packet packet)
        {
            try
            {
                packet.InsertInt(LocalClient.instance.myId);
                if (this.socket != null)
                {
                    this.socket.BeginSend(packet.ToArray(), packet.Length(), null, null);
                }
            }
            catch (Exception arg)
            {
                Debug.Log(string.Format("Error sending data to server via UDP: {0}", arg));
            }
        }


        private void ReceiveCallback(IAsyncResult result)
        {
            try
            {
                byte[] array = this.socket.EndReceive(result, ref this.endPoint);
                this.socket.BeginReceive(new AsyncCallback(this.ReceiveCallback), null);
                if (array.Length < 4)
                {
                    LocalClient.instance.Disconnect();
                    Debug.Log("UDP failed due to packets being split, in Client class");
                }
                else
                {
                    this.HandleData(array);
                }
            }
            catch
            {
                this.Disconnect();
            }
        }


        private void HandleData(byte[] data)
        {
            LocalClient.packetsReceived++;
            using (Packet packet = new Packet(data))
            {
                int num = packet.ReadInt(true);
                LocalClient.byteDown += num;
                data = packet.ReadBytes(num, true);
            }
            ThreadManagerClient.ExecuteOnMainThread(delegate
            {
                using (Packet packet2 = new Packet(data))
                {
                    int key = packet2.ReadInt(true);
                    LocalClient.packetHandlers[key](packet2);
                }
            });
        }


        private void Disconnect()
        {
            LocalClient.instance.Disconnect();
            this.endPoint = null;
            this.socket = null;
        }


        public UdpClient socket;


        public IPEndPoint endPoint;
    }
}
