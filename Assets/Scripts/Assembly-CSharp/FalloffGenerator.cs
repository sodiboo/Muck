using System;
using UnityEngine;

// Token: 0x0200010C RID: 268
public static class FalloffGenerator
{
	// Token: 0x060006D7 RID: 1751 RVA: 0x00022F98 File Offset: 0x00021198
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

	// Token: 0x060006D8 RID: 1752 RVA: 0x0002300C File Offset: 0x0002120C
	private static float Evaluate(float value)
	{
		float p = 3f;
		float num = 2.2f;
		return Mathf.Pow(value, p) / (Mathf.Pow(value, p) + Mathf.Pow(num - num * value, p));
	}
}
