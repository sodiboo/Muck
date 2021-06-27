using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200006A RID: 106
public class MobZoneManager : MonoBehaviour
{
	// Token: 0x06000261 RID: 609 RVA: 0x0000E043 File Offset: 0x0000C243
	private void Awake()
	{
		MobZoneManager.zoneId = 0;
		MobZoneManager.Instance = this;
		this.zones = new Dictionary<int, SpawnZone>();
	}

	// Token: 0x06000262 RID: 610 RVA: 0x0000E05C File Offset: 0x0000C25C
	public void AddZones(List<SpawnZone> zones)
	{
		foreach (SpawnZone spawnZone in zones)
		{
			this.AddZone(spawnZone, spawnZone.id);
		}
	}

	// Token: 0x06000263 RID: 611 RVA: 0x0000E0B0 File Offset: 0x0000C2B0
	public void AddZone(SpawnZone mz, int id)
	{
		mz.SetId(id);
		this.zones.Add(id, mz);
		if (this.attatchDebug)
		{
			Instantiate<GameObject>(this.debug, mz.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	// Token: 0x06000264 RID: 612 RVA: 0x0000E104 File Offset: 0x0000C304
	public int GetNextId()
	{
		return MobZoneManager.zoneId++;
	}

	// Token: 0x06000265 RID: 613 RVA: 0x0000E113 File Offset: 0x0000C313
	public void RemoveZone(int mobId)
	{
		this.zones.Remove(mobId);
	}

	// Token: 0x0400027D RID: 637
	public Dictionary<int, SpawnZone> zones;

	// Token: 0x0400027E RID: 638
	private static int zoneId;

	// Token: 0x0400027F RID: 639
	public bool attatchDebug;

	// Token: 0x04000280 RID: 640
	public GameObject debug;

	// Token: 0x04000281 RID: 641
	public static MobZoneManager Instance;
}
