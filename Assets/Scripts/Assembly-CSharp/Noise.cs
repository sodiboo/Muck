using System;
using UnityEngine;

public static class Noise
{
	public static float[,] GenerateNoiseMap(int mapWidth, int mapHeight, int seed, float scale, int octaves, float persistance, float lacunarity, float blend, float blendStrength, Vector2 offset)
	{
		float[,] array = new float[mapWidth, mapHeight];
		ConsistentRandom consistentRandom = new ConsistentRandom(seed);
		DebugNet.r.Add(string.Concat(new object[]
		{
			"seed: ",
			seed,
			", first random: ",
			consistentRandom.Next(0, 10000)
		}));
		Vector2[] array2 = new Vector2[octaves];
		for (int i = 0; i < octaves; i++)
		{
			float x = (float)consistentRandom.Next(-100000, 100000) + offset.x;
			float y = (float)consistentRandom.Next(-100000, 100000) + offset.y;
			array2[i] = new Vector2(x, y);
		}
		if (scale <= 0f)
		{
			scale = 0.0001f;
		}
		float num = float.MinValue;
		float num2 = float.MaxValue;
		float num3 = (float)mapWidth / 2f;
		float num4 = (float)mapHeight / 2f;
		for (int j = 0; j < mapHeight; j++)
		{
			for (int k = 0; k < mapWidth; k++)
			{
				float num5 = 1f;
				float num6 = 1f;
				float num7 = 0f;
				for (int l = 0; l < octaves; l++)
				{
					float num8 = ((float)k - num3) / scale * num6 + array2[l].x;
					float num9 = ((float)k - num3) / scale * (num6 * blend) + array2[l].x;
					float num10 = ((float)j - num4) / scale * num6 + array2[l].y;
					float num11 = ((float)j - num4) / scale * (num6 * blend) + array2[l].y;
					float num12 = Mathf.PerlinNoise(num8 + num9 * blendStrength, num10 + num11 * blendStrength) * 2f - 1f;
					num7 += num12 * num5;
					num5 *= persistance;
					num6 *= lacunarity;
				}
				if (num7 > num)
				{
					num = num7;
				}
				else if (num7 < num2)
				{
					num2 = num7;
				}
				array[k, j] = num7;
			}
		}
		for (int m = 0; m < mapHeight; m++)
		{
			for (int n = 0; n < mapWidth; n++)
			{
				array[n, m] = Mathf.InverseLerp(num2, num, array[n, m]);
			}
		}
		return array;
	}
}
