using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

// Token: 0x020000C2 RID: 194
public class NetStatus : MonoBehaviour
{
	// Token: 0x060004DC RID: 1244 RVA: 0x000052DE File Offset: 0x000034DE
	private void Awake()
	{
		base.InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
	}

	// Token: 0x060004DD RID: 1245 RVA: 0x000052F5 File Offset: 0x000034F5
	private void SlowUpdate()
	{
		if (GameManager.instance)
		{
			ClientSend.PingServer();
		}
	}

	// Token: 0x060004DE RID: 1246 RVA: 0x00005308 File Offset: 0x00003508
	public static void AddPing(int p)
	{
		NetStatus.pings.AddFirst(p);
		if (NetStatus.pings.Count > NetStatus.pingBuffer)
		{
			NetStatus.pings.RemoveLast();
		}
	}

	// Token: 0x060004DF RID: 1247 RVA: 0x00005331 File Offset: 0x00003531
	public static int GetPing()
	{
		if (NetStatus.pings.Count > 0)
		{
			return (int)NetStatus.pings.Average();
		}
		return 0;
	}

	// Token: 0x0400046F RID: 1135
	private static LinkedList<int> pings = new LinkedList<int>();

	// Token: 0x04000470 RID: 1136
	private static int pingBuffer = 2;
}
