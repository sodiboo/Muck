using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

// Token: 0x020000BA RID: 186
public class LocalClient : MonoBehaviour
{
	// Token: 0x060004BB RID: 1211 RVA: 0x00005185 File Offset: 0x00003385
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

	// Token: 0x060004BC RID: 1212 RVA: 0x000051B8 File Offset: 0x000033B8
	private void Start()
	{
		this.StartProtocols();
	}

	// Token: 0x060004BD RID: 1213 RVA: 0x000051C0 File Offset: 0x000033C0
	private void StartProtocols()
	{
		this.tcp = new LocalClient.TCP();
		this.udp = new LocalClient.UDP();
	}

	// Token: 0x060004BE RID: 1214 RVA: 0x000051D8 File Offset: 0x000033D8
	public void ConnectToServer(string ip, string username)
	{
		this.ip = ip;
		this.StartProtocols();
		LocalClient.InitializeClientData();
		this.isConnected = true;
		this.tcp.Connect();
	}

	// Token: 0x060004BF RID: 1215 RVA: 0x0001A250 File Offset: 0x00018450
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

	// Token: 0x060004C0 RID: 1216 RVA: 0x000051FE File Offset: 0x000033FE
	private void OnApplicationQuit()
	{
		this.Disconnect();
	}

	// Token: 0x060004C1 RID: 1217 RVA: 0x00005206 File Offset: 0x00003406
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

	// Token: 0x04000457 RID: 1111
	public static LocalClient instance;

	// Token: 0x04000458 RID: 1112
	public static int dataBufferSize = 4096;

	// Token: 0x04000459 RID: 1113
	public SteamId serverHost;

	// Token: 0x0400045A RID: 1114
	public string ip = "127.0.0.1";

	// Token: 0x0400045B RID: 1115
	public int port = 26950;

	// Token: 0x0400045C RID: 1116
	public int myId;

	// Token: 0x0400045D RID: 1117
	public LocalClient.TCP tcp;

	// Token: 0x0400045E RID: 1118
	public LocalClient.UDP udp;

	// Token: 0x0400045F RID: 1119
	public static bool serverOwner;

	// Token: 0x04000460 RID: 1120
	private bool isConnected;

	// Token: 0x04000461 RID: 1121
	public static Dictionary<int, LocalClient.PacketHandler> packetHandlers;

	// Token: 0x04000462 RID: 1122
	public static int byteDown;

	// Token: 0x04000463 RID: 1123
	public static int packetsReceived;

	// Token: 0x020000BB RID: 187
	// (Invoke) Token: 0x060004C5 RID: 1221
	public delegate void PacketHandler(Packet packet);

	// Token: 0x020000BC RID: 188
	public class TCP
	{
		// Token: 0x060004C8 RID: 1224 RVA: 0x0001A67C File Offset: 0x0001887C
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

		// Token: 0x060004C9 RID: 1225 RVA: 0x0001A6EC File Offset: 0x000188EC
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

		// Token: 0x060004CA RID: 1226 RVA: 0x0001A754 File Offset: 0x00018954
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

		// Token: 0x060004CB RID: 1227 RVA: 0x0001A7AC File Offset: 0x000189AC
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

		// Token: 0x060004CC RID: 1228 RVA: 0x0001A83C File Offset: 0x00018A3C
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

		// Token: 0x060004CD RID: 1229 RVA: 0x00005270 File Offset: 0x00003470
		private void Disconnect()
		{
			LocalClient.instance.Disconnect();
			this.stream = null;
			this.receivedData = null;
			this.receiveBuffer = null;
			this.socket = null;
		}

		// Token: 0x04000464 RID: 1124
		public TcpClient socket;

		// Token: 0x04000465 RID: 1125
		private NetworkStream stream;

		// Token: 0x04000466 RID: 1126
		private Packet receivedData;

		// Token: 0x04000467 RID: 1127
		private byte[] receiveBuffer;
	}

	// Token: 0x020000BF RID: 191
	public class UDP
	{
		// Token: 0x060004D2 RID: 1234 RVA: 0x00005298 File Offset: 0x00003498
		public UDP()
		{
			this.endPoint = new IPEndPoint(IPAddress.Parse(LocalClient.instance.ip), LocalClient.instance.port);
		}

		// Token: 0x060004D3 RID: 1235 RVA: 0x0001A9C0 File Offset: 0x00018BC0
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

		// Token: 0x060004D4 RID: 1236 RVA: 0x0001AA2C File Offset: 0x00018C2C
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

		// Token: 0x060004D5 RID: 1237 RVA: 0x0001AA90 File Offset: 0x00018C90
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

		// Token: 0x060004D6 RID: 1238 RVA: 0x0001AB08 File Offset: 0x00018D08
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

		// Token: 0x060004D7 RID: 1239 RVA: 0x000052C4 File Offset: 0x000034C4
		private void Disconnect()
		{
			LocalClient.instance.Disconnect();
			this.endPoint = null;
			this.socket = null;
		}

		// Token: 0x0400046B RID: 1131
		public UdpClient socket;

		// Token: 0x0400046C RID: 1132
		public IPEndPoint endPoint;
	}
}
