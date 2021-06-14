using System;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

// Token: 0x020000CA RID: 202
public class Client
{
	// Token: 0x0600051A RID: 1306 RVA: 0x00005607 File Offset: 0x00003807
	public Client(int clientId)
	{
		this.id = clientId;
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			this.tcp = new Client.TCP(this.id);
			this.udp = new Client.UDP(this.id);
		}
	}

	// Token: 0x0600051B RID: 1307 RVA: 0x00005645 File Offset: 0x00003845
	public void StartClient(string playerName, Color color)
	{
		this.player = new Player(this.id, playerName, color);
	}

	// Token: 0x0600051C RID: 1308 RVA: 0x0000565A File Offset: 0x0000385A
	public void StartClientSteam(string playerName, Color color, SteamId steamId)
	{
		this.player = new Player(this.id, playerName, color, steamId);
	}

	// Token: 0x0600051D RID: 1309 RVA: 0x00002147 File Offset: 0x00000347
	public void SendIntoGame()
	{
	}

	// Token: 0x0600051E RID: 1310 RVA: 0x0001B5CC File Offset: 0x000197CC
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

	// Token: 0x040004C5 RID: 1221
	public static int dataBufferSize = 4096;

	// Token: 0x040004C6 RID: 1222
	public int id;

	// Token: 0x040004C7 RID: 1223
	public Player player;

	// Token: 0x040004C8 RID: 1224
	public Client.TCP tcp;

	// Token: 0x040004C9 RID: 1225
	public Client.UDP udp;

	// Token: 0x040004CA RID: 1226
	public bool inLobby;

	// Token: 0x020000CB RID: 203
	public class TCP
	{
		// Token: 0x06000520 RID: 1312 RVA: 0x0000567C File Offset: 0x0000387C
		public TCP(int i)
		{
			this.id = i;
		}

		// Token: 0x06000521 RID: 1313 RVA: 0x0001B690 File Offset: 0x00019890
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

		// Token: 0x06000522 RID: 1314 RVA: 0x0001B720 File Offset: 0x00019920
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

		// Token: 0x06000523 RID: 1315 RVA: 0x0001B780 File Offset: 0x00019980
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

		// Token: 0x06000524 RID: 1316 RVA: 0x0001B83C File Offset: 0x00019A3C
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

		// Token: 0x06000525 RID: 1317 RVA: 0x0000568B File Offset: 0x0000388B
		public void Disconnect()
		{
			this.socket.Close();
			this.stream = null;
			this.receivedData = null;
			this.receiveBuffer = null;
			this.socket = null;
		}

		// Token: 0x040004CB RID: 1227
		public TcpClient socket;

		// Token: 0x040004CC RID: 1228
		public readonly int id;

		// Token: 0x040004CD RID: 1229
		private NetworkStream stream;

		// Token: 0x040004CE RID: 1230
		private Packet receivedData;

		// Token: 0x040004CF RID: 1231
		private byte[] receiveBuffer;
	}

	// Token: 0x020000CD RID: 205
	public class UDP
	{
		// Token: 0x06000528 RID: 1320 RVA: 0x000056B4 File Offset: 0x000038B4
		public UDP(int id)
		{
			this.id = id;
		}

		// Token: 0x06000529 RID: 1321 RVA: 0x000056C3 File Offset: 0x000038C3
		public void Connect(IPEndPoint endPoint)
		{
			this.endPoint = endPoint;
		}

		// Token: 0x0600052A RID: 1322 RVA: 0x000056CC File Offset: 0x000038CC
		public void SendData(Packet packet)
		{
			Server.SendUDPData(this.endPoint, packet);
		}

		// Token: 0x0600052B RID: 1323 RVA: 0x0001B940 File Offset: 0x00019B40
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

		// Token: 0x0600052C RID: 1324 RVA: 0x000056DA File Offset: 0x000038DA
		public void Disconnect()
		{
			this.endPoint = null;
		}

		// Token: 0x040004D2 RID: 1234
		public IPEndPoint endPoint;

		// Token: 0x040004D3 RID: 1235
		private int id;
	}
}
