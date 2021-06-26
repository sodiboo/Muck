using UnityEngine;
using System;

public class StructureSpawner : MonoBehaviour
{
	[Serializable]
	public class WeightedSpawn
	{
		public GameObject prefab;
		public float weight;
	}

	public WeightedSpawn[] structurePrefabs;
	public int nShrines;
	public LayerMask whatIsTerrain;
	public bool dontAddToResourceManager;
}
