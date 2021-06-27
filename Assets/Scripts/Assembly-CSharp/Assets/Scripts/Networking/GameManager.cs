using System;
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Scripts.Networking
{
	public class GameManager
	{
		public static void StartGame()
		{
			if (GameManager.NumPlayersLeftInServer() < 4)
			{
				return;
			}
			if (GameManager.state == GameState.Playing)
			{
				return;
			}
			GameManager.state = GameState.Playing;
			Debug.Log("Starting game");
			List<int> list = new List<int>();
			foreach (Client client in Server.clients.Values)
			{
				if (((client != null) ? client.player : null) != null)
				{
					list.Add(client.id);
				}
			}
		}

		public void FindSpawnPositions()
		{
		}

		public static int NumPlayersLeftInGame()
		{
			int num = 0;
			foreach (Client client in Server.clients.Values)
			{
				if (((client != null) ? client.player : null) != null)
				{
					num++;
				}
			}
			return num;
		}

		public static int NumPlayersLeftAlive()
		{
			int num = 0;
			foreach (Client client in Server.clients.Values)
			{
				if (((client != null) ? client.player : null) != null && !client.player.dead)
				{
					num++;
				}
			}
			return num;
		}

		public static int NumPlayersLeftInServer()
		{
			int num = 0;
			using (Dictionary<int, Client>.ValueCollection.Enumerator enumerator = Server.clients.Values.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					if (enumerator.Current.player != null)
					{
						num++;
					}
				}
			}
			return num;
		}

		public static int NumPlayersReady()
		{
			int num = 0;
			foreach (Client client in Server.clients.Values)
			{
				if (((client != null) ? client.player : null) != null && client.player.ready)
				{
					num++;
				}
			}
			return num;
		}

		public static GameState state;
	}
}
