using System;
using System.Collections.Generic;
using UnityEngine;

public class SpawnResourcesInLocations : MonoBehaviour
{
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

	public Transform[] positions;

	public SpawnResourcesInLocations.WeightedTables[] lootTables;

	public int minResources;

	public bool randomRotation = true;

	private float totalWeight;

	[Serializable]
	public class WeightedTables
	{
		public GameObject resource;

		public float weight;
	}
}
