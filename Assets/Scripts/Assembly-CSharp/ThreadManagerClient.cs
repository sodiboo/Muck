using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000099 RID: 153
public class ThreadManagerClient : MonoBehaviour
{
	// Token: 0x06000497 RID: 1175 RVA: 0x00017293 File Offset: 0x00015493
	private void Update()
	{
		ThreadManagerClient.UpdateMain();
	}

	// Token: 0x06000498 RID: 1176 RVA: 0x0001729C File Offset: 0x0001549C
	public static void ExecuteOnMainThread(Action _action)
	{
		if (_action == null)
		{
			Debug.Log("No action to execute on main thread!");
			return;
		}
		List<Action> obj = ThreadManagerClient.executeOnMainThread;
		lock (obj)
		{
			ThreadManagerClient.executeOnMainThread.Add(_action);
			ThreadManagerClient.actionToExecuteOnMainThread = true;
		}
	}

	// Token: 0x06000499 RID: 1177 RVA: 0x000172F4 File Offset: 0x000154F4
	public static void UpdateMain()
	{
		if (ThreadManagerClient.actionToExecuteOnMainThread)
		{
			ThreadManagerClient.executeCopiedOnMainThread.Clear();
			List<Action> obj = ThreadManagerClient.executeOnMainThread;
			lock (obj)
			{
				ThreadManagerClient.executeCopiedOnMainThread.AddRange(ThreadManagerClient.executeOnMainThread);
				ThreadManagerClient.executeOnMainThread.Clear();
				ThreadManagerClient.actionToExecuteOnMainThread = false;
			}
			for (int i = 0; i < ThreadManagerClient.executeCopiedOnMainThread.Count; i++)
			{
				ThreadManagerClient.executeCopiedOnMainThread[i]();
			}
		}
	}

	// Token: 0x040003EA RID: 1002
	private static readonly List<Action> executeOnMainThread = new List<Action>();

	// Token: 0x040003EB RID: 1003
	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	// Token: 0x040003EC RID: 1004
	private static bool actionToExecuteOnMainThread = false;
}
