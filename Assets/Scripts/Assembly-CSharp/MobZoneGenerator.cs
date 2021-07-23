public class MobZoneGenerator : SpawnZoneGenerator<MobType>
{
    public override void AddEntitiesToZone()
    {
        MobZoneManager.Instance.AddZones(zones);
    }

    public override SpawnZone ProcessZone(SpawnZone zone)
    {
        ((MobZone)zone).mobType = FindObjectToSpawn(entities, totalWeight);
        return zone;
    }
}
