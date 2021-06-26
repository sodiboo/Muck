using UnityEngine;
using System;

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
}
