using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000086 RID: 134
public class ResourceGenerator : MonoBehaviour
{
	// Token: 0x17000025 RID: 37
	// (get) Token: 0x06000332 RID: 818 RVA: 0x000117F2 File Offset: 0x0000F9F2
	// (set) Token: 0x06000333 RID: 819 RVA: 0x000117FA File Offset: 0x0000F9FA
	public float worldScale { get; set; } = 12f;

	// Token: 0x06000334 RID: 820 RVA: 0x00011804 File Offset: 0x0000FA04
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

	// Token: 0x17000026 RID: 38
	// (get) Token: 0x06000335 RID: 821 RVA: 0x0001186F File Offset: 0x0000FA6F
	// (set) Token: 0x06000336 RID: 822 RVA: 0x00011877 File Offset: 0x0000FA77
	public float topLeftX { get; private set; }

	// Token: 0x17000027 RID: 39
	// (get) Token: 0x06000337 RID: 823 RVA: 0x00011880 File Offset: 0x0000FA80
	// (set) Token: 0x06000338 RID: 824 RVA: 0x00011888 File Offset: 0x0000FA88
	public float topLeftZ { get; private set; }

	// Token: 0x06000339 RID: 825 RVA: 0x00011894 File Offset: 0x0000FA94
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

	// Token: 0x0600033A RID: 826 RVA: 0x00011B60 File Offset: 0x0000FD60
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

	// Token: 0x0600033B RID: 827 RVA: 0x00011C88 File Offset: 0x0000FE88
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

	// Token: 0x0400032C RID: 812
	public DrawChunks drawChunks;

	// Token: 0x0400032D RID: 813
	public StructureSpawner.WeightedSpawn[] resourcePrefabs;

	// Token: 0x0400032E RID: 814
	private float totalWeight;

	// Token: 0x0400032F RID: 815
	public MapGenerator mapGenerator;

	// Token: 0x04000330 RID: 816
	private int density = 1;

	// Token: 0x04000331 RID: 817
	public float spawnThreshold = 0.45f;

	// Token: 0x04000332 RID: 818
	public AnimationCurve noiseDistribution;

	// Token: 0x04000333 RID: 819
	public AnimationCurve heightDistribution;

	// Token: 0x04000334 RID: 820
	public List<GameObject>[] resources;

	// Token: 0x04000335 RID: 821
	private ConsistentRandom randomGen;

	// Token: 0x04000336 RID: 822
	public NoiseData noiseData;

	// Token: 0x04000338 RID: 824
	[Header("Variety")]
	public Vector3 randomRotation;

	// Token: 0x04000339 RID: 825
	public Vector2 randomScale;

	// Token: 0x0400033A RID: 826
	public int randPos = 12;

	// Token: 0x0400033B RID: 827
	private int totalResources;

	// Token: 0x0400033C RID: 828
	public int forceSeedOffset = -1;

	// Token: 0x0400033F RID: 831
	public float minSpawnHeight = 0.4f;

	// Token: 0x04000340 RID: 832
	public float maxSpawnHeight = 0.35f;

	// Token: 0x04000341 RID: 833
	public int width;

	// Token: 0x04000342 RID: 834
	public int height;

	// Token: 0x04000343 RID: 835
	public bool useFalloffMap = true;

	// Token: 0x04000344 RID: 836
	public int minSpawnAmount = 10;

	// Token: 0x04000345 RID: 837
	public ResourceGenerator.SpawnType type;

	// Token: 0x0200014E RID: 334
	public enum SpawnType
	{
		// Token: 0x040008BD RID: 2237
		Static,
		// Token: 0x040008BE RID: 2238
		Pickup
	}
}
