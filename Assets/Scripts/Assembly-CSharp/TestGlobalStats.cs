using System.Threading.Tasks;
using Steamworks;
using UnityEngine;

public class TestGlobalStats : MonoBehaviour
{
    private Task<Result> a;

    private void Start()
    {
        if (SteamUserStats.RequestCurrentStats())
        {
            a = SteamUserStats.RequestGlobalStatsAsync(60);
            Debug.LogError("REquesting global stats");
        }
        SteamUserStats.OnUserStatsReceived += ReceivedStats;
    }

    private void ReceivedStats(SteamId id, Result r)
    {
    }
}
