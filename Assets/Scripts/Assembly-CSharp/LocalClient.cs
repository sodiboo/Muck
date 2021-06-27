using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

// Token: 0x020000B9 RID: 185
public class LocalClient : MonoBehaviour
{
	// Token: 0x06000557 RID: 1367 RVA: 0x0001BA23 File Offset: 0x00019C23
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

	// Token: 0x06000558 RID: 1368 RVA: 0x0001BA56 File Offset: 0x00019C56
	private void Start()
	{
		this.StartProtocols();
	}

	// Token: 0x06000559 RID: 1369 RVA: 0x0001BA5E File Offset: 0x00019C5E
	private void StartProtocols()
	{
		this.tcp = new LocalClient.TCP();
		this.udp = new LocalClient.UDP();
	}

	// Token: 0x0600055A RID: 1370 RVA: 0x0001BA76 File Offset: 0x00019C76
	public void ConnectToServer(string ip, string username)
	{
		this.ip = ip;
		this.StartProtocols();
		LocalClient.InitializeClientData();
		this.isConnected = true;
		this.tcp.Connect();
	}

	// Token: 0x0600055B RID: 1371 RVA: 0x0001BA9C File Offset: 0x00019C9C
	public static void InitializeClientData()
	{
		LocalClient.packetHandlers = new Dictionary<int, LocalClient.PacketHandler>
		{
			{
				1,
				new LocalClient.PacketHandler(ClientHandle.Welcome)
			},
			{
				2,
				new LocalClient.PacketHandler(ClientHandle.SpawnPlayer)
			},
			{
				3,
				new LocalClient.PacketHandler(ClientHandle.PlayerPosition)
			},
			{
				4,
				new LocalClient.PacketHandler(ClientHandle.PlayerRotation)
			},
			{
				7,
				new LocalClient.PacketHandler(ClientHandle.ReceivePing)
			},
			{
				10,
				new LocalClient.PacketHandler(ClientHandle.ReceiveStatus)
			},
			{
				13,
				new LocalClient.PacketHandler(ClientHandle.Clock)
			},
			{
				50,
				new LocalClient.PacketHandler(ClientHandle.PlayerFinishedLoading)
			},
			{
				8,
				new LocalClient.PacketHandler(ClientHandle.ConnectionEstablished)
			},
			{
				11,
				new LocalClient.PacketHandler(ClientHandle.GameOver)
			},
			{
				55,
				new LocalClient.PacketHandler(ClientHandle.ShipUpdate)
			},
			{
				56,
				new LocalClient.PacketHandler(ClientHandle.DragonUpdate)
			},
			{
				5,
				new LocalClient.PacketHandler(ClientHandle.DisconnectPlayer)
			},
			{
				6,
				new LocalClient.PacketHandler(ClientHandle.PlayerDied)
			},
			{
				52,
				new LocalClient.PacketHandler(ClientHandle.SpawnGrave)
			},
			{
				15,
				new LocalClient.PacketHandler(ClientHandle.Ready)
			},
			{
				12,
				new LocalClient.PacketHandler(ClientHandle.StartGame)
			},
			{
				14,
				new LocalClient.PacketHandler(ClientHandle.OpenDoor)
			},
			{
				17,
				new LocalClient.PacketHandler(ClientHandle.DropItem)
			},
			{
				21,
				new LocalClient.PacketHandler(ClientHandle.DropResources)
			},
			{
				18,
				new LocalClient.PacketHandler(ClientHandle.PickupItem)
			},
			{
				49,
				new LocalClient.PacketHandler(ClientHandle.SpawnEffect)
			},
			{
				19,
				new LocalClient.PacketHandler(ClientHandle.WeaponInHand)
			},
			{
				20,
				new LocalClient.PacketHandler(ClientHandle.PlayerHitObject)
			},
			{
				45,
				new LocalClient.PacketHandler(ClientHandle.RemoveResource)
			},
			{
				42,
				new LocalClient.PacketHandler(ClientHandle.PlayerHp)
			},
			{
				43,
				new LocalClient.PacketHandler(ClientHandle.RespawnPlayer)
			},
			{
				28,
				new LocalClient.PacketHandler(ClientHandle.PlayerHit)
			},
			{
				22,
				new LocalClient.PacketHandler(ClientHandle.AnimationUpdate)
			},
			{
				44,
				new LocalClient.PacketHandler(ClientHandle.ShootArrowFromPlayer)
			},
			{
				23,
				new LocalClient.PacketHandler(ClientHandle.FinalizeBuild)
			},
			{
				24,
				new LocalClient.PacketHandler(ClientHandle.OpenChest)
			},
			{
				25,
				new LocalClient.PacketHandler(ClientHandle.UpdateChest)
			},
			{
				26,
				new LocalClient.PacketHandler(ClientHandle.PickupInteract)
			},
			{
				27,
				new LocalClient.PacketHandler(ClientHandle.DropItemAtPosition)
			},
			{
				35,
				new LocalClient.PacketHandler(ClientHandle.DropPowerupAtPosition)
			},
			{
				29,
				new LocalClient.PacketHandler(ClientHandle.MobSpawn)
			},
			{
				30,
				new LocalClient.PacketHandler(ClientHandle.MobMove)
			},
			{
				31,
				new LocalClient.PacketHandler(ClientHandle.MobSetDestination)
			},
			{
				54,
				new LocalClient.PacketHandler(ClientHandle.MobSetTarget)
			},
			{
				32,
				new LocalClient.PacketHandler(ClientHandle.MobAttack)
			},
			{
				46,
				new LocalClient.PacketHandler(ClientHandle.MobSpawnProjectile)
			},
			{
				33,
				new LocalClient.PacketHandler(ClientHandle.PlayerDamageMob)
			},
			{
				48,
				new LocalClient.PacketHandler(ClientHandle.KnockbackMob)
			},
			{
				53,
				new LocalClient.PacketHandler(ClientHandle.Interact)
			},
			{
				34,
				new LocalClient.PacketHandler(ClientHandle.ShrineCombatStart)
			},
			{
				51,
				new LocalClient.PacketHandler(ClientHandle.RevivePlayer)
			},
			{
				37,
				new LocalClient.PacketHandler(ClientHandle.MobZoneToggle)
			},
			{
				36,
				new LocalClient.PacketHandler(ClientHandle.MobZoneSpawn)
			},
			{
				38,
				new LocalClient.PacketHandler(ClientHandle.PickupSpawnZone)
			},
			{
				39,
				new LocalClient.PacketHandler(ClientHandle.ReceiveChatMessage)
			},
			{
				40,
				new LocalClient.PacketHandler(ClientHandle.ReceivePlayerPing)
			},
			{
				41,
				new LocalClient.PacketHandler(ClientHandle.ReceivePlayerArmor)
			},
			{
				47,
				new LocalClient.PacketHandler(ClientHandle.NewDay)
			}
		};
		Debug.Log("Initializing packets.");
	}

