using System;
using System.Collections.Generic;
using UnityEngine;

public class SpawnResourcesInLocations : MonoBehaviour
{
    [Serializable]
    public class WeightedTables
    {
        public GameObject resource;

        public float weight;
    }

    public Transform[] positions;

    public WeightedTables[] lootTables;

    public int minResources;

    public bool randomRotation = true;

    private float totalWeight;

    public void SetResources(ConsistentRandom rand)
    {
        WeightedTables[] array = lootTables;
        foreach (WeightedTables weightedTables in array)
        {
            totalWeight += weightedTables.weight;
        }
        int num = rand.Next(minResources, positions.Length);
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
            Vector3 euler = ((!randomRotation) ? positions[num2].rotation.eulerAngles : new Vector3((float)rand.NextDouble() * 360f, (float)rand.NextDouble() * 360f, (float)rand.NextDouble() * 360f));
            Quaternion rotation = Quaternion.Euler(euler);
            GameObject gameObject = UnityEngine.Object.Instantiate(FindResource(lootTables, totalWeight, rand), position, rotation);
            int nextId = ResourceManager.Instance.GetNextId();
            gameObject.GetComponent<Hitable>().SetId(nextId);
            ResourceManager.Instance.AddObject(nextId, gameObject);
        }
    }

    public GameObject FindResource(WeightedTables[] structurePrefabs, float totalWeight, ConsistentRandom rand)
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
}
