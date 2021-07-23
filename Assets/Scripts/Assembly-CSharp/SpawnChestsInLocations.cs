using System;
using System.Collections.Generic;
using UnityEngine;

public class SpawnChestsInLocations : MonoBehaviour
{
    [Serializable]
    public class WeightedTables
    {
        public LootDrop table;

        public float weight;
    }

    public Transform[] positions;

    public WeightedTables[] lootTables;

    public GameObject chest;

    private float totalWeight;

    public void SetChests(ConsistentRandom rand)
    {
        WeightedTables[] array = lootTables;
        foreach (WeightedTables weightedTables in array)
        {
            totalWeight += weightedTables.weight;
        }
        int num = rand.Next(0, positions.Length) + 1;
        List<int> list = new List<int>();
        for (int j = 0; j < positions.Length; j++)
        {
            list.Add(j);
        }
        for (int k = 0; k < num; k++)
        {
            int index = rand.Next(0, list.Count);
            rand.Next(0, lootTables.Length);
            int num2 = list[index];
            list.Remove(num2);
            Vector3 position = positions[num2].position;
            Quaternion rotation = positions[num2].rotation;
            List<InventoryItem> loot = FindLootTable(lootTables, totalWeight, rand).GetLoot(rand);
            Chest componentInChildren = UnityEngine.Object.Instantiate(chest, position, rotation).GetComponentInChildren<Chest>();
            int nextId = ChestManager.Instance.GetNextId();
            ChestManager.Instance.AddChest(componentInChildren, nextId);
            componentInChildren.InitChest(loot, rand);
        }
    }

    public LootDrop FindLootTable(WeightedTables[] structurePrefabs, float totalWeight, ConsistentRandom rand)
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
}
