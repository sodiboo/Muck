
using UnityEngine;

// Token: 0x020000CC RID: 204
public static class FalloffGenerator
{
	// Token: 0x0600063B RID: 1595 RVA: 0x0001F5FC File Offset: 0x0001D7FC
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

	// Token: 0x0600063C RID: 1596 RVA: 0x0001F670 File Offset: 0x0001D870
	private static float Evaluate(float value)
	{
		float p = 3f;
		float num = 2.2f;
		return Mathf.Pow(value, p) / (Mathf.Pow(value, p) + Mathf.Pow(num - num * value, p));
	}
}
