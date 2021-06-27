using System;

public class PickupZoneGenerator : SpawnZoneGenerator<InventoryItem>
{
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	public override SpawnZone ProcessZone(SpawnZone zone)
	{
		GrowableFoodZone growableFoodZone = (GrowableFoodZone)zone;
		growableFoodZone.spawnItems = this.entities;
		growableFoodZone.spawnChance = this.weights;
		float num = 0f;
		foreach (float num2 in this.weights)
		{
			num += num2;
		}
		growableFoodZone.totalWeight = num;
		return growableFoodZone;
	}
}
