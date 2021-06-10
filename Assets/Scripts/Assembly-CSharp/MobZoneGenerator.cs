

// Token: 0x020000C2 RID: 194
public class MobZoneGenerator : SpawnZoneGenerator<MobType>
{
	// Token: 0x0600061A RID: 1562 RVA: 0x0001EF0E File Offset: 0x0001D10E
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	// Token: 0x0600061B RID: 1563 RVA: 0x0001EF20 File Offset: 0x0001D120
	public override SpawnZone ProcessZone(SpawnZone zone)
	{
		((MobZone)zone).mobType = base.FindObjectToSpawn(this.entities, this.totalWeight);
		return zone;
	}
}
