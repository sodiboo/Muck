using System.Collections.Generic;
using UnityEngine;

public class MobZoneManager : MonoBehaviour
{
    public Dictionary<int, SpawnZone> zones;

    private static int zoneId;

    public bool attatchDebug;

    public GameObject debug;

    public static MobZoneManager Instance;

    private void Awake()
    {
        zoneId = 0;
        Instance = this;
        zones = new Dictionary<int, SpawnZone>();
    }

    public void AddZones(List<SpawnZone> zones)
    {
        foreach (SpawnZone zone in zones)
        {
            AddZone(zone, zone.id);
        }
    }

    public void AddZone(SpawnZone mz, int id)
    {
        mz.SetId(id);
        zones.Add(id, mz);
        if (attatchDebug)
        {
            Object.Instantiate(debug, mz.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
        }
    }

    public int GetNextId()
    {
        return zoneId++;
    }

    public void RemoveZone(int mobId)
    {
        zones.Remove(mobId);
    }
}
