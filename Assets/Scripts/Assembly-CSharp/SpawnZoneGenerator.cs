using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000101 RID: 257
public abstract class SpawnZoneGenerator<T> : MonoBehaviour
{
	// Token: 0x1700004E RID: 78
	// (get) Token: 0x060006B3 RID: 1715 RVA: 0x00006362 File Offset: 0x00004562
	// (set) Token: 0x060006B4 RID: 1716 RVA: 0x0000636A File Offset: 0x0000456A
	public float worldScale { get; set; } = 12f;

	// Token: 0x060006B5 RID: 1717 RVA: 0x00022A8C File Offset: 0x00020C8C
	private void Start()
	{
		this.zones = new List<SpawnZone>();
		this.randomGen = new ConsistentRandom(GameManager.GetSeed() + this.seedOffset);
		this.shrines = new Vector3[this.nZones];
		this.mapChunkSize = MapGenerator.mapChunkSize;
		this.worldScale *= this.worldEdgeBuffer;
		foreach (float num in this.weights)
		{
			this.totalWeight += num;
		}
		int num2 = 0;
		for (int j = 0; j < this.nZones; j++)
		{
			float x = (float)(this.randomGen.NextDouble() * 2.0 - 1.0) * (float)this.mapChunkSize / 2f;
			float z = (float)(this.randomGen.NextDouble() * 2.0 - 1.0) * (float)this.mapChunkSize / 2f;
			Vector3 origin = new Vector3(x, 0f, z) * this.worldScale;
			origin.y = 200f;
			RaycastHit raycastHit;
			if (Physics.Raycast(origin, Vector3.down, out raycastHit, 500f, this.whatIsTerrain) && WorldUtility.WorldHeightToBiome(raycastHit.point.y) == TextureData.TerrainType.Grass)
			{
				this.shrines[j] = raycastHit.point;
				num2++;
				GameObject gameObject = this.spawnZone;
				SpawnZone spawnZone =Instantiate<GameObject>(gameObject, raycastHit.point, gameObject.transform.rotation).GetComponent<SpawnZone>();
				spawnZone.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
				spawnZone.id = MobZoneManager.Instance.GetNextId();
				spawnZone = this.ProcessZone(spawnZone);
				this.zones.Add(spawnZone);
			}
		}
		this.AddEntitiesToZone();
		this.nZones = this.zones.Count;
	}

	// Token: 0x060006B6 RID: 1718
	public abstract void AddEntitiesToZone();

	// Token: 0x060006B7 RID: 1719
	public abstract SpawnZone ProcessZone(SpawnZone zone);

	// Token: 0x060006B8 RID: 1720 RVA: 0x00022274 File Offset: 0x00020474
	private void OnDrawGizmos()
	{
	}

	// Token: 0x060006B9 RID: 1721 RVA: 0x00022C80 File Offset: 0x00020E80
	public T FindObjectToSpawn(T[] entityTypes, float totalWeight)
	{
		float num = (float)this.randomGen.NextDouble();
		float num2 = 0f;
		for (int i = 0; i < entityTypes.Length; i++)
		{
			num2 += this.weights[i];
			if (num < num2 / totalWeight)
			{
				return entityTypes[i];
			}
		}
		return entityTypes[0];
	}

	// Token: 0x04000695 RID: 1685
	public GameObject spawnZone;

	// Token: 0x04000696 RID: 1686
	private int mapChunkSize;

	// Token: 0x04000698 RID: 1688
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x04000699 RID: 1689
	public int nZones = 50;

	// Token: 0x0400069A RID: 1690
	protected ConsistentRandom randomGen;

	// Token: 0x0400069B RID: 1691
	public LayerMask whatIsTerrain;

	// Token: 0x0400069C RID: 1692
	protected List<SpawnZone> zones;

	// Token: 0x0400069D RID: 1693
	public int seedOffset;

	// Token: 0x0400069E RID: 1694
	private Vector3[] shrines;

	// Token: 0x0400069F RID: 1695
	protected float totalWeight;

	// Token: 0x040006A0 RID: 1696
	public T[] entities;

	// Token: 0x040006A1 RID: 1697
	public float[] weights;
}
