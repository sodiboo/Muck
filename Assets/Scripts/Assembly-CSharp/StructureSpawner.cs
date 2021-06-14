using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000140 RID: 320
public class StructureSpawner : MonoBehaviour
{
	// Token: 0x1700005A RID: 90
	// (get) Token: 0x060007C3 RID: 1987 RVA: 0x000071A8 File Offset: 0x000053A8
	// (set) Token: 0x060007C4 RID: 1988 RVA: 0x000071B0 File Offset: 0x000053B0
	public float worldScale { get; set; } = 12f;

	// Token: 0x060007C5 RID: 1989 RVA: 0x000265D4 File Offset: 0x000247D4
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
				GameObject gameObject2 =Instantiate<GameObject>(gameObject, hit.point, gameObject.transform.rotation);
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

	// Token: 0x060007C6 RID: 1990 RVA: 0x00002147 File Offset: 0x00000347
	public virtual void Process(GameObject newStructure, RaycastHit hit)
	{
	}

	// Token: 0x060007C7 RID: 1991 RVA: 0x00022274 File Offset: 0x00020474
	private void OnDrawGizmos()
	{
	}

	// Token: 0x060007C8 RID: 1992 RVA: 0x00026810 File Offset: 0x00024A10
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

	// Token: 0x040007F2 RID: 2034
	public StructureSpawner.WeightedSpawn[] structurePrefabs;

	// Token: 0x040007F3 RID: 2035
	private int mapChunkSize;

	// Token: 0x040007F5 RID: 2037
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x040007F6 RID: 2038
	public int nShrines = 50;

	// Token: 0x040007F7 RID: 2039
	protected ConsistentRandom randomGen;

	// Token: 0x040007F8 RID: 2040
	public LayerMask whatIsTerrain;

	// Token: 0x040007F9 RID: 2041
	private List<GameObject> structures;

	// Token: 0x040007FA RID: 2042
	public bool dontAddToResourceManager;

	// Token: 0x040007FB RID: 2043
	private Vector3[] shrines;

	// Token: 0x040007FC RID: 2044
	private float totalWeight;

	// Token: 0x02000141 RID: 321
	[Serializable]
	public class WeightedSpawn
	{
		// Token: 0x040007FD RID: 2045
		public GameObject prefab;

		// Token: 0x040007FE RID: 2046
		public float weight;
	}
}
