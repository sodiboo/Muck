using System;
using UnityEngine;

// Token: 0x02000113 RID: 275
public static class TextureGenerator
{
	// Token: 0x060006EB RID: 1771 RVA: 0x0000664D File Offset: 0x0000484D
	public static Texture2D textureFromColorMap(Color[] colorMap, int width, int height)
	{
		Texture2D texture2D = new Texture2D(width, height, TextureFormat.RGBA32, false);
		texture2D.filterMode = FilterMode.Point;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		texture2D.SetPixels(colorMap);
		texture2D.Apply();
		return texture2D;
	}

	// Token: 0x060006EC RID: 1772 RVA: 0x000237C8 File Offset: 0x000219C8
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

	// Token: 0x060006ED RID: 1773 RVA: 0x00023838 File Offset: 0x00021A38
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

	// Token: 0x060006EE RID: 1774 RVA: 0x000238A8 File Offset: 0x00021AA8
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
