
using UnityEngine;

// Token: 0x020000CE RID: 206
public class MapGenerator : MonoBehaviour
{
	// Token: 0x06000640 RID: 1600 RVA: 0x0001F708 File Offset: 0x0001D908
	private void Awake()
	{
		MapGenerator.Instance = this;
		this.textureData.ApplyToMaterial(this.terrainMaterial);
		this.textureData.UpdateMeshHeights(this.terrainMaterial, this.terrainData.minHeight, this.terrainData.maxHeight);
	}

	// Token: 0x06000641 RID: 1601 RVA: 0x0001F748 File Offset: 0x0001D948
	private void OnValuesUpdated()
	{
		if (!Application.isPlaying)
		{
			this.GenerateMap(105);
			this.DrawMapInEditor();
		}
	}

	// Token: 0x06000642 RID: 1602 RVA: 0x0001F75F File Offset: 0x0001D95F
	private void OnTextureValuesUpdated()
	{
		this.textureData.ApplyToMaterial(this.terrainMaterial);
	}

	// Token: 0x06000643 RID: 1603 RVA: 0x0001F774 File Offset: 0x0001D974
	public void GenerateMap(int seed = 105)
	{
		this.heightMap = this.GeneratePerlinNoiseMap(seed);
		this.GeneratePerlinNoiseMap(seed);
		this.textureData.UpdateMeshHeights(this.terrainMaterial, this.terrainData.minHeight, this.terrainData.maxHeight);
		this.display = Object.FindObjectOfType<MapDisplay>();
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

	// Token: 0x06000644 RID: 1604 RVA: 0x0001F8AC File Offset: 0x0001DAAC
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

	// Token: 0x06000645 RID: 1605 RVA: 0x0001F96C File Offset: 0x0001DB6C
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

	// Token: 0x06000646 RID: 1606 RVA: 0x0001FA58 File Offset: 0x0001DC58
	public void DrawMapInEditor()
	{
		float[,] array = this.GeneratePerlinNoiseMap(0);
		MapDisplay mapDisplay = Object.FindObjectOfType<MapDisplay>();
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

	// Token: 0x06000647 RID: 1607 RVA: 0x0001FAD8 File Offset: 0x0001DCD8
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

	// Token: 0x040005BC RID: 1468
	public MapGenerator.DrawMode drawMode;

	// Token: 0x040005BD RID: 1469
	public TerrainData terrainData;

	// Token: 0x040005BE RID: 1470
	public NoiseData noiseData;

	// Token: 0x040005BF RID: 1471
	public TextureData textureData;

	// Token: 0x040005C0 RID: 1472
	public Material terrainMaterial;

	// Token: 0x040005C1 RID: 1473
	[Range(0f, 6f)]
	public int levelOfDetail;

	// Token: 0x040005C2 RID: 1474
	private static int seed = 105;

	// Token: 0x040005C3 RID: 1475
	public bool autoUpdate;

	// Token: 0x040005C4 RID: 1476
	private float[,] falloffMap;

	// Token: 0x040005C5 RID: 1477
	private MapDisplay display;

	// Token: 0x040005C6 RID: 1478
	public static int mapChunkSize = 241;

	// Token: 0x040005C7 RID: 1479
	public static int worldScale = 12;

	// Token: 0x040005C8 RID: 1480
	public static MapGenerator Instance;

	// Token: 0x040005C9 RID: 1481
	public static float[,] staticNoiseMap;

	// Token: 0x040005CA RID: 1482
	public float[,] heightMap;

	// Token: 0x02000133 RID: 307
	public enum DrawMode
	{
		// Token: 0x040007D2 RID: 2002
		NoiseMap,
		// Token: 0x040007D3 RID: 2003
		Mesh,
		// Token: 0x040007D4 RID: 2004
		FalloffMap,
		// Token: 0x040007D5 RID: 2005
		ColorMap
	}
}