	// Token: 0x0600055C RID: 1372 RVA: 0x0001BEED File Offset: 0x0001A0ED
	private void OnApplicationQuit()
	{
		this.Disconnect();
	}

	// Token: 0x0600055D RID: 1373 RVA: 0x0001BEF5 File Offset: 0x0001A0F5
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

	// Token: 0x040004A3 RID: 1187
	public static LocalClient instance;

	// Token: 0x040004A4 RID: 1188
	public static int dataBufferSize = 4096;

	// Token: 0x040004A5 RID: 1189
	public SteamId serverHost;

	// Token: 0x040004A6 RID: 1190
	public string ip = "127.0.0.1";

	// Token: 0x040004A7 RID: 1191
	public int port = 26950;

	// Token: 0x040004A8 RID: 1192
	public int myId;

	// Token: 0x040004A9 RID: 1193
	public LocalClient.TCP tcp;

	// Token: 0x040004AA RID: 1194
	public LocalClient.UDP udp;

	// Token: 0x040004AB RID: 1195
	public static bool serverOwner;

	// Token: 0x040004AC RID: 1196
	private bool isConnected;

	// Token: 0x040004AD RID: 1197
	public static Dictionary<int, LocalClient.PacketHandler> packetHandlers;

	// Token: 0x040004AE RID: 1198
	public static int byteDown;

	// Token: 0x040004AF RID: 1199
	public static int packetsReceived;

	// Token: 0x0200015F RID: 351
	// (Invoke) Token: 0x06000905 RID: 2309
	public delegate void PacketHandler(Packet packet);

	// Token: 0x02000160 RID: 352
	public class TCP
	{
		// Token: 0x06000908 RID: 2312 RVA: 0x0002C588 File Offset: 0x0002A788
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

		// Token: 0x06000909 RID: 2313 RVA: 0x0002C5F8 File Offset: 0x0002A7F8
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

		// Token: 0x0600090A RID: 2314 RVA: 0x0002C660 File Offset: 0x0002A860
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

		// Token: 0x0600090B RID: 2315 RVA: 0x0002C6B8 File Offset: 0x0002A8B8
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

		// Token: 0x0600090C RID: 2316 RVA: 0x0002C748 File Offset: 0x0002A948
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

		// Token: 0x0600090D RID: 2317 RVA: 0x0002C84F File Offset: 0x0002AA4F
		private void Disconnect()
		{
			LocalClient.instance.Disconnect();
			this.stream = null;
			this.receivedData = null;
			this.receiveBuffer = null;
			this.socket = null;
		}

		// Token: 0x0400090E RID: 2318
		public TcpClient socket;

		// Token: 0x0400090F RID: 2319
		private NetworkStream stream;

		// Token: 0x04000910 RID: 2320
		private Packet receivedData;

		// Token: 0x04000911 RID: 2321
		private byte[] receiveBuffer;
	}

	// Token: 0x02000161 RID: 353
	public class UDP
	{
		// Token: 0x0600090F RID: 2319 RVA: 0x0002C877 File Offset: 0x0002AA77
		public UDP()
		{
			this.endPoint = new IPEndPoint(IPAddress.Parse(LocalClient.instance.ip), LocalClient.instance.port);
		}

		// Token: 0x06000910 RID: 2320 RVA: 0x0002C8A4 File Offset: 0x0002AAA4
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

		// Token: 0x06000911 RID: 2321 RVA: 0x0002C910 File Offset: 0x0002AB10
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

		// Token: 0x06000912 RID: 2322 RVA: 0x0002C974 File Offset: 0x0002AB74
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

		// Token: 0x06000913 RID: 2323 RVA: 0x0002C9EC File Offset: 0x0002ABEC
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

		// Token: 0x06000914 RID: 2324 RVA: 0x0002CA70 File Offset: 0x0002AC70
		private void Disconnect()
		{
			LocalClient.instance.Disconnect();
			this.endPoint = null;
			this.socket = null;
		}

		// Token: 0x04000912 RID: 2322
		public UdpClient socket;

		// Token: 0x04000913 RID: 2323
		public IPEndPoint endPoint;
	}
}
