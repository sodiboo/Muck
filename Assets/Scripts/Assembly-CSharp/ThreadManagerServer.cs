using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A3 RID: 163
public class ThreadManagerServer : MonoBehaviour
{
	// Token: 0x06000526 RID: 1318 RVA: 0x0001AB90 File Offset: 0x00018D90
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

	// Token: 0x06000527 RID: 1319 RVA: 0x0001ABE8 File Offset: 0x00018DE8
	private void Awake()
	{
		ThreadManagerServer.Instance = this;
		base.InvokeRepeating("TimeoutUpdate", 1f, 1f);
	}

	// Token: 0x06000528 RID: 1320 RVA: 0x0000276E File Offset: 0x0000096E
	public void GameOver()
	{
	}

	// Token: 0x06000529 RID: 1321 RVA: 0x0000276E File Offset: 0x0000096E
	public void ResetGame()
	{
	}

	// Token: 0x0600052A RID: 1322 RVA: 0x0000276E File Offset: 0x0000096E
	private void TimeoutUpdate()
	{
	}

	// Token: 0x0600052B RID: 1323 RVA: 0x0001AC05 File Offset: 0x00018E05
	private void FixedUpdate()
	{
		ThreadManagerServer.UpdateMain();
	}

	// Token: 0x0600052C RID: 1324 RVA: 0x0001AC0C File Offset: 0x00018E0C
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

	// Token: 0x0400042A RID: 1066
	private static readonly List<Action> executeOnMainThread = new List<Action>();

	// Token: 0x0400042B RID: 1067
	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	// Token: 0x0400042C RID: 1068
	private static bool actionToExecuteOnMainThread = false;

	// Token: 0x0400042D RID: 1069
	public static ThreadManagerServer Instance;

	// Token: 0x0400042E RID: 1070
	private int minPlayerAmount = 3;
}
