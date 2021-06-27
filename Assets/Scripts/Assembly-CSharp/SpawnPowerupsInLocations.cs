using System;
using System.Collections.Generic;
using UnityEngine;

public class SpawnPowerupsInLocations : MonoBehaviour
{
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
			GameObject gameObject = Instantiate<GameObject>(this.FindObjectToSpawn(this.powerupChests, num2, rand), position, rotation);
			int nextId = ResourceManager.Instance.GetNextId();
			LootContainerInteract componentInChildren = gameObject.GetComponentInChildren<LootContainerInteract>();
			componentInChildren.price = 0;
			componentInChildren.SetId(nextId);
			ResourceManager.Instance.AddObject(nextId, gameObject);
		}
	}

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

	public Transform[] positions;

	public StructureSpawner.WeightedSpawn[] powerupChests;
}
