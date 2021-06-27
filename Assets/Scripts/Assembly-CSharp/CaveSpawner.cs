using System;
using System.Collections.Generic;
using UnityEngine;

public class CaveSpawner : MonoBehaviour
{
	public float worldScale { get; set; } = 12f;

	private void Start()
	{
		this.structures = new List<GameObject>();
		this.randomGen = new ConsistentRandom(GameManager.GetSeed() + ResourceManager.GetNextGenOffset());
		this.shrines = new Vector3[this.maxCaves];
		this.mapChunkSize = MapGenerator.mapChunkSize;
		this.worldScale *= this.worldEdgeBuffer;
		foreach (CaveSpawner.WeightedSpawn weightedSpawn in this.structurePrefabs)
		{
			this.totalWeight += weightedSpawn.weight;
		}
		int j = 0;
		int num = 0;
		while (j < this.maxCaves)
		{
			num++;
			float x = (float)(this.randomGen.NextDouble() * 2.0 - 1.0) * (float)this.mapChunkSize / 2f;
			float z = (float)(this.randomGen.NextDouble() * 2.0 - 1.0) * (float)this.mapChunkSize / 2f;
			Vector3 vector = new Vector3(x, 0f, z) * this.worldScale;
			vector.y = 200f;
			Debug.DrawLine(vector, vector + Vector3.down * 500f, Color.cyan, 50f);
			RaycastHit hit;
			if (Physics.Raycast(vector, Vector3.down, out hit, 500f, this.whatIsTerrain))
			{
				if (WorldUtility.WorldHeightToBiome(hit.point.y) != TextureData.TerrainType.Grass || Mathf.Abs(Vector3.Angle(Vector3.up, hit.normal)) > 15f)
				{
					continue;
				}
				this.shrines[j] = hit.point;
				j++;
				GameObject gameObject = this.FindObjectToSpawn(this.structurePrefabs, this.totalWeight);
				GameObject gameObject2 = Instantiate<GameObject>(gameObject, hit.point, gameObject.transform.rotation);
				if (!this.dontAddToResourceManager)
				{
					gameObject2.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
				}
				this.structures.Add(gameObject2);
				this.Process(gameObject2, hit);
			}
			if ((num > this.maxCaves * 2 && j >= this.minCaves) || num > this.maxCaves * 10)
			{
				break;
			}
		}
		if (!this.dontAddToResourceManager)
		{
			ResourceManager.Instance.AddResources(this.structures);
		}
	}

	public virtual void Process(GameObject newStructure, RaycastHit hit)
	{
		Cave component = newStructure.GetComponent<Cave>();
		component.transform.rotation = Quaternion.Euler(-90f, (float)(this.randomGen.Next() * 360), 0f);
		component.SetCave(this.randomGen);
	}

	private void OnDrawGizmos()
	{
	}

	public GameObject FindObjectToSpawn(CaveSpawner.WeightedSpawn[] structurePrefabs, float totalWeight)
	{
		float num = (float)this.randomGen.NextDouble();
		float num2 = 0f;
		for (int i = 0; i < structurePrefabs.Length; i++)
		{
			num2 += structurePrefabs[i].weight;
			if (num < num2 / totalWeight)
			{
				return structurePrefabs[i].prefab;
			}
		}
		return structurePrefabs[0].prefab;
	}

	public CaveSpawner.WeightedSpawn[] structurePrefabs;

	private int mapChunkSize;

	private float worldEdgeBuffer = 0.6f;

	public int maxCaves = 50;

	public int minCaves = 3;

	protected ConsistentRandom randomGen;

	public LayerMask whatIsTerrain;

	private List<GameObject> structures;

	public bool dontAddToResourceManager;

	private Vector3[] shrines;

	private float totalWeight;

	[Serializable]
	public class WeightedSpawn
	{
		public GameObject prefab;

		public float weight;
	}
}
