using System;

// Token: 0x020000FF RID: 255
public class MobZoneGenerator : SpawnZoneGenerator<MobType>
{
	// Token: 0x060006AD RID: 1709 RVA: 0x0000630E File Offset: 0x0000450E
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	// Token: 0x060006AE RID: 1710 RVA: 0x00006320 File Offset: 0x00004520
	public override SpawnZone ProcessZone(SpawnZone zone)
	{
		((MobZone)zone).mobType = base.FindObjectToSpawn(this.entities, this.totalWeight);
		return zone;
	}
}
