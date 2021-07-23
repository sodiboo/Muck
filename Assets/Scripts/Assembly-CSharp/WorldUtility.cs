public class WorldUtility
{
    public static TextureData.TerrainType WorldHeightToBiome(float height)
    {
        float heightMultiplier = MapGenerator.Instance.terrainData.heightMultiplier;
        height /= heightMultiplier;
        TextureData.Layer[] layers = MapGenerator.Instance.textureData.layers;
        for (int num = layers.Length - 1; num > 0; num--)
        {
            if (height >= layers[num].startHeight)
            {
                return layers[num].type;
            }
        }
        return TextureData.TerrainType.Water;
    }
}
