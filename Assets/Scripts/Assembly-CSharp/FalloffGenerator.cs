using UnityEngine;

public static class FalloffGenerator
{
    public static float[,] GenerateFalloffMap(int size)
    {
        float[,] array = new float[size, size];
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                float f = (float)i / (float)size * 2f - 1f;
                float value = Mathf.Max(b: Mathf.Abs((float)j / (float)size * 2f - 1f), a: Mathf.Abs(f));
                array[i, j] = Evaluate(value);
            }
        }
        return array;
    }

    private static float Evaluate(float value)
    {
        float p = 3f;
        float num = 2.2f;
        return Mathf.Pow(value, p) / (Mathf.Pow(value, p) + Mathf.Pow(num - num * value, p));
    }
}
