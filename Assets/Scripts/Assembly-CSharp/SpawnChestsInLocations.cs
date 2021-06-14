using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200012E RID: 302
public class SpawnChestsInLocations : MonoBehaviour
{
	// Token: 0x0600075B RID: 1883 RVA: 0x00024BE4 File Offset: 0x00022DE4
	public void SetChests(ConsistentRandom rand)
	{
		foreach (SpawnChestsInLocations.WeightedTables weightedTables in this.lootTables)
		{
			this.totalWeight += weightedTables.weight;
		}
		int num = rand.Next(0, this.positions.Length) + 1;
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
			Quaternion rotation = this.positions[num2].rotation;
			List<InventoryItem> loot = this.FindLootTable(this.lootTables, this.totalWeight, rand).GetLoot(rand);
			Chest componentInChildren =Instantiate<GameObject>(this.chest, position, rotation).GetComponentInChildren<Chest>();
			int nextId = ChestManager.Instance.GetNextId();
			ChestManager.Instance.AddChest(componentInChildren, nextId);
			componentInChildren.InitChest(loot, rand);
		}
	}

	// Token: 0x0600075C RID: 1884 RVA: 0x00024D14 File Offset: 0x00022F14
	public LootDrop FindLootTable(SpawnChestsInLocations.WeightedTables[] structurePrefabs, float totalWeight, ConsistentRandom rand)
	{
		float num = (float)rand.NextDouble();
		float num2 = 0f;
		for (int i = 0; i < structurePrefabs.Length; i++)
		{
			num2 += structurePrefabs[i].weight;
			if (num < num2 / totalWeight)
			{
				return structurePrefabs[i].table;
			}
		}
		MonoBehaviour.print("couldnt find, just returning 0");
		return structurePrefabs[0].table;
	}

	// Token: 0x0400079A RID: 1946
	public Transform[] positions;

	// Token: 0x0400079B RID: 1947
	public SpawnChestsInLocations.WeightedTables[] lootTables;

	// Token: 0x0400079C RID: 1948
	public GameObject chest;

	// Token: 0x0400079D RID: 1949
	private float totalWeight;

	// Token: 0x0200012F RID: 303
	[Serializable]
	public class WeightedTables
	{
		// Token: 0x0400079E RID: 1950
		public LootDrop table;

		// Token: 0x0400079F RID: 1951
		public float weight;
	}
}
