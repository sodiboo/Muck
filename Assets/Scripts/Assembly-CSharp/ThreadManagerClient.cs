using System;
using System.Collections.Generic;
using UnityEngine;

public class ThreadManagerClient : MonoBehaviour
{
	private void Update()
	{
		ThreadManagerClient.UpdateMain();
	}

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

	private static readonly List<Action> executeOnMainThread = new List<Action>();

	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	private static bool actionToExecuteOnMainThread = false;
}
