using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

// Token: 0x02000092 RID: 146
public class LocalClient : MonoBehaviour
{
    // Token: 0x0600045A RID: 1114 RVA: 0x00016363 File Offset: 0x00014563
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

    // Token: 0x0600045B RID: 1115 RVA: 0x00016396 File Offset: 0x00014596
    private void Start()
    {
        this.StartProtocols();
    }

    // Token: 0x0600045C RID: 1116 RVA: 0x0001639E File Offset: 0x0001459E
    private void StartProtocols()
    {
        this.tcp = new LocalClient.TCP();
        this.udp = new LocalClient.UDP();
    }

    // Token: 0x0600045D RID: 1117 RVA: 0x000163B6 File Offset: 0x000145B6
    public void ConnectToServer(string ip, string username)
    {
        this.ip = ip;
        this.StartProtocols();
        LocalClient.InitializeClientData();
        this.isConnected = true;
        this.tcp.Connect();
    }

    // Token: 0x0600045E RID: 1118 RVA: 0x000163DC File Offset: 0x000145DC
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
        };
        Debug.Log("Initializing packets.");
    }

    // Token: 0x0600045F RID: 1119 RVA: 0x000167DD File Offset: 0x000149DD
    private void OnApplicationQuit()
    {
        this.Disconnect();
    }

    // Token: 0x06000460 RID: 1120 RVA: 0x000167E5 File Offset: 0x000149E5
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

    // Token: 0x04000394 RID: 916
    public static LocalClient instance;

    // Token: 0x04000395 RID: 917
    public static int dataBufferSize = 4096;

    // Token: 0x04000396 RID: 918
    public SteamId serverHost;

    // Token: 0x04000397 RID: 919
    public string ip = "127.0.0.1";

    // Token: 0x04000398 RID: 920
    public int port = 26950;

    // Token: 0x04000399 RID: 921
    public int myId;

    // Token: 0x0400039A RID: 922
    public LocalClient.TCP tcp;

    // Token: 0x0400039B RID: 923
    public LocalClient.UDP udp;

    // Token: 0x0400039C RID: 924
    public static bool serverOwner;

    // Token: 0x0400039D RID: 925
    private bool isConnected;

    // Token: 0x0400039E RID: 926
    public static Dictionary<int, LocalClient.PacketHandler> packetHandlers;

    // Token: 0x0400039F RID: 927
    public static int byteDown;

    // Token: 0x040003A0 RID: 928
    public static int packetsReceived;

    // Token: 0x02000122 RID: 290
    // (Invoke) Token: 0x060007B1 RID: 1969
    public delegate void PacketHandler(Packet packet);

    // Token: 0x02000123 RID: 291
    public class TCP
    {
        // Token: 0x060007B4 RID: 1972 RVA: 0x00025AB0 File Offset: 0x00023CB0
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

        // Token: 0x060007B5 RID: 1973 RVA: 0x00025B20 File Offset: 0x00023D20
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

        // Token: 0x060007B6 RID: 1974 RVA: 0x00025B88 File Offset: 0x00023D88
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

        // Token: 0x060007B7 RID: 1975 RVA: 0x00025BE0 File Offset: 0x00023DE0
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

        // Token: 0x060007B8 RID: 1976 RVA: 0x00025C70 File Offset: 0x00023E70
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

        // Token: 0x060007B9 RID: 1977 RVA: 0x00025D77 File Offset: 0x00023F77
        private void Disconnect()
        {
            LocalClient.instance.Disconnect();
            this.stream = null;
            this.receivedData = null;
            this.receiveBuffer = null;
            this.socket = null;
        }

        // Token: 0x04000795 RID: 1941
        public TcpClient socket;

        // Token: 0x04000796 RID: 1942
        private NetworkStream stream;

        // Token: 0x04000797 RID: 1943
        private Packet receivedData;

        // Token: 0x04000798 RID: 1944
        private byte[] receiveBuffer;
    }

    // Token: 0x02000124 RID: 292
    public class UDP
    {
        // Token: 0x060007BB RID: 1979 RVA: 0x00025D9F File Offset: 0x00023F9F
        public UDP()
        {
            this.endPoint = new IPEndPoint(IPAddress.Parse(LocalClient.instance.ip), LocalClient.instance.port);
        }

        // Token: 0x060007BC RID: 1980 RVA: 0x00025DCC File Offset: 0x00023FCC
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

        // Token: 0x060007BD RID: 1981 RVA: 0x00025E38 File Offset: 0x00024038
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

        // Token: 0x060007BE RID: 1982 RVA: 0x00025E9C File Offset: 0x0002409C
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

        // Token: 0x060007BF RID: 1983 RVA: 0x00025F14 File Offset: 0x00024114
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

        // Token: 0x060007C0 RID: 1984 RVA: 0x00025F98 File Offset: 0x00024198
        private void Disconnect()
        {
            LocalClient.instance.Disconnect();
            this.endPoint = null;
            this.socket = null;
        }

        // Token: 0x04000799 RID: 1945
        public UdpClient socket;

        // Token: 0x0400079A RID: 1946
        public IPEndPoint endPoint;
    }
}
