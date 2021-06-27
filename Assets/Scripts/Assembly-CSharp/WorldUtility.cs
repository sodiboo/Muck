using System;

public class WorldUtility
{
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
