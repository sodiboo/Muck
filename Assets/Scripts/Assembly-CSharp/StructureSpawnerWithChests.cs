using System;
using UnityEngine;

public class StructureSpawnerWithChests : StructureSpawner
{
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
