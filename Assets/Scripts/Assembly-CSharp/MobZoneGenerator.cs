using System;

public class MobZoneGenerator : SpawnZoneGenerator<MobType>
{
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	public override SpawnZone ProcessZone(SpawnZone zone)
	{
		((MobZone)zone).mobType = base.FindObjectToSpawn(this.entities, this.totalWeight);
		return zone;
	}
}
