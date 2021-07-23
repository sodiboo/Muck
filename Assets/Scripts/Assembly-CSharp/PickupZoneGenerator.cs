public class PickupZoneGenerator : SpawnZoneGenerator<InventoryItem>
{
    public override void AddEntitiesToZone()
    {
        MobZoneManager.Instance.AddZones(zones);
    }

    public override SpawnZone ProcessZone(SpawnZone zone)
    {
        GrowableFoodZone growableFoodZone = (GrowableFoodZone)zone;
        growableFoodZone.spawnItems = entities;
        growableFoodZone.spawnChance = weights;
        float num = 0f;
        float[] array = weights;
        foreach (float num2 in array)
        {
            num += num2;
        }
        growableFoodZone.totalWeight = num;
        return growableFoodZone;
    }
}
