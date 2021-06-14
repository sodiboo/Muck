using System;
using UnityEngine;

// Token: 0x02000142 RID: 322
public class StructureSpawnerWithChests : StructureSpawner
{
	// Token: 0x060007CB RID: 1995 RVA: 0x00026860 File Offset: 0x00024A60
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
