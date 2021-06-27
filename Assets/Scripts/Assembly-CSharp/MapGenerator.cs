using System;
using UnityEngine;

public class MapGenerator : MonoBehaviour
{
	private void Awake()
	{
		MapGenerator.Instance = this;
		this.textureData.ApplyToMaterial(this.terrainMaterial);
		this.textureData.UpdateMeshHeights(this.terrainMaterial, this.terrainData.minHeight, this.terrainData.maxHeight);
	}

	private void OnValuesUpdated()
	{
		if (!Application.isPlaying)
		{
			this.GenerateMap(105);
			this.DrawMapInEditor();
		}
	}

	private void OnTextureValuesUpdated()
	{
		this.textureData.ApplyToMaterial(this.terrainMaterial);
	}

	public void GenerateMap(int seed = 105)
	{
		this.heightMap = this.GeneratePerlinNoiseMap(seed);
		this.GeneratePerlinNoiseMap(seed);
		this.textureData.UpdateMeshHeights(this.terrainMaterial, this.terrainData.minHeight, this.terrainData.maxHeight);
		this.display = FindObjectOfType<MapDisplay>();
		if (this.drawMode == MapGenerator.DrawMode.NoiseMap)
		{
			this.display.DrawTexture(TextureGenerator.TextureFromHeightMap(this.heightMap));
		}
		else if (this.drawMode == MapGenerator.DrawMode.Mesh)
		{
			this.display.DrawMesh(MeshGenerator.GenerateTerrainMesh(this.heightMap, this.terrainData.heightMultiplier, this.terrainData.heightCurve, this.levelOfDetail));
		}
		else if (this.drawMode == MapGenerator.DrawMode.FalloffMap)
		{
			this.display.DrawTexture(TextureGenerator.TextureFromHeightMap(FalloffGenerator.GenerateFalloffMap(MapGenerator.mapChunkSize)));
		}
		else if (this.drawMode == MapGenerator.DrawMode.ColorMap)
		{
			this.display.DrawTexture(TextureGenerator.ColorTextureFromHeightMap(this.heightMap, this.textureData));
		}
		this.textureData.ApplyToMaterial(this.terrainMaterial);
		this.textureData.UpdateMeshHeights(this.terrainMaterial, this.terrainData.minHeight, this.terrainData.maxHeight);
	}

	public float[,] GeneratePerlinNoiseMap(NoiseData noiseData, int seed, bool useFalloffMap)
	{
		float[,] array = Noise.GenerateNoiseMap(MapGenerator.mapChunkSize, MapGenerator.mapChunkSize, seed, noiseData.noiseScale, noiseData.octaves, noiseData.persistance, noiseData.lacunarity, noiseData.blend, noiseData.blendStrength, noiseData.offset);
		if (useFalloffMap)
		{
			if (this.falloffMap == null)
			{
				this.falloffMap = FalloffGenerator.GenerateFalloffMap(MapGenerator.mapChunkSize);
			}
			for (int i = 0; i < MapGenerator.mapChunkSize; i++)
			{
				for (int j = 0; j < MapGenerator.mapChunkSize; j++)
				{
					if (this.terrainData.useFalloff)
					{
						array[j, i] = Mathf.Clamp(array[j, i] - this.falloffMap[j, i], 0f, 1f);
					}
				}
			}
		}
		return array;
	}

	public float[,] GeneratePerlinNoiseMap(int seed)
	{
		float[,] array = Noise.GenerateNoiseMap(MapGenerator.mapChunkSize, MapGenerator.mapChunkSize, seed, this.noiseData.noiseScale, this.noiseData.octaves, this.noiseData.persistance, this.noiseData.lacunarity, this.noiseData.blend, this.noiseData.blendStrength, this.noiseData.offset);
		if (this.terrainData.useFalloff)
		{
			if (this.falloffMap == null)
			{
				this.falloffMap = FalloffGenerator.GenerateFalloffMap(MapGenerator.mapChunkSize);
			}
			for (int i = 0; i < MapGenerator.mapChunkSize; i++)
			{
				for (int j = 0; j < MapGenerator.mapChunkSize; j++)
				{
					if (this.terrainData.useFalloff)
					{
						array[j, i] = Mathf.Clamp(array[j, i] - this.falloffMap[j, i], 0f, 1f);
					}
				}
			}
		}
		return array;
	}

	public void DrawMapInEditor()
	{
		float[,] array = this.GeneratePerlinNoiseMap(0);
		MapDisplay mapDisplay = FindObjectOfType<MapDisplay>();
		if (this.drawMode == MapGenerator.DrawMode.NoiseMap)
		{
			mapDisplay.DrawTexture(TextureGenerator.TextureFromHeightMap(array));
			return;
		}
		if (this.drawMode == MapGenerator.DrawMode.Mesh)
		{
			mapDisplay.DrawMesh(MeshGenerator.GenerateTerrainMesh(array, this.terrainData.heightMultiplier, this.terrainData.heightCurve, this.levelOfDetail));
			return;
		}
		if (this.drawMode == MapGenerator.DrawMode.FalloffMap)
		{
			mapDisplay.DrawTexture(TextureGenerator.TextureFromHeightMap(FalloffGenerator.GenerateFalloffMap(MapGenerator.mapChunkSize)));
		}
	}

	private void OnValidate()
	{
		if (this.terrainData != null)
		{
			this.terrainData.OnValuesUpdate -= this.OnValuesUpdated;
			this.terrainData.OnValuesUpdate += this.OnValuesUpdated;
		}
		if (this.noiseData != null)
		{
			this.noiseData.OnValuesUpdate -= this.OnValuesUpdated;
			this.noiseData.OnValuesUpdate += this.OnValuesUpdated;
		}
		if (this.textureData != null)
		{
			this.textureData.OnValuesUpdated -= this.OnTextureValuesUpdated;
			this.textureData.OnValuesUpdated += this.OnTextureValuesUpdated;
		}
	}

	public MapGenerator.DrawMode drawMode;

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

	public enum DrawMode
	{
		NoiseMap,
		Mesh,
		FalloffMap,
		ColorMap
	}
}
