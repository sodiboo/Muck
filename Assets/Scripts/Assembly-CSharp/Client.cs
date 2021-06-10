using System;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

// Token: 0x0200009B RID: 155
public class Client
{
	// Token: 0x060004A3 RID: 1187 RVA: 0x00017566 File Offset: 0x00015766
	public Client(int clientId)
	{
		this.id = clientId;
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
		{
			this.tcp = new Client.TCP(this.id);
			this.udp = new Client.UDP(this.id);
		}
	}

	// Token: 0x060004A4 RID: 1188 RVA: 0x000175A4 File Offset: 0x000157A4
	public void StartClient(string playerName, Color color)
	{
		this.player = new Player(this.id, playerName, color);
	}

	// Token: 0x060004A5 RID: 1189 RVA: 0x000175B9 File Offset: 0x000157B9
	public void StartClientSteam(string playerName, Color color, SteamId steamId)
	{
		this.player = new Player(this.id, playerName, color, steamId);
	}

	// Token: 0x060004A6 RID: 1190 RVA: 0x0000276E File Offset: 0x0000096E
	public void SendIntoGame()
	{
	}

	// Token: 0x060004A7 RID: 1191 RVA: 0x000175D0 File Offset: 0x000157D0
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

	// Token: 0x040003F4 RID: 1012
	public static int dataBufferSize = 4096;

	// Token: 0x040003F5 RID: 1013
	public int id;

	// Token: 0x040003F6 RID: 1014
	public Player player;

	// Token: 0x040003F7 RID: 1015
	public Client.TCP tcp;

	// Token: 0x040003F8 RID: 1016
	public Client.UDP udp;

	// Token: 0x040003F9 RID: 1017
	public bool inLobby;

	// Token: 0x02000126 RID: 294
	public class TCP
	{
		// Token: 0x060007C1 RID: 1985 RVA: 0x00025FB2 File Offset: 0x000241B2
		public TCP(int i)
		{
			this.id = i;
		}

		// Token: 0x060007C2 RID: 1986 RVA: 0x00025FC4 File Offset: 0x000241C4
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

		// Token: 0x060007C3 RID: 1987 RVA: 0x00026054 File Offset: 0x00024254
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

		// Token: 0x060007C4 RID: 1988 RVA: 0x000260B4 File Offset: 0x000242B4
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

		// Token: 0x060007C5 RID: 1989 RVA: 0x00026170 File Offset: 0x00024370
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

		// Token: 0x060007C6 RID: 1990 RVA: 0x00026217 File Offset: 0x00024417
		public void Disconnect()
		{
			this.socket.Close();
			this.stream = null;
			this.receivedData = null;
			this.receiveBuffer = null;
			this.socket = null;
		}

		// Token: 0x0400079F RID: 1951
		public TcpClient socket;

		// Token: 0x040007A0 RID: 1952
		public readonly int id;

		// Token: 0x040007A1 RID: 1953
		private NetworkStream stream;

		// Token: 0x040007A2 RID: 1954
		private Packet receivedData;

		// Token: 0x040007A3 RID: 1955
		private byte[] receiveBuffer;
	}

	// Token: 0x02000127 RID: 295
	public class UDP
	{
		// Token: 0x060007C7 RID: 1991 RVA: 0x00026240 File Offset: 0x00024440
		public UDP(int id)
		{
			this.id = id;
		}

		// Token: 0x060007C8 RID: 1992 RVA: 0x0002624F File Offset: 0x0002444F
		public void Connect(IPEndPoint endPoint)
		{
			this.endPoint = endPoint;
		}

		// Token: 0x060007C9 RID: 1993 RVA: 0x00026258 File Offset: 0x00024458
		public void SendData(Packet packet)
		{
			Server.SendUDPData(this.endPoint, packet);
		}

		// Token: 0x060007CA RID: 1994 RVA: 0x00026268 File Offset: 0x00024468
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

		// Token: 0x060007CB RID: 1995 RVA: 0x000262A7 File Offset: 0x000244A7
		public void Disconnect()
		{
			this.endPoint = null;
		}

		// Token: 0x040007A4 RID: 1956
		public IPEndPoint endPoint;

		// Token: 0x040007A5 RID: 1957
		private int id;
	}
}
