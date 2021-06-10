

// Token: 0x020000C3 RID: 195
public class PickupZoneGenerator : SpawnZoneGenerator<InventoryItem>
{
	// Token: 0x0600061D RID: 1565 RVA: 0x0001EF48 File Offset: 0x0001D148
	public override void AddEntitiesToZone()
	{
		MobZoneManager.Instance.AddZones(this.zones);
	}

	// Token: 0x0600061E RID: 1566 RVA: 0x0001EF5C File Offset: 0x0001D15C
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
