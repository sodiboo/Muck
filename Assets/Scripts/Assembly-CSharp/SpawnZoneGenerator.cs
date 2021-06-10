
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000C4 RID: 196
public abstract class SpawnZoneGenerator<T> : MonoBehaviour
{
	// Token: 0x17000045 RID: 69
	// (get) Token: 0x06000620 RID: 1568 RVA: 0x0001EFBD File Offset: 0x0001D1BD
	// (set) Token: 0x06000621 RID: 1569 RVA: 0x0001EFC5 File Offset: 0x0001D1C5
	public float worldScale { get; set; } = 12f;

	// Token: 0x06000622 RID: 1570 RVA: 0x0001EFD0 File Offset: 0x0001D1D0
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
				SpawnZone spawnZone =Instantiate(gameObject, raycastHit.point, gameObject.transform.rotation).GetComponent<SpawnZone>();
				spawnZone.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
				spawnZone.id = MobZoneManager.Instance.GetNextId();
				spawnZone = this.ProcessZone(spawnZone);
				this.zones.Add(spawnZone);
			}
		}
		this.AddEntitiesToZone();
		this.nZones = this.zones.Count;
	}

	// Token: 0x06000623 RID: 1571
	public abstract void AddEntitiesToZone();

	// Token: 0x06000624 RID: 1572
	public abstract SpawnZone ProcessZone(SpawnZone zone);

	// Token: 0x06000625 RID: 1573 RVA: 0x0001F1C4 File Offset: 0x0001D3C4
	private void OnDrawGizmos()
	{
	}

	// Token: 0x06000626 RID: 1574 RVA: 0x0001F1D4 File Offset: 0x0001D3D4
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

	// Token: 0x0400058E RID: 1422
	public GameObject spawnZone;

	// Token: 0x0400058F RID: 1423
	private int mapChunkSize;

	// Token: 0x04000591 RID: 1425
	private float worldEdgeBuffer = 0.6f;

	// Token: 0x04000592 RID: 1426
	public int nZones = 50;

	// Token: 0x04000593 RID: 1427
	protected ConsistentRandom randomGen;

	// Token: 0x04000594 RID: 1428
	public LayerMask whatIsTerrain;

	// Token: 0x04000595 RID: 1429
	protected List<SpawnZone> zones;

	// Token: 0x04000596 RID: 1430
	public int seedOffset;

	// Token: 0x04000597 RID: 1431
	private Vector3[] shrines;

	// Token: 0x04000598 RID: 1432
	protected float totalWeight;

	// Token: 0x04000599 RID: 1433
	public T[] entities;

	// Token: 0x0400059A RID: 1434
	public float[] weights;
}
