
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000064 RID: 100
public class ResourceGenerator : MonoBehaviour
{
	// Token: 0x1700001B RID: 27
	// (get) Token: 0x06000264 RID: 612 RVA: 0x0000D4E2 File Offset: 0x0000B6E2
	// (set) Token: 0x06000265 RID: 613 RVA: 0x0000D4EA File Offset: 0x0000B6EA
	public float worldScale { get; set; } = 12f;

	// Token: 0x06000266 RID: 614 RVA: 0x0000D4F4 File Offset: 0x0000B6F4
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

	// Token: 0x1700001C RID: 28
	// (get) Token: 0x06000267 RID: 615 RVA: 0x0000D55F File Offset: 0x0000B75F
	// (set) Token: 0x06000268 RID: 616 RVA: 0x0000D567 File Offset: 0x0000B767
	public float topLeftX { get; private set; }

	// Token: 0x1700001D RID: 29
	// (get) Token: 0x06000269 RID: 617 RVA: 0x0000D570 File Offset: 0x0000B770
	// (set) Token: 0x0600026A RID: 618 RVA: 0x0000D578 File Offset: 0x0000B778
	public float topLeftZ { get; private set; }

	// Token: 0x0600026B RID: 619 RVA: 0x0000D584 File Offset: 0x0000B784
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

	// Token: 0x0600026C RID: 620 RVA: 0x0000D830 File Offset: 0x0000BA30
	private GameObject SpawnTree(Vector3 pos)
	{
		Quaternion rotation = Quaternion.Euler((float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.x * 2f, (float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.y * 2f, (float)(this.randomGen.NextDouble() - 0.5) * this.randomRotation.z * 2f);
		float num = (float)this.randomGen.NextDouble() * (this.randomScale.y - this.randomScale.x);
		Vector3 vector = Vector3.one * (this.randomScale.x + num);
		GameObject gameObject =Instantiate(this.FindObjectToSpawn(this.resourcePrefabs, this.totalWeight), pos, rotation);
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

	// Token: 0x0600026D RID: 621 RVA: 0x0000D958 File Offset: 0x0000BB58
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

	// Token: 0x04000247 RID: 583
	public DrawChunks drawChunks;

	// Token: 0x04000248 RID: 584
	public StructureSpawner.WeightedSpawn[] resourcePrefabs;

	// Token: 0x04000249 RID: 585
	private float totalWeight;

	// Token: 0x0400024A RID: 586
	public MapGenerator mapGenerator;

	// Token: 0x0400024B RID: 587
	private int density = 1;

	// Token: 0x0400024C RID: 588
	public float spawnThreshold = 0.45f;

	// Token: 0x0400024D RID: 589
	public AnimationCurve noiseDistribution;

	// Token: 0x0400024E RID: 590
	public AnimationCurve heightDistribution;

	// Token: 0x0400024F RID: 591
	public List<GameObject>[] resources;

	// Token: 0x04000250 RID: 592
	private ConsistentRandom randomGen;

	// Token: 0x04000251 RID: 593
	public NoiseData noiseData;

	// Token: 0x04000253 RID: 595
	[Header("Variety")]
	public Vector3 randomRotation;

	// Token: 0x04000254 RID: 596
	public Vector2 randomScale;

	// Token: 0x04000255 RID: 597
	public int randPos = 12;

	// Token: 0x04000256 RID: 598
	private int totalResources;

	// Token: 0x04000257 RID: 599
	public int forceSeedOffset = -1;

	// Token: 0x0400025A RID: 602
	public float minSpawnHeight = 0.4f;

	// Token: 0x0400025B RID: 603
	public float maxSpawnHeight = 0.35f;

	// Token: 0x0400025C RID: 604
	public int width;

	// Token: 0x0400025D RID: 605
	public int height;

	// Token: 0x0400025E RID: 606
	public bool useFalloffMap = true;

	// Token: 0x0400025F RID: 607
	public ResourceGenerator.SpawnType type;

	// Token: 0x02000114 RID: 276
	public enum SpawnType
	{
		// Token: 0x04000753 RID: 1875
		Static,
		// Token: 0x04000754 RID: 1876
		Pickup
	}
}
