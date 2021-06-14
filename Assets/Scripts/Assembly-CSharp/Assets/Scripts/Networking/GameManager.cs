using System;
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Scripts.Networking
{
	// Token: 0x0200015A RID: 346
	public class GameManager
	{
		// Token: 0x06000847 RID: 2119 RVA: 0x000285D4 File Offset: 0x000267D4
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

		// Token: 0x06000848 RID: 2120 RVA: 0x00002147 File Offset: 0x00000347
		public void FindSpawnPositions()
		{
		}

		// Token: 0x06000849 RID: 2121 RVA: 0x00028668 File Offset: 0x00026868
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

		// Token: 0x0600084A RID: 2122 RVA: 0x000286CC File Offset: 0x000268CC
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

		// Token: 0x0600084B RID: 2123 RVA: 0x00028740 File Offset: 0x00026940
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

		// Token: 0x0600084C RID: 2124 RVA: 0x000287A0 File Offset: 0x000269A0
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

		// Token: 0x0400088B RID: 2187
		public static GameState state;
	}
}
