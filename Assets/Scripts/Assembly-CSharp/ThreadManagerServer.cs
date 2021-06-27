using System;
using System.Collections.Generic;
using UnityEngine;

public class ThreadManagerServer : MonoBehaviour
{
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

	private void Awake()
	{
		ThreadManagerServer.Instance = this;
		InvokeRepeating(nameof(TimeoutUpdate), 1f, 1f);
	}

	public void GameOver()
	{
	}

	public void ResetGame()
	{
	}

	private void TimeoutUpdate()
	{
	}

	private void FixedUpdate()
	{
		ThreadManagerServer.UpdateMain();
	}

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

	private static readonly List<Action> executeOnMainThread = new List<Action>();

	private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

	private static bool actionToExecuteOnMainThread = false;

	public static ThreadManagerServer Instance;

	private int minPlayerAmount = 3;
}
