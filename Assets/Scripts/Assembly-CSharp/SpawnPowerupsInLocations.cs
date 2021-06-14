using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000132 RID: 306
public class SpawnPowerupsInLocations : MonoBehaviour
{
	// Token: 0x06000764 RID: 1892 RVA: 0x00024DD4 File Offset: 0x00022FD4
	public void SetChests(ConsistentRandom rand)
	{
		int num = rand.Next(0, this.positions.Length) + 1;
		float num2 = 0f;
		foreach (StructureSpawner.WeightedSpawn weightedSpawn in this.powerupChests)
		{
			num2 += weightedSpawn.weight;
		}
		List<int> list = new List<int>();
		for (int j = 0; j < this.positions.Length; j++)
		{
			list.Add(j);
		}
		for (int k = 0; k < num; k++)
		{
			int index = rand.Next(0, list.Count);
			int num3 = list[index];
			list.Remove(num3);
			Vector3 position = this.positions[num3].position;
			Quaternion rotation = this.positions[num3].rotation;
			GameObject gameObject =Instantiate<GameObject>(this.FindObjectToSpawn(this.powerupChests, num2, rand), position, rotation);
			int nextId = ResourceManager.Instance.GetNextId();
			LootContainerInteract componentInChildren = gameObject.GetComponentInChildren<LootContainerInteract>();
			componentInChildren.price = 0;
			componentInChildren.SetId(nextId);
			ResourceManager.Instance.AddObject(nextId, gameObject);
		}
	}

	// Token: 0x06000765 RID: 1893 RVA: 0x00024EE8 File Offset: 0x000230E8
	public GameObject FindObjectToSpawn(StructureSpawner.WeightedSpawn[] prefabs, float totalWeight, ConsistentRandom randomGen)
	{
		float num = (float)randomGen.NextDouble();
		float num2 = 0f;
		for (int i = 0; i < prefabs.Length; i++)
		{
			num2 += prefabs[i].weight;
			if (num < num2 / totalWeight)
			{
				return prefabs[i].prefab;
			}
		}
		return prefabs[0].prefab;
	}

	// Token: 0x040007A4 RID: 1956
	public Transform[] positions;

	// Token: 0x040007A5 RID: 1957
	public StructureSpawner.WeightedSpawn[] powerupChests;
}
