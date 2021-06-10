using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000E2 RID: 226
public class SpawnChestsInLocations : MonoBehaviour
{
	// Token: 0x060006AE RID: 1710 RVA: 0x000218B0 File Offset: 0x0001FAB0
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

	// Token: 0x060006AF RID: 1711 RVA: 0x000219E0 File Offset: 0x0001FBE0
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

	// Token: 0x0400064F RID: 1615
	public Transform[] positions;

	// Token: 0x04000650 RID: 1616
	public SpawnChestsInLocations.WeightedTables[] lootTables;

	// Token: 0x04000651 RID: 1617
	public GameObject chest;

	// Token: 0x04000652 RID: 1618
	private float totalWeight;

	// Token: 0x0200013E RID: 318
	[Serializable]
	public class WeightedTables
	{
		// Token: 0x040007FD RID: 2045
		public LootDrop table;

		// Token: 0x040007FE RID: 2046
		public float weight;
	}
}
