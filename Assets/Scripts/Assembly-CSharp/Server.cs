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
			{ (int)ClientPackets.welcomeReceived, ServerHandle.WelcomeReceived },
            { (int)ClientPackets.joinLobby, ServerHandle.JoinRequest },
            { (int)ClientPackets.playerPosition, ServerHandle.PlayerPosition },
            { (int)ClientPackets.playerRotation, ServerHandle.PlayerRotation },
            { (int)ClientPackets.sendDisconnect, ServerHandle.PlayerDisconnect },
            { (int)ClientPackets.sendPing, ServerHandle.PingReceived },
            // ClientPackets.playerKilled
            { (int)ClientPackets.ready, ServerHandle.Ready },
            { (int)ClientPackets.requestSpawns, ServerHandle.PlayerRequestedSpawns },
            { (int)ClientPackets.dropItem, ServerHandle.ItemDropped },
            { (int)ClientPackets.dropItemAtPosition, ServerHandle.ItemDroppedAtPosition },
            { (int)ClientPackets.pickupItem, ServerHandle.ItemPickedUp },
            { (int)ClientPackets.weaponInHand, ServerHandle.WeaponInHand },
            { (int)ClientPackets.playerHitObject, ServerHandle.PlayerHitObject },
            { (int)ClientPackets.animationUpdate, ServerHandle.AnimationUpdate },
            { (int)ClientPackets.requestBuild, ServerHandle.RequestBuild },
            { (int)ClientPackets.requestChest, ServerHandle.RequestChest },
            { (int)ClientPackets.updateChest, ServerHandle.UpdateChest },
            { (int)ClientPackets.pickupInteract, ServerHandle.ItemInteract },
            { (int)ClientPackets.playerHit, ServerHandle.PlayerHit },
            { (int)ClientPackets.playerDamageMob, ServerHandle.PlayerDamageMob },
            { (int)ClientPackets.shrineCombatStart, ServerHandle.ShrineCombatStartRequest },
            { (int)ClientPackets.sendChatMessage, ServerHandle.ReceiveChatMessage },
            { (int)ClientPackets.playerPing, ServerHandle.ReceivePing },
            { (int)ClientPackets.sendArmor, ServerHandle.ReceiveArmor },
            { (int)ClientPackets.playerHp, ServerHandle.PlayerHp },
            { (int)ClientPackets.playerDied, ServerHandle.PlayerDied },
            { (int)ClientPackets.shootArrow, ServerHandle.ShootArrow },
            { (int)ClientPackets.finishedLoading, ServerHandle.PlayerFinishedLoading },
            { (int)ClientPackets.spawnEffect, ServerHandle.SpawnEffect },
            { (int)ClientPackets.reviveRequest, ServerHandle.RevivePlayer },
			{ (int)ClientPackets.interact, new Server.PacketHandler(ServerHandle.Interact) },
			{ (int)ClientPackets.startedLoading, new Server.PacketHandler(ServerHandle.StartedLoading) },

			{ (int)ClientPackets.moveVehicle, ServerHandle.UpdateCar },
			{ (int)ClientPackets.enterVehicle, ServerHandle.EnterVehicle },
			{ (int)ClientPackets.exitVehicle, ServerHandle.ExitVehicle },
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
