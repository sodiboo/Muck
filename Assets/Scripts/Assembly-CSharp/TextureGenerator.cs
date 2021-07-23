using UnityEngine;

public static class TextureGenerator
{
    public static Texture2D textureFromColorMap(Color[] colorMap, int width, int height)
    {
        Texture2D texture2D = new Texture2D(width, height, TextureFormat.RGBA32, mipChain: false);
        texture2D.filterMode = FilterMode.Point;
        texture2D.wrapMode = TextureWrapMode.Clamp;
        texture2D.SetPixels(colorMap);
        texture2D.Apply();
        return texture2D;
    }

    public static Texture2D TextureFromHeightMap(float[,] heightMap)
    {
        int length = heightMap.GetLength(0);
        int length2 = heightMap.GetLength(1);
        Color[] array = new Color[length * length2];
        for (int i = 0; i < length2; i++)
        {
            for (int j = 0; j < length; j++)
            {
                array[i * length + j] = Color.Lerp(Color.black, Color.white, heightMap[j, i]);
            }
        }
        return textureFromColorMap(array, length, length2);
    }

    public static Texture2D ColorTextureFromHeightMap(float[,] heightMap, TextureData textureData)
    {
        int length = heightMap.GetLength(0);
        int length2 = heightMap.GetLength(1);
        Color[] array = new Color[length * length2];
        for (int i = 0; i < length2; i++)
        {
            for (int j = 0; j < length; j++)
            {
                int num = i * length + j;
                array[num] = GetColor(heightMap[j, 240 - i], textureData);
            }
        }
        return textureFromColorMap(array, length, length2);
    }

    public static Color GetColor(float height, TextureData textureData)
    {
        for (int num = textureData.layers.Length - 1; num >= 0; num--)
        {
            if (height - 0.1f > textureData.layers[num].startHeight)
            {
                return textureData.layers[num].tint;
            }
        }
        return textureData.layers[0].tint;
    }
}
