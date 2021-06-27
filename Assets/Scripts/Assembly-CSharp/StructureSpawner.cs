using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200011C RID: 284
public class StructureSpawner : MonoBehaviour
{
	// Token: 0x17000061 RID: 97
	// (get) Token: 0x0600084A RID: 2122 RVA: 0x00029912 File Offset: 0x00027B12
	// (set) Token: 0x0600084B RID: 2123 RVA: 0x0002991A File Offset: 0x00027B1A
	public float worldScale { get; set; } = 12f;

	// Token: 0x0600084C RID: 2124 RVA: 0x00029924 File Offset: 0x00027B24
	private void Start()
	{
		this.structures = new List<GameObject>();
		this.randomGen = new ConsistentRandom(GameManager.GetSeed() + ResourceManager.GetNextGenOffset());
		this.shrines = new Vector3[this.nShrines];
		this.mapChunkSize = MapGenerator.mapChunkSize;
		this.worldScale *= this.worldEdgeBuffer;
		foreach (StructureSpawner.WeightedSpawn weightedSpawn in this.structurePrefabs)
		{
			this.totalWeight += weightedSpawn.weight;
		}
		int num = 0;
		for (int j = 0; j < this.nShrines; j++)
		{
			float x = (float)(this.randomGen.NextDouble() * 2.0 - 1.0) * (float)this.mapChunkSize / 2f;
			float z = (float)(this.randomGen.NextDouble() * 2.0 - 1.0) * (float)this.mapChunkSize / 2f;
			Vector3 vector = new Vector3(x, 0f, z) * this.worldScale;
			vector.y = 200f;
			Debug.DrawLine(vector, vector + Vector3.down * 500f, Color.cyan, 50f);
			RaycastHit hit;
			if (Physics.Raycast(vector, Vector3.down, out hit, 500f, this.whatIsTerrain) && WorldUtility.WorldHeightToBiome(hit.point.y) == TextureData.TerrainType.Grass)
			{
				this.shrines[j] = hit.point;
				num++;
				GameObject gameObject = this.FindObjectToSpawn(this.structurePrefabs, this.totalWeight);
				GameObject gameObject2 = Instantiate<GameObject>(gameObject, hit.point, gameObject.transform.rotation);
				if (!this.dontAddToResourceManager)
				{
					gameObject2.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
				}
				this.structures.Add(gameObject2);
				this.Process(gameObject2, hit);
			}
		}
		if (!this.dontAddToResourceManager)
		{
			ResourceManager.Instance.AddResources(this.structures);
		}
		MonoBehaviour.print("spawned: " + this.structures.Count);
	}

	// Token: 0x0600084D RID: 2125 RVA: 0x000030D7 File Offset: 0x000012D7
	public virtual void Process(GameObject newStructure, RaycastHit hit)
	{
	}

	// Token: 0x0600084E RID: 2126 RVA: 0x00029B60 File Offset: 0x00027D60
	private void OnDrawGizmos()
	{
	}

	// Token: 0x0600084F RID: 2127 RVA: 0x00029B70 File Offset: 0x00027D70
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

	// Token: 0x040007D3 RID: 2003
	public StructureSpawner.WeightedSpawn[] structurePrefabs;

	// Token: 0x040007D4 RID: 2004
	private int mapChunkSize;

	// Token: 0x040007D6 RID: 2006
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x040007D7 RID: 2007
	public int nShrines = 50;

	// Token: 0x040007D8 RID: 2008
	protected ConsistentRandom randomGen;

	// Token: 0x040007D9 RID: 2009
	public LayerMask whatIsTerrain;

	// Token: 0x040007DA RID: 2010
	private List<GameObject> structures;

	// Token: 0x040007DB RID: 2011
	public bool dontAddToResourceManager;

	// Token: 0x040007DC RID: 2012
	private Vector3[] shrines;

	// Token: 0x040007DD RID: 2013
	private float totalWeight;

	// Token: 0x02000186 RID: 390
	[Serializable]
	public class WeightedSpawn
	{
		// Token: 0x0400099C RID: 2460
		public GameObject prefab;

		// Token: 0x0400099D RID: 2461
		public float weight;
	}
}
