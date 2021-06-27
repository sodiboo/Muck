using System;
using System.Collections.Generic;
using UnityEngine;

public class MobZoneManager : MonoBehaviour
{
	private void Awake()
	{
		MobZoneManager.zoneId = 0;
		MobZoneManager.Instance = this;
		this.zones = new Dictionary<int, SpawnZone>();
	}

	public void AddZones(List<SpawnZone> zones)
	{
		foreach (SpawnZone spawnZone in zones)
		{
			this.AddZone(spawnZone, spawnZone.id);
		}
	}

	public void AddZone(SpawnZone mz, int id)
	{
		mz.SetId(id);
		this.zones.Add(id, mz);
		if (this.attatchDebug)
		{
			Instantiate<GameObject>(this.debug, mz.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	public int GetNextId()
	{
		return MobZoneManager.zoneId++;
	}

	public void RemoveZone(int mobId)
	{
		this.zones.Remove(mobId);
	}

	public Dictionary<int, SpawnZone> zones;

	private static int zoneId;

	public bool attatchDebug;

	public GameObject debug;

	public static MobZoneManager Instance;
}
