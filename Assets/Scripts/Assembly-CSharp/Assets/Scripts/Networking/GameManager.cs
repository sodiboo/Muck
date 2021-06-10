
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Scripts.Networking
{
	// Token: 0x02000103 RID: 259
	public class GameManager
	{
		// Token: 0x06000788 RID: 1928 RVA: 0x00025520 File Offset: 0x00023720
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

		// Token: 0x06000789 RID: 1929 RVA: 0x0000276E File Offset: 0x0000096E
		public void FindSpawnPositions()
		{
		}

		// Token: 0x0600078A RID: 1930 RVA: 0x000255B4 File Offset: 0x000237B4
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

		// Token: 0x0600078B RID: 1931 RVA: 0x00025618 File Offset: 0x00023818
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

		// Token: 0x0600078C RID: 1932 RVA: 0x0002568C File Offset: 0x0002388C
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

		// Token: 0x0600078D RID: 1933 RVA: 0x000256EC File Offset: 0x000238EC
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

		// Token: 0x04000718 RID: 1816
		public static GameState state;
	}
}
