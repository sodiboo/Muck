using System;
using System.Collections.Generic;
using UnityEngine;

public class BillySpawner : MonoBehaviour
{
    [Serializable]
    public class WeightedSpawn
    {
        public GameObject prefab;

        public float weight;
    }

    public WeightedSpawn[] structurePrefabs;

    private int mapChunkSize;

    private float worldEdgeBuffer = 0.6f;

    public int maxCaves = 50;

    public int minCaves = 3;

    protected ConsistentRandom randomGen;

    public LayerMask whatIsTerrain;

    private List<GameObject> structures;

    public bool dontAddToResourceManager;

    private Vector3[] shrines;

    private float totalWeight;

    public float worldScale { get; set; } = 12f;


    private void Start()
    {
        structures = new List<GameObject>();
        randomGen = new ConsistentRandom(GameManager.GetSeed() + ResourceManager.GetNextGenOffset());
        shrines = new Vector3[maxCaves];
        mapChunkSize = MapGenerator.mapChunkSize;
        worldScale *= worldEdgeBuffer;
        WeightedSpawn[] array = structurePrefabs;
        foreach (WeightedSpawn weightedSpawn in array)
        {
            totalWeight += weightedSpawn.weight;
        }
        int num = 0;
        int num2 = 0;
        while (num < maxCaves)
        {
            num2++;
            float x = (float)(randomGen.NextDouble() * 2.0 - 1.0) * (float)mapChunkSize / 2f;
            float z = (float)(randomGen.NextDouble() * 2.0 - 1.0) * (float)mapChunkSize / 2f;
            Vector3 vector = new Vector3(x, 0f, z) * worldScale;
            vector.y = 200f;
            Debug.DrawLine(vector, vector + Vector3.down * 500f, Color.cyan, 50f);
            if (Physics.Raycast(vector, Vector3.down, out var hitInfo, 500f, whatIsTerrain))
            {
                if (WorldUtility.WorldHeightToBiome(hitInfo.point.y) != TextureData.TerrainType.Grass || Mathf.Abs(Vector3.Angle(Vector3.up, hitInfo.normal)) > 15f)
                {
                    continue;
                }
                shrines[num] = hitInfo.point;
                num++;
                GameObject gameObject = FindObjectToSpawn(structurePrefabs, totalWeight);
                GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, hitInfo.point, gameObject.transform.rotation);
                if (!dontAddToResourceManager)
                {
                    gameObject2.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
                }
                structures.Add(gameObject2);
                Process(gameObject2, hitInfo);
            }
            if ((num2 > maxCaves * 2 && num >= minCaves) || num2 > maxCaves * 10)
            {
                break;
            }
        }
        if (!dontAddToResourceManager)
        {
            ResourceManager.Instance.AddResources(structures);
        }
    }

    public virtual void Process(GameObject newStructure, RaycastHit hit)
    {
        newStructure.transform.rotation = Quaternion.LookRotation(hit.normal);
    }

    private void OnDrawGizmos()
    {
    }

    public GameObject FindObjectToSpawn(WeightedSpawn[] structurePrefabs, float totalWeight)
    {
        float num = (float)randomGen.NextDouble();
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
}
