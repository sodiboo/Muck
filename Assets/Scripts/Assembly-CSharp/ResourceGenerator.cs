using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000078 RID: 120
public class ResourceGenerator : MonoBehaviour
{
	// Token: 0x1700001F RID: 31
	// (get) Token: 0x06000299 RID: 665 RVA: 0x00003E80 File Offset: 0x00002080
	// (set) Token: 0x0600029A RID: 666 RVA: 0x00003E88 File Offset: 0x00002088
	public float worldScale { get; set; } = 12f;

	// Token: 0x0600029B RID: 667 RVA: 0x00011908 File Offset: 0x0000FB08
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

	// Token: 0x17000020 RID: 32
	// (get) Token: 0x0600029C RID: 668 RVA: 0x00003E91 File Offset: 0x00002091
	// (set) Token: 0x0600029D RID: 669 RVA: 0x00003E99 File Offset: 0x00002099
	public float topLeftX { get; private set; }

	// Token: 0x17000021 RID: 33
	// (get) Token: 0x0600029E RID: 670 RVA: 0x00003EA2 File Offset: 0x000020A2
	// (set) Token: 0x0600029F RID: 671 RVA: 0x00003EAA File Offset: 0x000020AA
	public float topLeftZ { get; private set; }

	// Token: 0x060002A0 RID: 672 RVA: 0x00011974 File Offset: 0x0000FB74
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
		for (int j = 0; j < this.height; j += num)
		{
			for (int k = 0; k < this.width; k += num)
			{
				if (array[k, j] >= this.minSpawnHeight && array[k, j] <= this.maxSpawnHeight)
				{
					float num4 = array2[k, j];
					if (num4 >= this.spawnThreshold)
					{
						num4 = (num4 - this.spawnThreshold) / (1f - this.spawnThreshold);
						float num5 = this.noiseDistribution.Evaluate((float)this.randomGen.NextDouble());
						num2++;
						if (num5 > 1f - num4)
						{
							Vector3 vector = new Vector3(this.topLeftX + (float)k, 100f, this.topLeftZ - (float)j) * this.worldScale;
							vector += new Vector3((float)this.randomGen.Next(-this.randPos, this.randPos), 0f, (float)this.randomGen.Next(-this.randPos, this.randPos));
							RaycastHit raycastHit;
							if (Physics.Raycast(vector, Vector3.down, out raycastHit, 1200f))
							{
								vector.y = raycastHit.point.y;
								num3++;
								int num6 = this.drawChunks.FindChunk(k, j);
								if (num6 >= this.drawChunks.nChunks)
								{
									num6 = this.drawChunks.nChunks - 1;
								}
								this.resources[num6].Add(this.SpawnTree(vector));
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

	// Token: 0x060002A1 RID: 673 RVA: 0x00011C20 File Offset: 0x0000FE20
	private GameObject SpawnTree(Vector3 pos)
	{
		Quaternion rotation = Quaternion.Euler((float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.x * 2f, (float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.y * 2f, (float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.z * 2f);
		float num = (float)this.randomGen.NextDouble() * (this.randomScale.y - this.randomScale.x);
		Vector3 vector = Vector3.one * (this.randomScale.x + num);
		GameObject gameObject =Instantiate<GameObject>(this.FindObjectToSpawn(this.resourcePrefabs, this.totalWeight), pos, rotation);
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

	// Token: 0x060002A2 RID: 674 RVA: 0x00011D48 File Offset: 0x0000FF48
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

	// Token: 0x040002A2 RID: 674
	public DrawChunks drawChunks;

	// Token: 0x040002A3 RID: 675
	public StructureSpawner.WeightedSpawn[] resourcePrefabs;

	// Token: 0x040002A4 RID: 676
	private float totalWeight;

	// Token: 0x040002A5 RID: 677
	public MapGenerator mapGenerator;

	// Token: 0x040002A6 RID: 678
	private int density = 1;

	// Token: 0x040002A7 RID: 679
	public float spawnThreshold = 0.45f;

	// Token: 0x040002A8 RID: 680
	public AnimationCurve noiseDistribution;

	// Token: 0x040002A9 RID: 681
	public AnimationCurve heightDistribution;

	// Token: 0x040002AA RID: 682
	public List<GameObject>[] resources;

	// Token: 0x040002AB RID: 683
	private ConsistentRandom randomGen;

	// Token: 0x040002AC RID: 684
	public NoiseData noiseData;

	// Token: 0x040002AE RID: 686
	[Header("Variety")]
	public Vector3 randomRotation;

	// Token: 0x040002AF RID: 687
	public Vector2 randomScale;

	// Token: 0x040002B0 RID: 688
	public int randPos = 12;

	// Token: 0x040002B1 RID: 689
	private int totalResources;

	// Token: 0x040002B2 RID: 690
	public int forceSeedOffset = -1;

	// Token: 0x040002B5 RID: 693
	public float minSpawnHeight = 0.4f;

	// Token: 0x040002B6 RID: 694
	public float maxSpawnHeight = 0.35f;

	// Token: 0x040002B7 RID: 695
	public int width;

	// Token: 0x040002B8 RID: 696
	public int height;

	// Token: 0x040002B9 RID: 697
	public bool useFalloffMap = true;

	// Token: 0x040002BA RID: 698
	public ResourceGenerator.SpawnType type;

	// Token: 0x02000079 RID: 121
	public enum SpawnType
	{
		// Token: 0x040002BC RID: 700
		Static,
		// Token: 0x040002BD RID: 701
		Pickup
	}
}
