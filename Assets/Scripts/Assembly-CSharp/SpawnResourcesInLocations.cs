using UnityEngine;
using System;

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
	public bool randomRotation;
}
