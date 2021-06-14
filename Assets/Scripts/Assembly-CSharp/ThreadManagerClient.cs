using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000C8 RID: 200
public class ThreadManagerClient : MonoBehaviour
{
	// Token: 0x0600050E RID: 1294 RVA: 0x000055A3 File Offset: 0x000037A3
	private void Update()
	{
		ThreadManagerClient.UpdateMain();
	}

	// Token: 0x0600050F RID: 1295 RVA: 0x0001B360 File Offset: 0x00019560
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

	// Token: 0x06000510 RID: 1296 RVA: 0x0001B3B8 File Offset: 0x000195B8
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

	// Token: 0x040004BB RID: 1211
	private static readonly List<Action> executeOnMainThread = new List<Action>();

	// Token: 0x040004BC RID: 1212
	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	// Token: 0x040004BD RID: 1213
	private static bool actionToExecuteOnMainThread = false;
}
