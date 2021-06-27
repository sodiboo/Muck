using System;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

// Token: 0x020000C2 RID: 194
public class Client
{
	// Token: 0x060005A0 RID: 1440 RVA: 0x0001CC72 File Offset: 0x0001AE72
	public Client(int clientId)
	{
		this.id = clientId;
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			this.tcp = new Client.TCP(this.id);
			this.udp = new Client.UDP(this.id);
		}
	}

	// Token: 0x060005A1 RID: 1441 RVA: 0x0001CCB0 File Offset: 0x0001AEB0
	public void StartClient(string playerName, Color color)
	{
		this.player = new Player(this.id, playerName, color);
	}

	// Token: 0x060005A2 RID: 1442 RVA: 0x0001CCC5 File Offset: 0x0001AEC5
	public void StartClientSteam(string playerName, Color color, SteamId steamId)
	{
		this.player = new Player(this.id, playerName, color, steamId);
	}

	// Token: 0x060005A3 RID: 1443 RVA: 0x000030D7 File Offset: 0x000012D7
	public void SendIntoGame()
	{
	}

	// Token: 0x060005A4 RID: 1444 RVA: 0x0001CCDC File Offset: 0x0001AEDC
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

	// Token: 0x04000503 RID: 1283
	public static int dataBufferSize = 4096;

	// Token: 0x04000504 RID: 1284
	public int id;

	// Token: 0x04000505 RID: 1285
	public Player player;

	// Token: 0x04000506 RID: 1286
	public Client.TCP tcp;

	// Token: 0x04000507 RID: 1287
	public Client.UDP udp;

	// Token: 0x04000508 RID: 1288
	public bool inLobby;

	// Token: 0x02000163 RID: 355
	public class TCP
	{
		// Token: 0x06000915 RID: 2325 RVA: 0x0002CA8A File Offset: 0x0002AC8A
		public TCP(int i)
		{
			this.id = i;
		}

		// Token: 0x06000916 RID: 2326 RVA: 0x0002CA9C File Offset: 0x0002AC9C
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

		// Token: 0x06000917 RID: 2327 RVA: 0x0002CB2C File Offset: 0x0002AD2C
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

		// Token: 0x06000918 RID: 2328 RVA: 0x0002CB8C File Offset: 0x0002AD8C
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

		// Token: 0x06000919 RID: 2329 RVA: 0x0002CC48 File Offset: 0x0002AE48
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

		// Token: 0x0600091A RID: 2330 RVA: 0x0002CCEF File Offset: 0x0002AEEF
		public void Disconnect()
		{
			this.socket.Close();
			this.stream = null;
			this.receivedData = null;
			this.receiveBuffer = null;
			this.socket = null;
		}

		// Token: 0x04000918 RID: 2328
		public TcpClient socket;

		// Token: 0x04000919 RID: 2329
		public readonly int id;

		// Token: 0x0400091A RID: 2330
		private NetworkStream stream;

		// Token: 0x0400091B RID: 2331
		private Packet receivedData;

		// Token: 0x0400091C RID: 2332
		private byte[] receiveBuffer;
	}

	// Token: 0x02000164 RID: 356
	public class UDP
	{
		// Token: 0x0600091B RID: 2331 RVA: 0x0002CD18 File Offset: 0x0002AF18
		public UDP(int id)
		{
			this.id = id;
		}

		// Token: 0x0600091C RID: 2332 RVA: 0x0002CD27 File Offset: 0x0002AF27
		public void Connect(IPEndPoint endPoint)
		{
			this.endPoint = endPoint;
		}

		// Token: 0x0600091D RID: 2333 RVA: 0x0002CD30 File Offset: 0x0002AF30
		public void SendData(Packet packet)
		{
			Server.SendUDPData(this.endPoint, packet);
		}

		// Token: 0x0600091E RID: 2334 RVA: 0x0002CD40 File Offset: 0x0002AF40
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

		// Token: 0x0600091F RID: 2335 RVA: 0x0002CD7F File Offset: 0x0002AF7F
		public void Disconnect()
		{
			this.endPoint = null;
		}

		// Token: 0x0400091D RID: 2333
		public IPEndPoint endPoint;

		// Token: 0x0400091E RID: 2334
		private int id;
	}
}
