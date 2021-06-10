
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200004D RID: 77
public class MobZoneManager : MonoBehaviour
{
	// Token: 0x060001B5 RID: 437 RVA: 0x0000A7AC File Offset: 0x000089AC
	private void Awake()
	{
		MobZoneManager.zoneId = 0;
		MobZoneManager.Instance = this;
		this.zones = new Dictionary<int, SpawnZone>();
	}

	// Token: 0x060001B6 RID: 438 RVA: 0x0000A7C8 File Offset: 0x000089C8
	public void AddZones(List<SpawnZone> zones)
	{
		foreach (SpawnZone spawnZone in zones)
		{
			this.AddZone(spawnZone, spawnZone.id);
		}
	}

	// Token: 0x060001B7 RID: 439 RVA: 0x0000A81C File Offset: 0x00008A1C
	public void AddZone(SpawnZone mz, int id)
	{
		mz.SetId(id);
		this.zones.Add(id, mz);
		if (this.attatchDebug)
		{
		Instantiate(this.debug, mz.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	// Token: 0x060001B8 RID: 440 RVA: 0x0000A870 File Offset: 0x00008A70
	public int GetNextId()
	{
		return MobZoneManager.zoneId++;
	}

	// Token: 0x060001B9 RID: 441 RVA: 0x0000A87F File Offset: 0x00008A7F
	public void RemoveZone(int mobId)
	{
		this.zones.Remove(mobId);
	}

	// Token: 0x040001B8 RID: 440
	public Dictionary<int, SpawnZone> zones;

	// Token: 0x040001B9 RID: 441
	private static int zoneId;

	// Token: 0x040001BA RID: 442
	public bool attatchDebug;

	// Token: 0x040001BB RID: 443
	public GameObject debug;

	// Token: 0x040001BC RID: 444
	public static MobZoneManager Instance;
}
