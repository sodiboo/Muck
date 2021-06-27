using System;
using UnityEngine;

// Token: 0x0200011D RID: 285
public class StructureSpawnerWithChests : StructureSpawner
{
	// Token: 0x06000851 RID: 2129 RVA: 0x00029BE8 File Offset: 0x00027DE8
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
