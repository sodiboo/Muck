using System;

// Token: 0x02000100 RID: 256
public class PickupZoneGenerator : SpawnZoneGenerator<InventoryItem>
{
	// Token: 0x060006B0 RID: 1712 RVA: 0x00006348 File Offset: 0x00004548
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	// Token: 0x060006B1 RID: 1713 RVA: 0x00022A30 File Offset: 0x00020C30
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
