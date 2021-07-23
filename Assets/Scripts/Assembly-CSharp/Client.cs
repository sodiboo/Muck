using System;
using System.Net;
using System.Net.Sockets;
using Steamworks;
using UnityEngine;

public class Client
{
    public class TCP
    {
        public TcpClient socket;

        public readonly int id;

        private NetworkStream stream;

        private Packet receivedData;

        private byte[] receiveBuffer;

        public TCP(int i)
        {
            id = i;
        }

        public void Connect(TcpClient socket)
        {
            this.socket = socket;
            this.socket.ReceiveBufferSize = dataBufferSize;
            this.socket.SendBufferSize = dataBufferSize;
            stream = socket.GetStream();
            receivedData = new Packet();
            receiveBuffer = new byte[dataBufferSize];
            stream.BeginRead(receiveBuffer, 0, dataBufferSize, ReceiveCallback, null);
            ServerSend.Welcome(id, "Weclome to the server");
        }

        public void SendData(Packet packet)
        {
            try
            {
                if (socket != null)
                {
                    stream.BeginWrite(packet.ToArray(), 0, packet.Length(), null, null);
                }
            }
            catch (Exception arg)
            {
                Debug.Log($"Error sending data to player {id} via TCP: {arg}");
                throw;
            }
        }

        private void ReceiveCallback(IAsyncResult _result)
        {
            try
            {
                int num = stream.EndRead(_result);
                if (num <= 0)
                {
                    Server.clients[id].Disconnect();
                    return;
                }
                byte[] array = new byte[num];
                Array.Copy(receiveBuffer, array, num);
                receivedData.Reset(HandleData(array));
                stream.BeginRead(receiveBuffer, 0, dataBufferSize, ReceiveCallback, null);
            }
            catch (Exception ex)
            {
                Debug.Log("Error receiving TCP data: " + ex);
                Server.clients[id].Disconnect();
            }
        }

        private bool HandleData(byte[] data)
        {
            int num = 0;
            receivedData.SetBytes(data);
            if (receivedData.UnreadLength() >= 4)
            {
                num = receivedData.ReadInt();
                if (num <= 0)
                {
                    return true;
                }
            }
            while (num > 0 && num <= receivedData.UnreadLength())
            {
                byte[] packetBytes = receivedData.ReadBytes(num);
                ThreadManagerServer.ExecuteOnMainThread(delegate
                {
                    using (Packet packet = new Packet(packetBytes))
                    {
                        int key = packet.ReadInt();
                        Server.PacketHandlers[key](id, packet);
                    }
                });
                num = 0;
                if (receivedData.UnreadLength() >= 4)
                {
                    num = receivedData.ReadInt();
                    if (num <= 0)
                    {
                        return true;
                    }
                }
            }
            if (num <= 1)
            {
                return true;
            }
            return false;
        }

        public void Disconnect()
        {
            socket.Close();
            stream = null;
            receivedData = null;
            receiveBuffer = null;
            socket = null;
        }
    }

    public class UDP
    {
        public IPEndPoint endPoint;

        private int id;

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
            Server.SendUDPData(endPoint, packet);
        }

        public void HandleData(Packet packetData)
        {
            int length = packetData.ReadInt();
            byte[] packetBytes = packetData.ReadBytes(length);
            ThreadManagerServer.ExecuteOnMainThread(delegate
            {
                using (Packet packet = new Packet(packetBytes))
                {
                    int key = packet.ReadInt();
                    Server.PacketHandlers[key](id, packet);
                }
            });
        }

        public void Disconnect()
        {
            endPoint = null;
        }
    }

    public static int dataBufferSize = 4096;

    public int id;

    public Player player;

    public TCP tcp;

    public UDP udp;

    public bool inLobby;

    public Client(int clientId)
    {
        id = clientId;
        if (NetworkController.Instance.networkType == NetworkController.NetworkType.Classic)
        {
            tcp = new TCP(id);
            udp = new UDP(id);
        }
    }

    public void StartClient(string playerName, Color color)
    {
        player = new Player(id, playerName, color);
    }

    public void StartClientSteam(string playerName, Color color, SteamId steamId)
    {
        player = new Player(id, playerName, color, steamId);
    }

    public void SendIntoGame()
    {
    }

    public void Disconnect()
    {
        ServerSend.DisconnectPlayer(player.id);
        player = null;
        try
        {
            player = null;
            Debug.Log($"player{id} has disconnected");
        }
        catch (Exception ex)
        {
            Debug.Log("Handled an error in Client's disconnect method on server...'\n" + ex);
        }
        try
        {
            tcp.Disconnect();
        }
        catch (Exception ex2)
        {
            Debug.Log("Handled an error in Client's disconnect method on tcp disconnect server...'\n" + ex2);
        }
        try
        {
            udp.Disconnect();
        }
        catch (Exception ex3)
        {
            Debug.Log("Handled an error in Client's disconnect method on tcp disconnect server...'\n" + ex3);
        }
    }
}
