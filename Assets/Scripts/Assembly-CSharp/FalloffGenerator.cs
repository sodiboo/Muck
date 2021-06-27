using System;
using UnityEngine;

// Token: 0x020000F4 RID: 244
public static class FalloffGenerator
{
	// Token: 0x06000755 RID: 1877 RVA: 0x000256DC File Offset: 0x000238DC
	public static float[,] GenerateFalloffMap(int size)
	{
		float[,] array = new float[size, size];
		for (int i = 0; i < size; i++)
		{
			for (int j = 0; j < size; j++)
			{
				float f = (float)i / (float)size * 2f - 1f;
				float f2 = (float)j / (float)size * 2f - 1f;
				float value = Mathf.Max(Mathf.Abs(f), Mathf.Abs(f2));
				array[i, j] = FalloffGenerator.Evaluate(value);
			}
		}
		return array;
	}

	// Token: 0x06000756 RID: 1878 RVA: 0x00025750 File Offset: 0x00023950
	private static float Evaluate(float value)
	{
		float p = 3f;
		float num = 2.2f;
		return Mathf.Pow(value, p) / (Mathf.Pow(value, p) + Mathf.Pow(num - num * value, p));
	}
}
