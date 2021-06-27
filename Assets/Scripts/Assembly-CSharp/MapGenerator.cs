using System;
using UnityEngine;

// Token: 0x020000F6 RID: 246
public class MapGenerator : MonoBehaviour
{
	// Token: 0x0600075A RID: 1882 RVA: 0x000257E8 File Offset: 0x000239E8
	private void Awake()
	{
		MapGenerator.Instance = this;
		this.textureData.ApplyToMaterial(this.terrainMaterial);
		this.textureData.UpdateMeshHeights(this.terrainMaterial, this.terrainData.minHeight, this.terrainData.maxHeight);
	}

	// Token: 0x0600075B RID: 1883 RVA: 0x00025828 File Offset: 0x00023A28
	private void OnValuesUpdated()
	{
		if (!Application.isPlaying)
		{
			this.GenerateMap(105);
			this.DrawMapInEditor();
		}
	}

	// Token: 0x0600075C RID: 1884 RVA: 0x0002583F File Offset: 0x00023A3F
	private void OnTextureValuesUpdated()
	{
		this.textureData.ApplyToMaterial(this.terrainMaterial);
	}

	// Token: 0x0600075D RID: 1885 RVA: 0x00025854 File Offset: 0x00023A54
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

	// Token: 0x0600075E RID: 1886 RVA: 0x0002598C File Offset: 0x00023B8C
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

	// Token: 0x0600075F RID: 1887 RVA: 0x00025A4C File Offset: 0x00023C4C
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

	// Token: 0x06000760 RID: 1888 RVA: 0x00025B38 File Offset: 0x00023D38
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

	// Token: 0x06000761 RID: 1889 RVA: 0x00025BB8 File Offset: 0x00023DB8
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

	// Token: 0x040006E2 RID: 1762
	public MapGenerator.DrawMode drawMode;

	// Token: 0x040006E3 RID: 1763
	public TerrainData terrainData;

	// Token: 0x040006E4 RID: 1764
	public NoiseData noiseData;

	// Token: 0x040006E5 RID: 1765
	public TextureData textureData;

	// Token: 0x040006E6 RID: 1766
	public Material terrainMaterial;

	// Token: 0x040006E7 RID: 1767
	[Range(0f, 6f)]
	public int levelOfDetail;

	// Token: 0x040006E8 RID: 1768
	private static int seed = 105;

	// Token: 0x040006E9 RID: 1769
	public bool autoUpdate;

	// Token: 0x040006EA RID: 1770
	private float[,] falloffMap;

	// Token: 0x040006EB RID: 1771
	private MapDisplay display;

	// Token: 0x040006EC RID: 1772
	public static int mapChunkSize = 241;

	// Token: 0x040006ED RID: 1773
	public static int worldScale = 12;

	// Token: 0x040006EE RID: 1774
	public static MapGenerator Instance;

	// Token: 0x040006EF RID: 1775
	public static float[,] staticNoiseMap;

	// Token: 0x040006F0 RID: 1776
	public float[,] heightMap;

	// Token: 0x02000174 RID: 372
	public enum DrawMode
	{
		// Token: 0x04000959 RID: 2393
		NoiseMap,
		// Token: 0x0400095A RID: 2394
		Mesh,
		// Token: 0x0400095B RID: 2395
		FalloffMap,
		// Token: 0x0400095C RID: 2396
		ColorMap
	}
}
