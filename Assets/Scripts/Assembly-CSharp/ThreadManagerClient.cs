using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000C0 RID: 192
public class ThreadManagerClient : MonoBehaviour
{
	// Token: 0x06000594 RID: 1428 RVA: 0x0001C99F File Offset: 0x0001AB9F
	private void Update()
	{
		ThreadManagerClient.UpdateMain();
	}

	// Token: 0x06000595 RID: 1429 RVA: 0x0001C9A8 File Offset: 0x0001ABA8
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

	// Token: 0x06000596 RID: 1430 RVA: 0x0001CA00 File Offset: 0x0001AC00
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

	// Token: 0x040004F9 RID: 1273
	private static readonly List<Action> executeOnMainThread = new List<Action>();

	// Token: 0x040004FA RID: 1274
	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	// Token: 0x040004FB RID: 1275
	private static bool actionToExecuteOnMainThread = false;
}
