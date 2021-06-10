
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

// Token: 0x02000094 RID: 148
public class NetStatus : MonoBehaviour
{
	// Token: 0x06000465 RID: 1125 RVA: 0x0001687B File Offset: 0x00014A7B
	private void Awake()
	{
		base.InvokeRepeating("SlowUpdate", 1f, 1f);
	}

	// Token: 0x06000466 RID: 1126 RVA: 0x00016892 File Offset: 0x00014A92
	private void SlowUpdate()
	{
		if (GameManager.instance)
		{
			ClientSend.PingServer();
		}
	}

	// Token: 0x06000467 RID: 1127 RVA: 0x000168A5 File Offset: 0x00014AA5
	public static void AddPing(int p)
	{
		NetStatus.pings.AddFirst(p);
		if (NetStatus.pings.Count > NetStatus.pingBuffer)
		{
			NetStatus.pings.RemoveLast();
		}
	}

	// Token: 0x06000468 RID: 1128 RVA: 0x000168CE File Offset: 0x00014ACE
	public static int GetPing()
	{
		if (NetStatus.pings.Count > 0)
		{
			return (int)NetStatus.pings.Average();
		}
		return 0;
	}

	// Token: 0x040003A2 RID: 930
	private static LinkedList<int> pings = new LinkedList<int>();

	// Token: 0x040003A3 RID: 931
	private static int pingBuffer = 2;
}
