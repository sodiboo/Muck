using System;
using System.Collections.Generic;
using UnityEngine;

public class SpawnChestsInLocations : MonoBehaviour
{
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
			var obj = Instantiate<GameObject>(this.chest, position, rotation);
			Chest componentInChildren = obj.GetComponentInChildren<Chest>();
			int nextId = ChestManager.Instance.GetNextId();
			ChestManager.Instance.AddChest(componentInChildren, nextId);
			obj.GetComponent<Hitable>().SetId(nextId);
			ResourceManager.Instance.AddObject(nextId, obj);
			componentInChildren.InitChest(loot, rand);
		}
	}

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

	public Transform[] positions;

	public SpawnChestsInLocations.WeightedTables[] lootTables;

	public GameObject chest;

	private float totalWeight;

	[Serializable]
	public class WeightedTables
	{
		public LootDrop table;

		public float weight;
	}
}
