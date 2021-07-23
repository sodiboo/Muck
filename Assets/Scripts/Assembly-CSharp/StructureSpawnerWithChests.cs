using UnityEngine;

public class StructureSpawnerWithChests : StructureSpawner
{
    public override void Process(GameObject newStructure, RaycastHit hit)
    {
        newStructure.transform.rotation = Quaternion.LookRotation(hit.normal);
        SpawnChestsInLocations componentInChildren = newStructure.GetComponentInChildren<SpawnChestsInLocations>();
        if ((bool)componentInChildren)
        {
            componentInChildren.SetChests(randomGen);
        }
        SpawnPowerupsInLocations componentInChildren2 = newStructure.GetComponentInChildren<SpawnPowerupsInLocations>();
        if ((bool)componentInChildren2)
        {
            componentInChildren2.SetChests(randomGen);
        }
    }
}
