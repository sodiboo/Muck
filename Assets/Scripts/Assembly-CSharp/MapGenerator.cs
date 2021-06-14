using System;
using UnityEngine;

// Token: 0x0200010E RID: 270
public class MapGenerator : MonoBehaviour
{
	// Token: 0x060006DC RID: 1756 RVA: 0x00006522 File Offset: 0x00004722
	private void Awake()
	{
		MapGenerator.Instance = this;
		this.textureData.ApplyToMaterial(this.terrainMaterial);
		this.textureData.UpdateMeshHeights(this.terrainMaterial, this.terrainData.minHeight, this.terrainData.maxHeight);
	}

	// Token: 0x060006DD RID: 1757 RVA: 0x00006562 File Offset: 0x00004762
	private void OnValuesUpdated()
	{
		if (!Application.isPlaying)
		{
			this.GenerateMap(105);
			this.DrawMapInEditor();
		}
	}

	// Token: 0x060006DE RID: 1758 RVA: 0x00006579 File Offset: 0x00004779
	private void OnTextureValuesUpdated()
	{
		this.textureData.ApplyToMaterial(this.terrainMaterial);
	}

	// Token: 0x060006DF RID: 1759 RVA: 0x00023040 File Offset: 0x00021240
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

	// Token: 0x060006E0 RID: 1760 RVA: 0x00023178 File Offset: 0x00021378
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

	// Token: 0x060006E1 RID: 1761 RVA: 0x00023238 File Offset: 0x00021438
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

	// Token: 0x060006E2 RID: 1762 RVA: 0x00023324 File Offset: 0x00021524
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

	// Token: 0x060006E3 RID: 1763 RVA: 0x000233A4 File Offset: 0x000215A4
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

	// Token: 0x040006D5 RID: 1749
	public MapGenerator.DrawMode drawMode;

	// Token: 0x040006D6 RID: 1750
	public TerrainData terrainData;

	// Token: 0x040006D7 RID: 1751
	public NoiseData noiseData;

	// Token: 0x040006D8 RID: 1752
	public TextureData textureData;

	// Token: 0x040006D9 RID: 1753
	public Material terrainMaterial;

	// Token: 0x040006DA RID: 1754
	[Range(0f, 6f)]
	public int levelOfDetail;

	// Token: 0x040006DB RID: 1755
	private static int seed = 105;

	// Token: 0x040006DC RID: 1756
	public bool autoUpdate;

	// Token: 0x040006DD RID: 1757
	private float[,] falloffMap;

	// Token: 0x040006DE RID: 1758
	private MapDisplay display;

	// Token: 0x040006DF RID: 1759
	public static int mapChunkSize = 241;

	// Token: 0x040006E0 RID: 1760
	public static int worldScale = 12;

	// Token: 0x040006E1 RID: 1761
	public static MapGenerator Instance;

	// Token: 0x040006E2 RID: 1762
	public static float[,] staticNoiseMap;

	// Token: 0x040006E3 RID: 1763
	public float[,] heightMap;

	// Token: 0x0200010F RID: 271
	public enum DrawMode
	{
		// Token: 0x040006E5 RID: 1765
		NoiseMap,
		// Token: 0x040006E6 RID: 1766
		Mesh,
		// Token: 0x040006E7 RID: 1767
		FalloffMap,
		// Token: 0x040006E8 RID: 1768
		ColorMap
	}
}
