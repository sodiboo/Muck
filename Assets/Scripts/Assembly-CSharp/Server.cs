using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using UnityEngine;

// Token: 0x020000C7 RID: 199
public class Server
{
	// Token: 0x17000040 RID: 64
	// (get) Token: 0x060005BF RID: 1471 RVA: 0x0001D590 File Offset: 0x0001B790
	// (set) Token: 0x060005C0 RID: 1472 RVA: 0x0001D597 File Offset: 0x0001B797
	public static int MaxPlayers { get; private set; }

	// Token: 0x17000041 RID: 65
	// (get) Token: 0x060005C1 RID: 1473 RVA: 0x0001D59F File Offset: 0x0001B79F
	// (set) Token: 0x060005C2 RID: 1474 RVA: 0x0001D5A6 File Offset: 0x0001B7A6
	public static int Port { get; private set; }

	// Token: 0x060005C3 RID: 1475 RVA: 0x0001D5AE File Offset: 0x0001B7AE
	public static int GetNextId()
	{
		int result = Server.idCounter;
		Server.idCounter++;
		return result;
	}

	// Token: 0x060005C4 RID: 1476 RVA: 0x0001D5C4 File Offset: 0x0001B7C4
	public static void Start(int maxPlayers, int port)
	{
		Server.MaxPlayers = maxPlayers;
		Server.Port = port;
		Debug.Log("Starting server.. ver.0.7");
		Server.InitializeServerData();
		Server.tcpListener = new TcpListener(Server.ipAddress, Server.Port);
		Debug.Log(string.Format("TclpListener on IP: {0}.", Server.ipAddress));
		Server.tcpListener.Start();
		Server.tcpListener.BeginAcceptTcpClient(new AsyncCallback(Server.TCPConnectCallback), null);
		Server.udpListener = new UdpClient(Server.Port);
		Server.udpListener.BeginReceive(new AsyncCallback(Server.UDPReceiveCallback), null);
		Debug.Log("Server started on port:" + Server.Port);
		ThreadManagerServer.Instance.ResetGame();
	}

	// Token: 0x060005C5 RID: 1477 RVA: 0x0001D680 File Offset: 0x0001B880
	private static void TCPConnectCallback(IAsyncResult result)
	{
		TcpClient tcpClient = Server.tcpListener.EndAcceptTcpClient(result);
		Server.tcpListener.BeginAcceptTcpClient(new AsyncCallback(Server.TCPConnectCallback), null);
		Debug.Log(string.Format("Incoming connection from {0}...", tcpClient.Client.RemoteEndPoint));
		for (int i = 1; i <= Server.MaxPlayers; i++)
		{
			if (Server.clients[i].tcp.socket == null)
			{
				Server.clients[i].tcp.Connect(tcpClient);
				return;
			}
		}
		Debug.Log(string.Format("{0} failed to connect: Server full! f", tcpClient.Client.RemoteEndPoint));
	}

	// Token: 0x060005C6 RID: 1478 RVA: 0x0001D724 File Offset: 0x0001B924
	private static void UDPReceiveCallback(IAsyncResult result)
	{
		try
		{
			IPEndPoint ipendPoint = new IPEndPoint(IPAddress.Any, 0);
			byte[] array = Server.udpListener.EndReceive(result, ref ipendPoint);
			Server.udpListener.BeginReceive(new AsyncCallback(Server.UDPReceiveCallback), null);
			if (array.Length >= 4)
			{
				using (Packet packet = new Packet(array))
				{
					int num = packet.ReadInt(true);
					if (num != 0)
					{
						if (Server.clients[num].udp.endPoint == null)
						{
							Server.clients[num].udp.Connect(ipendPoint);
						}
						else if (Server.clients[num].udp.endPoint.ToString() == ipendPoint.ToString())
						{
							Server.clients[num].udp.HandleData(packet);
						}
					}
				}
			}
		}
		catch (Exception arg)
		{
			Debug.Log(string.Format("Catching error receiving UDP data: {0}", arg));
			Debug.Log("This error message can be ignored if just closing server. Server has been closed successfully.");
		}
	}

	// Token: 0x060005C7 RID: 1479 RVA: 0x0001D83C File Offset: 0x0001BA3C
	public static void SendUDPData(IPEndPoint clientEndPoint, Packet packet)
	{
		try
		{
			if (clientEndPoint != null)
			{
				Server.udpListener.BeginSend(packet.ToArray(), packet.Length(), clientEndPoint, null, null);
			}
		}
		catch (Exception arg)
		{
			Debug.Log(string.Format("Error sending data to {0} via UDP: {1}.", clientEndPoint, arg));
		}
	}

