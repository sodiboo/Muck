using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class NetStatus : MonoBehaviour
{
	private void Awake()
	{
		InvokeRepeating(nameof(SlowUpdate), 1f, 1f);
	}

	private void SlowUpdate()
	{
		if (GameManager.instance)
		{
			ClientSend.PingServer();
		}
	}

	public static void AddPing(int p)
	{
		NetStatus.pings.AddFirst(p);
		if (NetStatus.pings.Count > NetStatus.pingBuffer)
		{
			NetStatus.pings.RemoveLast();
		}
	}

	public static int GetPing()
	{
		if (NetStatus.pings.Count > 0)
		{
			return (int)NetStatus.pings.Average();
		}
		return 0;
	}

	private static LinkedList<int> pings = new LinkedList<int>();

	private static int pingBuffer = 2;
}
