using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000CA RID: 202
public class ThreadManagerServer : MonoBehaviour
{
	// Token: 0x0600062C RID: 1580 RVA: 0x00020684 File Offset: 0x0001E884
	public static void ExecuteOnMainThread(Action _action)
	{
		if (_action == null)
		{
			Console.WriteLine("No action to execute on main thread!");
			return;
		}
		List<Action> obj = ThreadManagerServer.executeOnMainThread;
		lock (obj)
		{
			ThreadManagerServer.executeOnMainThread.Add(_action);
			ThreadManagerServer.actionToExecuteOnMainThread = true;
		}
	}

	// Token: 0x0600062D RID: 1581 RVA: 0x000206DC File Offset: 0x0001E8DC
	private void Awake()
	{
		ThreadManagerServer.Instance = this;
		InvokeRepeating(nameof(TimeoutUpdate), 1f, 1f);
	}

	// Token: 0x0600062E RID: 1582 RVA: 0x000030D7 File Offset: 0x000012D7
	public void GameOver()
	{
	}

	// Token: 0x0600062F RID: 1583 RVA: 0x000030D7 File Offset: 0x000012D7
	public void ResetGame()
	{
	}

	// Token: 0x06000630 RID: 1584 RVA: 0x000030D7 File Offset: 0x000012D7
	private void TimeoutUpdate()
	{
	}

	// Token: 0x06000631 RID: 1585 RVA: 0x000206F9 File Offset: 0x0001E8F9
	private void FixedUpdate()
	{
		ThreadManagerServer.UpdateMain();
	}

	// Token: 0x06000632 RID: 1586 RVA: 0x00020700 File Offset: 0x0001E900
	public static void UpdateMain()
	{
		if (ThreadManagerServer.actionToExecuteOnMainThread)
		{
			ThreadManagerServer.executeCopiedOnMainThread.Clear();
			List<Action> obj = ThreadManagerServer.executeOnMainThread;
			lock (obj)
			{
				ThreadManagerServer.executeCopiedOnMainThread.AddRange(ThreadManagerServer.executeOnMainThread);
				ThreadManagerServer.executeOnMainThread.Clear();
				ThreadManagerServer.actionToExecuteOnMainThread = false;
			}
			for (int i = 0; i < ThreadManagerServer.executeCopiedOnMainThread.Count; i++)
			{
				ThreadManagerServer.executeCopiedOnMainThread[i]();
			}
		}
	}

	// Token: 0x0400053A RID: 1338
	private static readonly List<Action> executeOnMainThread = new List<Action>();

	// Token: 0x0400053B RID: 1339
	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	// Token: 0x0400053C RID: 1340
	private static bool actionToExecuteOnMainThread = false;

	// Token: 0x0400053D RID: 1341
	public static ThreadManagerServer Instance;

	// Token: 0x0400053E RID: 1342
	private int minPlayerAmount = 3;
}
