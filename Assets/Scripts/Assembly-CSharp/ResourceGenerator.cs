using System;
using System.Collections.Generic;
using UnityEngine;

public class ResourceGenerator : MonoBehaviour
{
	public float worldScale { get; set; } = 12f;

	private void Start()
	{
		this.randomGen = new ConsistentRandom(GameManager.GetSeed());
		foreach (StructureSpawner.WeightedSpawn weightedSpawn in this.resourcePrefabs)
		{
			this.totalWeight += weightedSpawn.weight;
		}
		this.GenerateForest();
		if (ResourceManager.Instance)
		{
			ResourceManager.Instance.AddResources(this.resources);
		}
	}

	public float topLeftX { get; private set; }

	public float topLeftZ { get; private set; }

	private void GenerateForest()
	{
		int nextGenOffset;
		if (this.forceSeedOffset != -1)
		{
			nextGenOffset = this.forceSeedOffset;
		}
		else
		{
			nextGenOffset = ResourceManager.GetNextGenOffset();
		}
		float[,] array = this.mapGenerator.GeneratePerlinNoiseMap(GameManager.GetSeed());
		float[,] array2 = this.mapGenerator.GeneratePerlinNoiseMap(this.noiseData, GameManager.GetSeed() + nextGenOffset, this.useFalloffMap);
		this.width = array.GetLength(0);
		this.height = array.GetLength(1);
		this.topLeftX = (float)(this.width - 1) / -2f;
		this.topLeftZ = (float)(this.height - 1) / 2f;
		this.resources = new List<GameObject>[this.drawChunks.nChunks];
		for (int i = 0; i < this.resources.Length; i++)
		{
			this.resources[i] = new List<GameObject>();
		}
		int num = this.density;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		while (num3 < this.minSpawnAmount && num4 < 100)
		{
			num4++;
			for (int j = 0; j < this.height; j += num)
			{
				for (int k = 0; k < this.width; k += num)
				{
					if (array[k, j] >= this.minSpawnHeight && array[k, j] <= this.maxSpawnHeight)
					{
						float num5 = array2[k, j];
						if (num5 >= this.spawnThreshold)
						{
							num5 = (num5 - this.spawnThreshold) / (1f - this.spawnThreshold);
							float num6 = this.noiseDistribution.Evaluate((float)this.randomGen.NextDouble());
							num2++;
							if (num6 > 1f - num5)
							{
								Vector3 vector = new Vector3(this.topLeftX + (float)k, 100f, this.topLeftZ - (float)j) * this.worldScale;
								vector += new Vector3((float)this.randomGen.Next(-this.randPos, this.randPos), 0f, (float)this.randomGen.Next(-this.randPos, this.randPos));
								RaycastHit raycastHit;
								if (Physics.Raycast(vector, Vector3.down, out raycastHit, 1200f))
								{
									vector.y = raycastHit.point.y;
									num3++;
									int num7 = this.drawChunks.FindChunk(k, j);
									if (num7 >= this.drawChunks.nChunks)
									{
										num7 = this.drawChunks.nChunks - 1;
									}
									this.resources[num7].Add(this.SpawnTree(vector));
								}
							}
						}
					}
				}
			}
		}
		this.totalResources = num3;
		this.drawChunks.InitChunks(this.resources);
		this.drawChunks.totalTrees = this.totalResources;
	}

	private GameObject SpawnTree(Vector3 pos)
	{
		Quaternion rotation = Quaternion.Euler((float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.x * 2f, (float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.y * 2f, (float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.z * 2f);
		float num = (float)this.randomGen.NextDouble() * (this.randomScale.y - this.randomScale.x);
		Vector3 vector = Vector3.one * (this.randomScale.x + num);
		GameObject gameObject = Instantiate<GameObject>(this.FindObjectToSpawn(this.resourcePrefabs, this.totalWeight), pos, rotation);
		gameObject.transform.localScale = vector;
		gameObject.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
		HitableResource component = gameObject.GetComponent<HitableResource>();
		if (component)
		{
			component.SetDefaultScale(vector);
			component.PopIn();
		}
		gameObject.SetActive(false);
		return gameObject;
	}

	public GameObject FindObjectToSpawn(StructureSpawner.WeightedSpawn[] structurePrefabs, float totalWeight)
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

	public DrawChunks drawChunks;

	public StructureSpawner.WeightedSpawn[] resourcePrefabs;

	private float totalWeight;

	public MapGenerator mapGenerator;

	private int density = 1;

	public float spawnThreshold = 0.45f;

	public AnimationCurve noiseDistribution;

	public AnimationCurve heightDistribution;

	public List<GameObject>[] resources;

	private ConsistentRandom randomGen;

	public NoiseData noiseData;

	[Header("Variety")]
	public Vector3 randomRotation;

	public Vector2 randomScale;

	public int randPos = 12;

	private int totalResources;

	public int forceSeedOffset = -1;

	public float minSpawnHeight = 0.4f;

	public float maxSpawnHeight = 0.35f;

	public int width;

	public int height;

	public bool useFalloffMap = true;

	public int minSpawnAmount = 10;

	public ResourceGenerator.SpawnType type;

	public enum SpawnType
	{
		Static,
		Pickup
	}
}
