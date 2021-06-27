using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200010E RID: 270
public class SpawnChestsInLocations : MonoBehaviour
{
	// Token: 0x060007E9 RID: 2025 RVA: 0x00027EF4 File Offset: 0x000260F4
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
			Chest componentInChildren = Instantiate<GameObject>(this.chest, position, rotation).GetComponentInChildren<Chest>();
			int nextId = ChestManager.Instance.GetNextId();
			ChestManager.Instance.AddChest(componentInChildren, nextId);
			componentInChildren.InitChest(loot, rand);
		}
	}

	// Token: 0x060007EA RID: 2026 RVA: 0x00028024 File Offset: 0x00026224
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

	// Token: 0x0400078A RID: 1930
	public Transform[] positions;

	// Token: 0x0400078B RID: 1931
	public SpawnChestsInLocations.WeightedTables[] lootTables;

	// Token: 0x0400078C RID: 1932
	public GameObject chest;

	// Token: 0x0400078D RID: 1933
	private float totalWeight;

	// Token: 0x0200017F RID: 383
	[Serializable]
	public class WeightedTables
	{
		// Token: 0x04000984 RID: 2436
		public LootDrop table;

		// Token: 0x04000985 RID: 2437
		public float weight;
	}
}
