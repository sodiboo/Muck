using UnityEngine;

public class MapGenerator : MonoBehaviour
{
    public enum DrawMode
    {
        NoiseMap,
        Mesh,
        FalloffMap,
        ColorMap
    }

    public DrawMode drawMode;

    public TerrainData terrainData;

    public NoiseData noiseData;

    public TextureData textureData;

    public Material terrainMaterial;

    [Range(0f, 6f)]
    public int levelOfDetail;

    private static int seed = 105;

    public bool autoUpdate;

    private float[,] falloffMap;

    private MapDisplay display;

    public static int mapChunkSize = 241;

    public static int worldScale = 12;

    public static MapGenerator Instance;

    public static float[,] staticNoiseMap;

    public float[,] heightMap;

    private void Awake()
    {
        Instance = this;
        textureData.ApplyToMaterial(terrainMaterial);
        textureData.UpdateMeshHeights(terrainMaterial, terrainData.minHeight, terrainData.maxHeight);
    }

    private void OnValuesUpdated()
    {
        if (!Application.isPlaying)
        {
            GenerateMap();
            DrawMapInEditor();
        }
    }

    private void OnTextureValuesUpdated()
    {
        textureData.ApplyToMaterial(terrainMaterial);
    }

    public void GenerateMap(int seed = 105)
    {
        heightMap = GeneratePerlinNoiseMap(seed);
        GeneratePerlinNoiseMap(seed);
        textureData.UpdateMeshHeights(terrainMaterial, terrainData.minHeight, terrainData.maxHeight);
        display = Object.FindObjectOfType<MapDisplay>();
        if (drawMode == DrawMode.NoiseMap)
        {
            display.DrawTexture(TextureGenerator.TextureFromHeightMap(heightMap));
        }
        else if (drawMode == DrawMode.Mesh)
        {
            display.DrawMesh(MeshGenerator.GenerateTerrainMesh(heightMap, terrainData.heightMultiplier, terrainData.heightCurve, levelOfDetail));
        }
        else if (drawMode == DrawMode.FalloffMap)
        {
            display.DrawTexture(TextureGenerator.TextureFromHeightMap(FalloffGenerator.GenerateFalloffMap(mapChunkSize)));
        }
        else if (drawMode == DrawMode.ColorMap)
        {
            display.DrawTexture(TextureGenerator.ColorTextureFromHeightMap(heightMap, textureData));
        }
        textureData.ApplyToMaterial(terrainMaterial);
        textureData.UpdateMeshHeights(terrainMaterial, terrainData.minHeight, terrainData.maxHeight);
    }

    public float[,] GeneratePerlinNoiseMap(NoiseData noiseData, int seed, bool useFalloffMap)
    {
        float[,] array = Noise.GenerateNoiseMap(mapChunkSize, mapChunkSize, seed, noiseData.noiseScale, noiseData.octaves, noiseData.persistance, noiseData.lacunarity, noiseData.blend, noiseData.blendStrength, noiseData.offset);
        if (useFalloffMap)
        {
            if (falloffMap == null)
            {
                falloffMap = FalloffGenerator.GenerateFalloffMap(mapChunkSize);
            }
            for (int i = 0; i < mapChunkSize; i++)
            {
                for (int j = 0; j < mapChunkSize; j++)
                {
                    if (terrainData.useFalloff)
                    {
                        array[j, i] = Mathf.Clamp(array[j, i] - falloffMap[j, i], 0f, 1f);
                    }
                }
            }
        }
        return array;
    }

    public float[,] GeneratePerlinNoiseMap(int seed)
    {
        float[,] array = Noise.GenerateNoiseMap(mapChunkSize, mapChunkSize, seed, noiseData.noiseScale, noiseData.octaves, noiseData.persistance, noiseData.lacunarity, noiseData.blend, noiseData.blendStrength, noiseData.offset);
        if (terrainData.useFalloff)
        {
            if (falloffMap == null)
            {
                falloffMap = FalloffGenerator.GenerateFalloffMap(mapChunkSize);
            }
            for (int i = 0; i < mapChunkSize; i++)
            {
                for (int j = 0; j < mapChunkSize; j++)
                {
                    if (terrainData.useFalloff)
                    {
                        array[j, i] = Mathf.Clamp(array[j, i] - falloffMap[j, i], 0f, 1f);
                    }
                }
            }
        }
        return array;
    }

    public void DrawMapInEditor()
    {
        float[,] array = GeneratePerlinNoiseMap(0);
        MapDisplay mapDisplay = Object.FindObjectOfType<MapDisplay>();
        if (drawMode == DrawMode.NoiseMap)
        {
            mapDisplay.DrawTexture(TextureGenerator.TextureFromHeightMap(array));
        }
        else if (drawMode == DrawMode.Mesh)
        {
            mapDisplay.DrawMesh(MeshGenerator.GenerateTerrainMesh(array, terrainData.heightMultiplier, terrainData.heightCurve, levelOfDetail));
        }
        else if (drawMode == DrawMode.FalloffMap)
        {
            mapDisplay.DrawTexture(TextureGenerator.TextureFromHeightMap(FalloffGenerator.GenerateFalloffMap(mapChunkSize)));
        }
    }

    private void OnValidate()
    {
        if (terrainData != null)
        {
            terrainData.OnValuesUpdate -= OnValuesUpdated;
            terrainData.OnValuesUpdate += OnValuesUpdated;
        }
        if (noiseData != null)
        {
            noiseData.OnValuesUpdate -= OnValuesUpdated;
            noiseData.OnValuesUpdate += OnValuesUpdated;
        }
        if (textureData != null)
        {
            textureData.OnValuesUpdated -= OnTextureValuesUpdated;
            textureData.OnValuesUpdated += OnTextureValuesUpdated;
        }
    }
}
