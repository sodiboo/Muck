using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

// Token: 0x020000BB RID: 187
public class NetStatus : MonoBehaviour
{
	// Token: 0x06000562 RID: 1378 RVA: 0x0001BF8B File Offset: 0x0001A18B
	private void Awake()
	{
		InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
	}

	// Token: 0x06000563 RID: 1379 RVA: 0x0001BFA2 File Offset: 0x0001A1A2
	private void SlowUpdate()
	{
		if (GameManager.instance)
		{
			ClientSend.PingServer();
		}
	}

	// Token: 0x06000564 RID: 1380 RVA: 0x0001BFB5 File Offset: 0x0001A1B5
	public static void AddPing(int p)
	{
		NetStatus.pings.AddFirst(p);
		if (NetStatus.pings.Count > NetStatus.pingBuffer)
		{
			NetStatus.pings.RemoveLast();
		}
	}

	// Token: 0x06000565 RID: 1381 RVA: 0x0001BFDE File Offset: 0x0001A1DE
	public static int GetPing()
	{
		if (NetStatus.pings.Count > 0)
		{
			return (int)NetStatus.pings.Average();
		}
		return 0;
	}

	// Token: 0x040004B1 RID: 1201
	private static LinkedList<int> pings = new LinkedList<int>();

	// Token: 0x040004B2 RID: 1202
	private static int pingBuffer = 2;
}
