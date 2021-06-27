using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000EC RID: 236
public abstract class SpawnZoneGenerator<T> : MonoBehaviour
{
	// Token: 0x17000055 RID: 85
	// (get) Token: 0x0600073A RID: 1850 RVA: 0x0002509D File Offset: 0x0002329D
	// (set) Token: 0x0600073B RID: 1851 RVA: 0x000250A5 File Offset: 0x000232A5
	public float worldScale { get; set; } = 12f;

	// Token: 0x0600073C RID: 1852 RVA: 0x000250B0 File Offset: 0x000232B0
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
				SpawnZone spawnZone = Instantiate<GameObject>(gameObject, raycastHit.point, gameObject.transform.rotation).GetComponent<SpawnZone>();
				spawnZone.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
				spawnZone.id = MobZoneManager.Instance.GetNextId();
				spawnZone = this.ProcessZone(spawnZone);
				this.zones.Add(spawnZone);
			}
		}
		this.AddEntitiesToZone();
		this.nZones = this.zones.Count;
	}

	// Token: 0x0600073D RID: 1853
	public abstract void AddEntitiesToZone();

	// Token: 0x0600073E RID: 1854
	public abstract SpawnZone ProcessZone(SpawnZone zone);

	// Token: 0x0600073F RID: 1855 RVA: 0x000252A4 File Offset: 0x000234A4
	private void OnDrawGizmos()
	{
	}

	// Token: 0x06000740 RID: 1856 RVA: 0x000252B4 File Offset: 0x000234B4
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

	// Token: 0x040006B4 RID: 1716
	public GameObject spawnZone;

	// Token: 0x040006B5 RID: 1717
	private int mapChunkSize;

	// Token: 0x040006B7 RID: 1719
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x040006B8 RID: 1720
	public int nZones = 50;

	// Token: 0x040006B9 RID: 1721
	protected ConsistentRandom randomGen;

	// Token: 0x040006BA RID: 1722
	public LayerMask whatIsTerrain;

	// Token: 0x040006BB RID: 1723
	protected List<SpawnZone> zones;

	// Token: 0x040006BC RID: 1724
	public int seedOffset;

	// Token: 0x040006BD RID: 1725
	private Vector3[] shrines;

	// Token: 0x040006BE RID: 1726
	protected float totalWeight;

	// Token: 0x040006BF RID: 1727
	public T[] entities;

	// Token: 0x040006C0 RID: 1728
	public float[] weights;
}
