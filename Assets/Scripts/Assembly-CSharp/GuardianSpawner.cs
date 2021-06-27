using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000047 RID: 71
public class GuardianSpawner : MonoBehaviour
{
	// Token: 0x17000012 RID: 18
	// (get) Token: 0x060001A1 RID: 417 RVA: 0x00009F6E File Offset: 0x0000816E
	// (set) Token: 0x060001A2 RID: 418 RVA: 0x00009F76 File Offset: 0x00008176
	public float worldScale { get; set; } = 12f;

	// Token: 0x060001A3 RID: 419 RVA: 0x00009F80 File Offset: 0x00008180
	private void Start()
	{
		this.structures = new List<GameObject>();
		this.randomGen = new ConsistentRandom(GameManager.GetSeed() + ResourceManager.GetNextGenOffset());
		this.shrines = new Vector3[this.maxCaves];
		this.mapChunkSize = MapGenerator.mapChunkSize;
		this.worldScale *= this.worldEdgeBuffer;
		foreach (GuardianSpawner.WeightedSpawn weightedSpawn in this.structurePrefabs)
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
			if ((num > this.maxCaves * 100 && j >= this.minCaves) || num > this.maxCaves * 100)
			{
				break;
			}
		}
		if (!this.dontAddToResourceManager)
		{
			ResourceManager.Instance.AddResources(this.structures);
		}
		if (this.structures.Count != 5)
		{
			Debug.LogError("Failed to spawn all guardians, whopsie dopsie");
		}
	}

	// Token: 0x060001A4 RID: 420 RVA: 0x0000A1F5 File Offset: 0x000083F5
	public virtual void Process(GameObject newStructure, RaycastHit hit)
	{
		newStructure.GetComponentInChildren<ShrineGuardian>().type = (Guardian.GuardianType)this.type;
		this.type++;
	}

	// Token: 0x060001A5 RID: 421 RVA: 0x0000A218 File Offset: 0x00008418
	private void OnDrawGizmos()
	{
	}

	// Token: 0x060001A6 RID: 422 RVA: 0x0000A228 File Offset: 0x00008428
	public GameObject FindObjectToSpawn(GuardianSpawner.WeightedSpawn[] structurePrefabs, float totalWeight)
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

	// Token: 0x0400019C RID: 412
	public GuardianSpawner.WeightedSpawn[] structurePrefabs;

	// Token: 0x0400019D RID: 413
	private int mapChunkSize;

	// Token: 0x0400019F RID: 415
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x040001A0 RID: 416
	public int maxCaves = 50;

	// Token: 0x040001A1 RID: 417
	public int minCaves = 3;

	// Token: 0x040001A2 RID: 418
	protected ConsistentRandom randomGen;

	// Token: 0x040001A3 RID: 419
	public LayerMask whatIsTerrain;

	// Token: 0x040001A4 RID: 420
	private List<GameObject> structures;

	// Token: 0x040001A5 RID: 421
	public bool dontAddToResourceManager;

	// Token: 0x040001A6 RID: 422
	private int type = 1;

	// Token: 0x040001A7 RID: 423
	private int maxTypes = 5;

	// Token: 0x040001A8 RID: 424
	private Vector3[] shrines;

	// Token: 0x040001A9 RID: 425
	private float totalWeight;

	// Token: 0x02000145 RID: 325
	[Serializable]
	public class WeightedSpawn
	{
		// Token: 0x04000899 RID: 2201
		public GameObject prefab;

		// Token: 0x0400089A RID: 2202
		public float weight;
	}
}