	// Token: 0x060005C8 RID: 1480 RVA: 0x0001D88C File Offset: 0x0001BA8C
	public static void InitializeServerData()
	{
		for (int i = 1; i <= Server.MaxPlayers; i++)
		{
			Server.clients.Add(i, new Client(i));
		}
		Server.InitializeServerPackets();
		Debug.Log("Initialized Packets.");
	}

	// Token: 0x060005C9 RID: 1481 RVA: 0x0001D8CC File Offset: 0x0001BACC
	public static void InitializeServerPackets()
	{
		Server.PacketHandlers = new Dictionary<int, Server.PacketHandler>
		{
			{
				1,
				new Server.PacketHandler(ServerHandle.WelcomeReceived)
			},
			{
				2,
				new Server.PacketHandler(ServerHandle.JoinRequest)
			},
			{
				33,
				new Server.PacketHandler(ServerHandle.StartedLoading)
			},
			{
				29,
				new Server.PacketHandler(ServerHandle.PlayerFinishedLoading)
			},
			{
				5,
				new Server.PacketHandler(ServerHandle.PlayerDisconnect)
			},
			{
				3,
				new Server.PacketHandler(ServerHandle.PlayerPosition)
			},
			{
				26,
				new Server.PacketHandler(ServerHandle.PlayerHp)
			},
			{
				27,
				new Server.PacketHandler(ServerHandle.PlayerDied)
			},
			{
				31,
				new Server.PacketHandler(ServerHandle.RevivePlayer)
			},
			{
				4,
				new Server.PacketHandler(ServerHandle.PlayerRotation)
			},
			{
				6,
				new Server.PacketHandler(ServerHandle.PingReceived)
			},
			{
				9,
				new Server.PacketHandler(ServerHandle.PlayerRequestedSpawns)
			},
			{
				8,
				new Server.PacketHandler(ServerHandle.Ready)
			},
			{
				10,
				new Server.PacketHandler(ServerHandle.ItemDropped)
			},
			{
				11,
				new Server.PacketHandler(ServerHandle.ItemDroppedAtPosition)
			},
			{
				12,
				new Server.PacketHandler(ServerHandle.ItemPickedUp)
			},
			{
				13,
				new Server.PacketHandler(ServerHandle.WeaponInHand)
			},
			{
				15,
				new Server.PacketHandler(ServerHandle.AnimationUpdate)
			},
			{
				28,
				new Server.PacketHandler(ServerHandle.ShootArrow)
			},
			{
				14,
				new Server.PacketHandler(ServerHandle.PlayerHitObject)
			},
			{
				30,
				new Server.PacketHandler(ServerHandle.SpawnEffect)
			},
			{
				20,
				new Server.PacketHandler(ServerHandle.PlayerHit)
			},
			{
				16,
				new Server.PacketHandler(ServerHandle.RequestBuild)
			},
			{
				17,
				new Server.PacketHandler(ServerHandle.RequestChest)
			},
			{
				18,
				new Server.PacketHandler(ServerHandle.UpdateChest)
			},
			{
				19,
				new Server.PacketHandler(ServerHandle.ItemInteract)
			},
			{
				21,
				new Server.PacketHandler(ServerHandle.PlayerDamageMob)
			},
			{
				22,
				new Server.PacketHandler(ServerHandle.ShrineCombatStartRequest)
			},
			{
				32,
				new Server.PacketHandler(ServerHandle.Interact)
			},
			{
				23,
				new Server.PacketHandler(ServerHandle.ReceiveChatMessage)
			},
			{
				24,
				new Server.PacketHandler(ServerHandle.ReceivePing)
			},
			{
				25,
				new Server.PacketHandler(ServerHandle.ReceiveArmor)
			},
			{
				34,
				new Server.PacketHandler(ServerHandle.ReceiveShipUpdate)
			}
		};
	}

	// Token: 0x060005CA RID: 1482 RVA: 0x0001DB70 File Offset: 0x0001BD70
	public static void Stop()
	{
		Server.tcpListener.Stop();
		Server.udpListener.Close();
	}

	// Token: 0x04000532 RID: 1330
	public static Dictionary<int, Client> clients = new Dictionary<int, Client>();

	// Token: 0x04000533 RID: 1331
	public static Dictionary<int, Server.PacketHandler> PacketHandlers;

	// Token: 0x04000534 RID: 1332
	public static int idCounter;

	// Token: 0x04000535 RID: 1333
	private static TcpListener tcpListener;

	// Token: 0x04000536 RID: 1334
	private static UdpClient udpListener;

	// Token: 0x04000537 RID: 1335
	public static IPAddress ipAddress = IPAddress.Any;

	// Token: 0x02000165 RID: 357
	// (Invoke) Token: 0x06000921 RID: 2337
	public delegate void PacketHandler(int fromClient, Packet packet);
}
