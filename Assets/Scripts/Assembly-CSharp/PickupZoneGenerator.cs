using System;

// Token: 0x020000EB RID: 235
public class PickupZoneGenerator : SpawnZoneGenerator<InventoryItem>
{
	// Token: 0x06000737 RID: 1847 RVA: 0x00025027 File Offset: 0x00023227
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	// Token: 0x06000738 RID: 1848 RVA: 0x0002503C File Offset: 0x0002323C
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
