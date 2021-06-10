

// Token: 0x020000BD RID: 189
public class WorldUtility
{
	// Token: 0x0600060B RID: 1547 RVA: 0x0001EC1C File Offset: 0x0001CE1C
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
