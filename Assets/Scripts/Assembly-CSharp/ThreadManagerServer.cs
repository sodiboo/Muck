using System;
using System.Collections.Generic;
using UnityEngine;

public class ThreadManagerServer : MonoBehaviour
{
    private static readonly List<Action> executeOnMainThread = new List<Action>();

    private static readonly List<Action> executeCopiedOnMainThread = new List<Action>();

    private static bool actionToExecuteOnMainThread = false;

    public static ThreadManagerServer Instance;

    private int minPlayerAmount = 3;

    public static void ExecuteOnMainThread(Action _action)
    {
        if (_action == null)
        {
            Console.WriteLine("No action to execute on main thread!");
            return;
        }
        lock (executeOnMainThread)
        {
            executeOnMainThread.Add(_action);
            actionToExecuteOnMainThread = true;
        }
    }

    private void Awake()
    {
        Instance = this;
        InvokeRepeating("TimeoutUpdate", 1f, 1f);
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
        UpdateMain();
    }

    public static void UpdateMain()
    {
        if (actionToExecuteOnMainThread)
        {
            executeCopiedOnMainThread.Clear();
            lock (executeOnMainThread)
            {
                executeCopiedOnMainThread.AddRange(executeOnMainThread);
                executeOnMainThread.Clear();
                actionToExecuteOnMainThread = false;
            }
            for (int i = 0; i < executeCopiedOnMainThread.Count; i++)
            {
                executeCopiedOnMainThread[i]();
            }
        }
    }
}
