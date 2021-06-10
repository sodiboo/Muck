
using UnityEngine;

// Token: 0x020000EE RID: 238
public class StructureSpawnerWithChests : StructureSpawner
{
	// Token: 0x0600070F RID: 1807 RVA: 0x00023314 File Offset: 0x00021514
	public override void Process(GameObject newStructure, RaycastHit hit)
	{
		newStructure.transform.rotation = Quaternion.LookRotation(hit.normal);
		SpawnChestsInLocations componentInChildren = newStructure.GetComponentInChildren<SpawnChestsInLocations>();
		if (componentInChildren)
		{
			componentInChildren.SetChests(this.randomGen);
		}
		SpawnPowerupsInLocations componentInChildren2 = newStructure.GetComponentInChildren<SpawnPowerupsInLocations>();
		if (componentInChildren2)
		{
			componentInChildren2.SetChests(this.randomGen);
		}
	}
}
