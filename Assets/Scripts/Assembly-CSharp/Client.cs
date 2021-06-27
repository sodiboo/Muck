using System;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

public class Client
{
	public Client(int clientId)
	{
		this.id = clientId;
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			this.tcp = new Client.TCP(this.id);
			this.udp = new Client.UDP(this.id);
		}
	}

	public void StartClient(string playerName, Color color)
	{
		this.player = new Player(this.id, playerName, color);
	}

	public void StartClientSteam(string playerName, Color color, SteamId steamId)
	{
		this.player = new Player(this.id, playerName, color, steamId);
	}

	public void SendIntoGame()
	{
	}

	public void Disconnect()
	{
		ServerSend.DisconnectPlayer(this.player.id);
		this.player = null;
		try
		{
			this.player = null;
			Debug.Log(string.Format("player{0} has disconnected", this.id));
		}
		catch (Exception arg)
		{
			Debug.Log("Handled an error in Client's disconnect method on server...'\n" + arg);
		}
		try
		{
			this.tcp.Disconnect();
		}
		catch (Exception arg2)
		{
			Debug.Log("Handled an error in Client's disconnect method on tcp disconnect server...'\n" + arg2);
		}
		try
		{
			this.udp.Disconnect();
		}
		catch (Exception arg3)
		{
			Debug.Log("Handled an error in Client's disconnect method on tcp disconnect server...'\n" + arg3);
		}
	}

	public static int dataBufferSize = 4096;

	public int id;

	public Player player;

	public Client.TCP tcp;

	public Client.UDP udp;

	public bool inLobby;

	public class TCP
	{
		public TCP(int i)
		{
			this.id = i;
		}

		public void Connect(TcpClient socket)
		{
			this.socket = socket;
			this.socket.ReceiveBufferSize = Client.dataBufferSize;
			this.socket.SendBufferSize = Client.dataBufferSize;
			this.stream = socket.GetStream();
			this.receivedData = new Packet();
			this.receiveBuffer = new byte[Client.dataBufferSize];
			this.stream.BeginRead(this.receiveBuffer, 0, Client.dataBufferSize, new AsyncCallback(this.ReceiveCallback), null);
			ServerSend.Welcome(this.id, "Weclome to the server");
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
				Debug.Log(string.Format("Error sending data to player {0} via TCP: {1}", this.id, arg));
				throw;
			}
		}

		private void ReceiveCallback(IAsyncResult _result)
		{
			try
			{
				int num = this.stream.EndRead(_result);
				if (num <= 0)
				{
					Server.clients[this.id].Disconnect();
				}
				else
				{
					byte[] array = new byte[num];
					Array.Copy(this.receiveBuffer, array, num);
					this.receivedData.Reset(this.HandleData(array));
					this.stream.BeginRead(this.receiveBuffer, 0, Client.dataBufferSize, new AsyncCallback(this.ReceiveCallback), null);
				}
			}
			catch (Exception arg)
			{
				Debug.Log("Error receiving TCP data: " + arg);
				Server.clients[this.id].Disconnect();
			}
		}

		private bool HandleData(byte[] data)
		{
			int num = 0;
			this.receivedData.SetBytes(data);
			if (this.receivedData.UnreadLength() >= 4)
			{
				num = this.receivedData.ReadInt(true);
				if (num <= 0)
				{
					return true;
				}
			}
			while (num > 0 && num <= this.receivedData.UnreadLength())
			{
				byte[] packetBytes = this.receivedData.ReadBytes(num, true);
				ThreadManagerServer.ExecuteOnMainThread(delegate
				{
					using (Packet packet = new Packet(packetBytes))
					{
						int key = packet.ReadInt(true);
						Server.PacketHandlers[key](this.id, packet);
					}
				});
				num = 0;
				if (this.receivedData.UnreadLength() >= 4)
				{
					num = this.receivedData.ReadInt(true);
					if (num <= 0)
					{
						return true;
					}
				}
			}
			return num <= 1;
		}

		public void Disconnect()
		{
			this.socket.Close();
			this.stream = null;
			this.receivedData = null;
			this.receiveBuffer = null;
			this.socket = null;
		}

		public TcpClient socket;

		public readonly int id;

		private NetworkStream stream;

		private Packet receivedData;

		private byte[] receiveBuffer;
	}

	public class UDP
	{
		public UDP(int id)
		{
			this.id = id;
		}

		public void Connect(IPEndPoint endPoint)
		{
			this.endPoint = endPoint;
		}

		public void SendData(Packet packet)
		{
			Server.SendUDPData(this.endPoint, packet);
		}

		public void HandleData(Packet packetData)
		{
			int length = packetData.ReadInt(true);
			byte[] packetBytes = packetData.ReadBytes(length, true);
			ThreadManagerServer.ExecuteOnMainThread(delegate
			{
				using (Packet packet = new Packet(packetBytes))
				{
					int key = packet.ReadInt(true);
					Server.PacketHandlers[key](this.id, packet);
				}
			});
		}

		public void Disconnect()
		{
			this.endPoint = null;
		}

		public IPEndPoint endPoint;

		private int id;
	}
}
