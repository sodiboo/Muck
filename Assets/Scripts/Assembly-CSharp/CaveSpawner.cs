using UnityEngine;
using System;

public class CaveSpawner : MonoBehaviour
{
	[Serializable]
	public class WeightedSpawn
	{
		public GameObject prefab;
		public float weight;
	}

	public WeightedSpawn[] structurePrefabs;
	public int maxCaves;
	public int minCaves;
	public LayerMask whatIsTerrain;
	public bool dontAddToResourceManager;
}
