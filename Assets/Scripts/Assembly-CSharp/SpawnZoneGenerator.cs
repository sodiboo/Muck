using System;
using System.Collections.Generic;
using UnityEngine;

public abstract class SpawnZoneGenerator<T> : MonoBehaviour
{
	public float worldScale { get; set; } = 12f;

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

	public abstract void AddEntitiesToZone();

	public abstract SpawnZone ProcessZone(SpawnZone zone);

	private void OnDrawGizmos()
	{
	}

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

	public GameObject spawnZone;

	private int mapChunkSize;

	private float worldEdgeBuffer = 0.6f;

	public int nZones = 50;

	protected ConsistentRandom randomGen;

	public LayerMask whatIsTerrain;

	protected List<SpawnZone> zones;

	public int seedOffset;

	private Vector3[] shrines;

	protected float totalWeight;

	public T[] entities;

	public float[] weights;
}
