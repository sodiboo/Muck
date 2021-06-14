using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000D7 RID: 215
public class ThreadManagerServer : MonoBehaviour
{
	// Token: 0x060005B6 RID: 1462 RVA: 0x0001F030 File Offset: 0x0001D230
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

	// Token: 0x060005B7 RID: 1463 RVA: 0x00005896 File Offset: 0x00003A96
	private void Awake()
	{
		ThreadManagerServer.Instance = this;
		base.InvokeRepeating("TimeoutUpdate", 1f, 1f);
	}

	// Token: 0x060005B8 RID: 1464 RVA: 0x00002147 File Offset: 0x00000347
	public void GameOver()
	{
	}

	// Token: 0x060005B9 RID: 1465 RVA: 0x00002147 File Offset: 0x00000347
	public void ResetGame()
	{
	}

	// Token: 0x060005BA RID: 1466 RVA: 0x00002147 File Offset: 0x00000347
	private void TimeoutUpdate()
	{
	}

	// Token: 0x060005BB RID: 1467 RVA: 0x000058B3 File Offset: 0x00003AB3
	private void FixedUpdate()
	{
		ThreadManagerServer.UpdateMain();
	}

	// Token: 0x060005BC RID: 1468 RVA: 0x0001F088 File Offset: 0x0001D288
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

	// Token: 0x04000507 RID: 1287
	private static readonly List<Action> executeOnMainThread = new List<Action>();

	// Token: 0x04000508 RID: 1288
	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	// Token: 0x04000509 RID: 1289
	private static bool actionToExecuteOnMainThread = false;

	// Token: 0x0400050A RID: 1290
	public static ThreadManagerServer Instance;

	// Token: 0x0400050B RID: 1291
	private int minPlayerAmount = 3;
}
