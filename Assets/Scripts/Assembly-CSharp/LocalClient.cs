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
