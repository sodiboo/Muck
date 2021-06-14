using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200005B RID: 91
public class MobZoneManager : MonoBehaviour
{
	// Token: 0x060001DE RID: 478 RVA: 0x00003646 File Offset: 0x00001846
	private void Awake()
	{
		MobZoneManager.zoneId = 0;
		MobZoneManager.Instance = this;
		this.zones = new Dictionary<int, SpawnZone>();
	}

	// Token: 0x060001DF RID: 479 RVA: 0x0000F0C8 File Offset: 0x0000D2C8
	public void AddZones(List<SpawnZone> zones)
	{
		foreach (SpawnZone spawnZone in zones)
		{
			this.AddZone(spawnZone, spawnZone.id);
		}
	}

	// Token: 0x060001E0 RID: 480 RVA: 0x0000F11C File Offset: 0x0000D31C
	public void AddZone(SpawnZone mz, int id)
	{
		mz.SetId(id);
		this.zones.Add(id, mz);
		if (this.attatchDebug)
		{
		Instantiate<GameObject>(this.debug, mz.transform).GetComponentInChildren<DebugObject>().text = "id" + id;
		}
	}

	// Token: 0x060001E1 RID: 481 RVA: 0x0000365F File Offset: 0x0000185F
	public int GetNextId()
	{
		return MobZoneManager.zoneId++;
	}

	// Token: 0x060001E2 RID: 482 RVA: 0x0000366E File Offset: 0x0000186E
	public void RemoveZone(int mobId)
	{
		this.zones.Remove(mobId);
	}

	// Token: 0x040001F4 RID: 500
	public Dictionary<int, SpawnZone> zones;

	// Token: 0x040001F5 RID: 501
	private static int zoneId;

	// Token: 0x040001F6 RID: 502
	public bool attatchDebug;

	// Token: 0x040001F7 RID: 503
	public GameObject debug;

	// Token: 0x040001F8 RID: 504
	public static MobZoneManager Instance;
}
