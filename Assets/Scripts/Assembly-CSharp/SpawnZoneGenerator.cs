using System.Collections.Generic;
using UnityEngine;

public abstract class SpawnZoneGenerator<T> : MonoBehaviour
{
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

    public float worldScale { get; set; } = 12f;


    private void Start()
    {
        zones = new List<SpawnZone>();
        randomGen = new ConsistentRandom(GameManager.GetSeed() + seedOffset);
        shrines = new Vector3[nZones];
        mapChunkSize = MapGenerator.mapChunkSize;
        worldScale *= worldEdgeBuffer;
        float[] array = weights;
        foreach (float num in array)
        {
            totalWeight += num;
        }
        int num2 = 0;
        for (int j = 0; j < nZones; j++)
        {
            float x = (float)(randomGen.NextDouble() * 2.0 - 1.0) * (float)mapChunkSize / 2f;
            float z = (float)(randomGen.NextDouble() * 2.0 - 1.0) * (float)mapChunkSize / 2f;
            Vector3 origin = new Vector3(x, 0f, z) * worldScale;
            origin.y = 200f;
            if (Physics.Raycast(origin, Vector3.down, out var hitInfo, 500f, whatIsTerrain) && WorldUtility.WorldHeightToBiome(hitInfo.point.y) == TextureData.TerrainType.Grass)
            {
                shrines[j] = hitInfo.point;
                num2++;
                GameObject gameObject = spawnZone;
                SpawnZone component = Object.Instantiate(gameObject, hitInfo.point, gameObject.transform.rotation).GetComponent<SpawnZone>();
                component.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
                component.id = MobZoneManager.Instance.GetNextId();
                component = ProcessZone(component);
                zones.Add(component);
            }
        }
        AddEntitiesToZone();
        nZones = zones.Count;
    }

    public abstract void AddEntitiesToZone();

    public abstract SpawnZone ProcessZone(SpawnZone zone);

    private void OnDrawGizmos()
    {
    }

    public T FindObjectToSpawn(T[] entityTypes, float totalWeight)
    {
        float num = (float)randomGen.NextDouble();
        float num2 = 0f;
        for (int i = 0; i < entityTypes.Length; i++)
        {
            num2 += weights[i];
            if (num < num2 / totalWeight)
            {
                return entityTypes[i];
            }
        }
        return entityTypes[0];
    }
}
