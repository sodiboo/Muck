using System;

// Token: 0x020000E5 RID: 229
public class WorldUtility
{
	// Token: 0x06000725 RID: 1829 RVA: 0x00024CC0 File Offset: 0x00022EC0
	public static TextureData.TerrainType WorldHeightToBiome(float height)
	{
		float heightMultiplier = MapGenerator.Instance.terrainData.heightMultiplier;
		height /= heightMultiplier;
		TextureData.Layer[] layers = MapGenerator.Instance.textureData.layers;
		for (int i = layers.Length - 1; i > 0; i--)
		{
			if (height >= layers[i].startHeight)
			{
				return layers[i].type;
			}
		}
		return TextureData.TerrainType.Water;
	}
}
