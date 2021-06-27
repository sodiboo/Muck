using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000014 RID: 20
public class CaveSpawner : MonoBehaviour
{
	// Token: 0x17000008 RID: 8
	// (get) Token: 0x06000077 RID: 119 RVA: 0x000044D7 File Offset: 0x000026D7
	// (set) Token: 0x06000078 RID: 120 RVA: 0x000044DF File Offset: 0x000026DF
	public float worldScale { get; set; } = 12f;

	// Token: 0x06000079 RID: 121 RVA: 0x000044E8 File Offset: 0x000026E8
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

	// Token: 0x0600007A RID: 122 RVA: 0x00004744 File Offset: 0x00002944
	public virtual void Process(GameObject newStructure, RaycastHit hit)
	{
		Cave component = newStructure.GetComponent<Cave>();
		component.transform.rotation = Quaternion.Euler(-90f, (float)(this.randomGen.Next() * 360), 0f);
		component.SetCave(this.randomGen);
	}

	// Token: 0x0600007B RID: 123 RVA: 0x00004784 File Offset: 0x00002984
	private void OnDrawGizmos()
	{
	}

	// Token: 0x0600007C RID: 124 RVA: 0x00004794 File Offset: 0x00002994
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

	// Token: 0x04000077 RID: 119
	public CaveSpawner.WeightedSpawn[] structurePrefabs;

	// Token: 0x04000078 RID: 120
	private int mapChunkSize;

	// Token: 0x0400007A RID: 122
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x0400007B RID: 123
	public int maxCaves = 50;

	// Token: 0x0400007C RID: 124
	public int minCaves = 3;

	// Token: 0x0400007D RID: 125
	protected ConsistentRandom randomGen;

	// Token: 0x0400007E RID: 126
	public LayerMask whatIsTerrain;

	// Token: 0x0400007F RID: 127
	private List<GameObject> structures;

	// Token: 0x04000080 RID: 128
	public bool dontAddToResourceManager;

	// Token: 0x04000081 RID: 129
	private Vector3[] shrines;

	// Token: 0x04000082 RID: 130
	private float totalWeight;

	// Token: 0x0200013E RID: 318
	[Serializable]
	public class WeightedSpawn
	{
		// Token: 0x04000883 RID: 2179
		public GameObject prefab;

		// Token: 0x04000884 RID: 2180
		public float weight;
	}
}
