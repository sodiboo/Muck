using System.Collections.Generic;
using UnityEngine;

public class ResourceGenerator : MonoBehaviour
{
    public enum SpawnType
    {
        Static,
        Pickup
    }

    public DrawChunks drawChunks;

    public StructureSpawner.WeightedSpawn[] resourcePrefabs;

    private float totalWeight;

    public MapGenerator mapGenerator;

    private int density = 1;

    public float spawnThreshold = 0.45f;

    public AnimationCurve noiseDistribution;

    public AnimationCurve heightDistribution;

    public List<GameObject>[] resources;

    private ConsistentRandom randomGen;

    public NoiseData noiseData;

    [Header("Variety")]
    public Vector3 randomRotation;

    public Vector2 randomScale;

    public int randPos = 12;

    private int totalResources;

    public int forceSeedOffset = -1;

    public float minSpawnHeight = 0.4f;

    public float maxSpawnHeight = 0.35f;

    public int width;

    public int height;

    public bool useFalloffMap = true;

    public int minSpawnAmount = 10;

    public SpawnType type;

    public float worldScale { get; set; } = 12f;


    public float topLeftX { get; private set; }

    public float topLeftZ { get; private set; }

    private void Start()
    {
        randomGen = new ConsistentRandom(GameManager.GetSeed());
        StructureSpawner.WeightedSpawn[] array = resourcePrefabs;
        foreach (StructureSpawner.WeightedSpawn weightedSpawn in array)
        {
            totalWeight += weightedSpawn.weight;
        }
        GenerateForest();
        if ((bool)ResourceManager.Instance)
        {
            ResourceManager.Instance.AddResources(resources);
        }
    }

    private void GenerateForest()
    {
        int num = 0;
        num = ((forceSeedOffset == -1) ? ResourceManager.GetNextGenOffset() : forceSeedOffset);
        float[,] array = mapGenerator.GeneratePerlinNoiseMap(GameManager.GetSeed());
        float[,] array2 = mapGenerator.GeneratePerlinNoiseMap(noiseData, GameManager.GetSeed() + num, useFalloffMap);
        width = array.GetLength(0);
        height = array.GetLength(1);
        topLeftX = (float)(width - 1) / -2f;
        topLeftZ = (float)(height - 1) / 2f;
        resources = new List<GameObject>[drawChunks.nChunks];
        for (int i = 0; i < resources.Length; i++)
        {
            resources[i] = new List<GameObject>();
        }
        int num2 = density;
        int num3 = 0;
        int num4 = 0;
        int num5 = 0;
        while (num4 < minSpawnAmount && num5 < 100)
        {
            num5++;
            for (int j = 0; j < height; j += num2)
            {
                for (int k = 0; k < width; k += num2)
                {
                    if (array[k, j] < minSpawnHeight || array[k, j] > maxSpawnHeight)
                    {
                        continue;
                    }
                    float num6 = array2[k, j];
                    if (num6 < spawnThreshold)
                    {
                        continue;
                    }
                    num6 = (num6 - spawnThreshold) / (1f - spawnThreshold);
                    float num7 = noiseDistribution.Evaluate((float)randomGen.NextDouble());
                    num3++;
                    if (!(num7 > 1f - num6))
                    {
                        continue;
                    }
                    Vector3 vector = new Vector3(topLeftX + (float)k, 100f, topLeftZ - (float)j) * worldScale;
                    vector += new Vector3(randomGen.Next(-randPos, randPos), 0f, randomGen.Next(-randPos, randPos));
                    if (Physics.Raycast(vector, Vector3.down, out var hitInfo, 1200f))
                    {
                        vector.y = hitInfo.point.y;
                        num4++;
                        int num8 = drawChunks.FindChunk(k, j);
                        if (num8 >= drawChunks.nChunks)
                        {
                            num8 = drawChunks.nChunks - 1;
                        }
                        resources[num8].Add(SpawnTree(vector));
                    }
                }
            }
        }
        totalResources = num4;
        drawChunks.InitChunks(resources);
        drawChunks.totalTrees = totalResources;
    }

    private GameObject SpawnTree(Vector3 pos)
    {
        Quaternion rotation = Quaternion.Euler((float)(randomGen.NextDouble() - 0.5) * randomRotation.x * 2f, (float)(randomGen.NextDouble() - 0.5) * randomRotation.y * 2f, (float)(randomGen.NextDouble() - 0.5) * randomRotation.z * 2f);
        float num = (float)randomGen.NextDouble() * (randomScale.y - randomScale.x);
        Vector3 vector = Vector3.one * (randomScale.x + num);
        GameObject obj = Object.Instantiate(FindObjectToSpawn(resourcePrefabs, totalWeight), pos, rotation);
        obj.transform.localScale = vector;
        obj.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
        HitableResource component = obj.GetComponent<HitableResource>();
        if ((bool)component)
        {
            component.SetDefaultScale(vector);
            component.PopIn();
        }
        obj.SetActive(value: false);
        return obj;
    }

    public GameObject FindObjectToSpawn(StructureSpawner.WeightedSpawn[] structurePrefabs, float totalWeight)
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
