using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using UnityEngine;

// Token: 0x020000D3 RID: 211
public class Server
{
	// Token: 0x1700003C RID: 60
	// (get) Token: 0x06000548 RID: 1352 RVA: 0x000057A5 File Offset: 0x000039A5
	// (set) Token: 0x06000549 RID: 1353 RVA: 0x000057AC File Offset: 0x000039AC
	public static int MaxPlayers { get; private set; }

	// Token: 0x1700003D RID: 61
	// (get) Token: 0x0600054A RID: 1354 RVA: 0x000057B4 File Offset: 0x000039B4
	// (set) Token: 0x0600054B RID: 1355 RVA: 0x000057BB File Offset: 0x000039BB
	public static int Port { get; private set; }

	// Token: 0x0600054C RID: 1356 RVA: 0x000057C3 File Offset: 0x000039C3
	public static int GetNextId()
	{
		int result = Server.idCounter;
		Server.idCounter++;
		return result;
	}

	// Token: 0x0600054D RID: 1357 RVA: 0x0001C120 File Offset: 0x0001A320
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

	// Token: 0x0600054E RID: 1358 RVA: 0x0001C1DC File Offset: 0x0001A3DC
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

	// Token: 0x0600054F RID: 1359 RVA: 0x0001C280 File Offset: 0x0001A480
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

	// Token: 0x06000550 RID: 1360 RVA: 0x0001C398 File Offset: 0x0001A598
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

	// Token: 0x06000551 RID: 1361 RVA: 0x0001C3E8 File Offset: 0x0001A5E8
	public static void InitializeServerData()
	{
		for (int i = 1; i <= Server.MaxPlayers; i++)
		{
			Server.clients.Add(i, new Client(i));
		}
		Server.InitializeServerPackets();
		Debug.Log("Initialized Packets.");
	}

	// Token: 0x06000552 RID: 1362 RVA: 0x0001C428 File Offset: 0x0001A628
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
			}
		};
	}

	// Token: 0x06000553 RID: 1363 RVA: 0x000057D6 File Offset: 0x000039D6
	public static void Stop()
	{
		Server.tcpListener.Stop();
		Server.udpListener.Close();
	}

	// Token: 0x040004FF RID: 1279
	public static Dictionary<int, Client> clients = new Dictionary<int, Client>();

	// Token: 0x04000500 RID: 1280
	public static Dictionary<int, Server.PacketHandler> PacketHandlers;

	// Token: 0x04000501 RID: 1281
	public static int idCounter;

	// Token: 0x04000502 RID: 1282
	private static TcpListener tcpListener;

	// Token: 0x04000503 RID: 1283
	private static UdpClient udpListener;

	// Token: 0x04000504 RID: 1284
	public static IPAddress ipAddress = IPAddress.Any;

	// Token: 0x020000D4 RID: 212
	// (Invoke) Token: 0x06000557 RID: 1367
	public delegate void PacketHandler(int fromClient, Packet packet);
}
