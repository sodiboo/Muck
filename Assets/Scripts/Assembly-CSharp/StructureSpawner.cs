using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000ED RID: 237
public class StructureSpawner : MonoBehaviour
{
	// Token: 0x17000051 RID: 81
	// (get) Token: 0x06000708 RID: 1800 RVA: 0x0002303E File Offset: 0x0002123E
	// (set) Token: 0x06000709 RID: 1801 RVA: 0x00023046 File Offset: 0x00021246
	public float worldScale { get; set; } = 12f;

	// Token: 0x0600070A RID: 1802 RVA: 0x00023050 File Offset: 0x00021250
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

	// Token: 0x0600070B RID: 1803 RVA: 0x0000276E File Offset: 0x0000096E
	public virtual void Process(GameObject newStructure, RaycastHit hit)
	{
	}

	// Token: 0x0600070C RID: 1804 RVA: 0x0002328C File Offset: 0x0002148C
	private void OnDrawGizmos()
	{
	}

	// Token: 0x0600070D RID: 1805 RVA: 0x0002329C File Offset: 0x0002149C
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

	// Token: 0x0400068E RID: 1678
	public StructureSpawner.WeightedSpawn[] structurePrefabs;

	// Token: 0x0400068F RID: 1679
	private int mapChunkSize;

	// Token: 0x04000691 RID: 1681
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x04000692 RID: 1682
	public int nShrines = 50;

	// Token: 0x04000693 RID: 1683
	protected ConsistentRandom randomGen;

	// Token: 0x04000694 RID: 1684
	public LayerMask whatIsTerrain;

	// Token: 0x04000695 RID: 1685
	private List<GameObject> structures;

	// Token: 0x04000696 RID: 1686
	public bool dontAddToResourceManager;

	// Token: 0x04000697 RID: 1687
	private Vector3[] shrines;

	// Token: 0x04000698 RID: 1688
	private float totalWeight;

	// Token: 0x02000144 RID: 324
	[Serializable]
	public class WeightedSpawn
	{
		// Token: 0x04000813 RID: 2067
		public GameObject prefab;

		// Token: 0x04000814 RID: 2068
		public float weight;
	}
}
