using System;
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Scripts.Networking
{
	// Token: 0x02000136 RID: 310
	public class GameManager
	{
		// Token: 0x060008D4 RID: 2260 RVA: 0x0002BF0C File Offset: 0x0002A10C
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

		// Token: 0x060008D5 RID: 2261 RVA: 0x000030D7 File Offset: 0x000012D7
		public void FindSpawnPositions()
		{
		}

		// Token: 0x060008D6 RID: 2262 RVA: 0x0002BFA0 File Offset: 0x0002A1A0
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

		// Token: 0x060008D7 RID: 2263 RVA: 0x0002C004 File Offset: 0x0002A204
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

		// Token: 0x060008D8 RID: 2264 RVA: 0x0002C078 File Offset: 0x0002A278
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

		// Token: 0x060008D9 RID: 2265 RVA: 0x0002C0D8 File Offset: 0x0002A2D8
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

		// Token: 0x04000866 RID: 2150
		public static GameState state;
	}
}
