using System;
using UnityEngine;

// Token: 0x020000FA RID: 250
public static class TextureGenerator
{
	// Token: 0x06000769 RID: 1897 RVA: 0x00026098 File Offset: 0x00024298
	public static Texture2D textureFromColorMap(Color[] colorMap, int width, int height)
	{
		Texture2D texture2D = new Texture2D(width, height, TextureFormat.RGBA32, false);
		texture2D.filterMode = FilterMode.Point;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		texture2D.SetPixels(colorMap);
		texture2D.Apply();
		return texture2D;
	}

	// Token: 0x0600076A RID: 1898 RVA: 0x000260C0 File Offset: 0x000242C0
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

	// Token: 0x0600076B RID: 1899 RVA: 0x00026130 File Offset: 0x00024330
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

	// Token: 0x0600076C RID: 1900 RVA: 0x000261A0 File Offset: 0x000243A0
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
