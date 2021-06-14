using System;

// Token: 0x020000FA RID: 250
public class WorldUtility
{
	// Token: 0x0600069E RID: 1694 RVA: 0x00022710 File Offset: 0x00020910
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
