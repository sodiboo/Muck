
using UnityEngine;

// Token: 0x020000D2 RID: 210
public static class TextureGenerator
{
	// Token: 0x0600064F RID: 1615 RVA: 0x0001FFB8 File Offset: 0x0001E1B8
	public static Texture2D textureFromColorMap(Color[] colorMap, int width, int height)
	{
		Texture2D texture2D = new Texture2D(width, height, TextureFormat.RGBA32, false);
		texture2D.filterMode = FilterMode.Point;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		texture2D.SetPixels(colorMap);
		texture2D.Apply();
		return texture2D;
	}

	// Token: 0x06000650 RID: 1616 RVA: 0x0001FFE0 File Offset: 0x0001E1E0
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
		return TextureGenerator.textureFromColorMap(array, length, length2);
	}

	// Token: 0x06000651 RID: 1617 RVA: 0x00020050 File Offset: 0x0001E250
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
				array[num] = TextureGenerator.GetColor(heightMap[j, 240 - i], textureData);
			}
		}
		return TextureGenerator.textureFromColorMap(array, length, length2);
	}

	// Token: 0x06000652 RID: 1618 RVA: 0x000200C0 File Offset: 0x0001E2C0
	public static Color GetColor(float height, TextureData textureData)
	{
		for (int i = textureData.layers.Length - 1; i >= 0; i--)
		{
			if (height - 0.1f > textureData.layers[i].startHeight)
			{
				return textureData.layers[i].tint;
			}
		}
		return textureData.layers[0].tint;
	}
}
