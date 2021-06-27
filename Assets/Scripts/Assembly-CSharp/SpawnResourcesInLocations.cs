using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000113 RID: 275
public class SpawnResourcesInLocations : MonoBehaviour
{
	// Token: 0x060007F6 RID: 2038 RVA: 0x000282C8 File Offset: 0x000264C8
	public void SetResources(ConsistentRandom rand)
	{
		foreach (SpawnResourcesInLocations.WeightedTables weightedTables in this.lootTables)
		{
			this.totalWeight += weightedTables.weight;
		}
		int num = rand.Next(this.minResources, this.positions.Length);
		List<int> list = new List<int>();
		for (int j = 0; j < this.positions.Length; j++)
		{
			list.Add(j);
		}
		for (int k = 0; k < num; k++)
		{
			int index = rand.Next(0, list.Count);
			rand.Next(0, this.lootTables.Length);
			int num2 = list[index];
			list.Remove(num2);
			Vector3 position = this.positions[num2].position;
			Vector3 eulerAngles;
			if (this.randomRotation)
			{
				eulerAngles = new Vector3((float)rand.NextDouble() * 360f, (float)rand.NextDouble() * 360f, (float)rand.NextDouble() * 360f);
			}
			else
			{
				eulerAngles = this.positions[num2].rotation.eulerAngles;
			}
			Quaternion rotation = Quaternion.Euler(eulerAngles);
			GameObject gameObject = Instantiate<GameObject>(this.FindResource(this.lootTables, this.totalWeight, rand), position, rotation);
			int nextId = ResourceManager.Instance.GetNextId();
			gameObject.GetComponent<Hitable>().SetId(nextId);
			ResourceManager.Instance.AddObject(nextId, gameObject);
		}
	}

	// Token: 0x060007F7 RID: 2039 RVA: 0x00028438 File Offset: 0x00026638
	public GameObject FindResource(SpawnResourcesInLocations.WeightedTables[] structurePrefabs, float totalWeight, ConsistentRandom rand)
	{
		float num = (float)rand.NextDouble();
		float num2 = 0f;
		for (int i = 0; i < structurePrefabs.Length; i++)
		{
			num2 += structurePrefabs[i].weight;
			if (num < num2 / totalWeight)
			{
				return structurePrefabs[i].resource;
			}
		}
		return structurePrefabs[0].resource;
	}

	// Token: 0x04000796 RID: 1942
	public Transform[] positions;

	// Token: 0x04000797 RID: 1943
	public SpawnResourcesInLocations.WeightedTables[] lootTables;

	// Token: 0x04000798 RID: 1944
	public int minResources;

	// Token: 0x04000799 RID: 1945
	public bool randomRotation = true;

	// Token: 0x0400079A RID: 1946
	private float totalWeight;

	// Token: 0x02000180 RID: 384
	[Serializable]
	public class WeightedTables
	{
		// Token: 0x04000986 RID: 2438
		public GameObject resource;

		// Token: 0x04000987 RID: 2439
		public float weight;
	}
}
