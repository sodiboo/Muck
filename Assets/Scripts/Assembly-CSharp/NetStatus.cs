using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class NetStatus : MonoBehaviour
{
    private static LinkedList<int> pings = new LinkedList<int>();

    private static int pingBuffer = 2;

    private void Awake()
    {
        InvokeRepeating("SlowUpdate", 1f, 1f);
    }

    private void SlowUpdate()
    {
        if ((bool)GameManager.instance)
        {
            ClientSend.PingServer();
        }
    }

    public static void AddPing(int p)
    {
        pings.AddFirst(p);
        if (pings.Count > pingBuffer)
        {
            pings.RemoveLast();
        }
    }

    public static int GetPing()
    {
        if (pings.Count > 0)
        {
            return (int)pings.Average();
        }
        return 0;
    }
}
