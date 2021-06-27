using System;

// Token: 0x020000EA RID: 234
public class MobZoneGenerator : SpawnZoneGenerator<MobType>
{
	// Token: 0x06000734 RID: 1844 RVA: 0x00024FED File Offset: 0x000231ED
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	// Token: 0x06000735 RID: 1845 RVA: 0x00024FFF File Offset: 0x000231FF
	public override SpawnZone ProcessZone(SpawnZone zone)
	{
		((MobZone)zone).mobType = base.FindObjectToSpawn(this.entities, this.totalWeight);
		return zone;
	}
}
