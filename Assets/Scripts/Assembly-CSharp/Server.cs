using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using UnityEngine;


public class Server
{



	public static int MaxPlayers { get; private set; }




	public static int Port { get; private set; }


	public static int GetNextId()
	{
		int result = Server.idCounter;
		Server.idCounter++;
		return result;
	}


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


	public static void InitializeServerData()
	{
		for (int i = 1; i <= Server.MaxPlayers; i++)
		{
			Server.clients.Add(i, new Client(i));
		}
		Server.InitializeServerPackets();
		Debug.Log("Initialized Packets.");
	}


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


	public static void Stop()
	{
		Server.tcpListener.Stop();
		Server.udpListener.Close();
	}


	public static Dictionary<int, Client> clients = new Dictionary<int, Client>();


	public static Dictionary<int, Server.PacketHandler> PacketHandlers;


	public static int idCounter;


	private static TcpListener tcpListener;


	private static UdpClient udpListener;


	public static IPAddress ipAddress = IPAddress.Any;



	public delegate void PacketHandler(int fromClient, Packet packet);
}
