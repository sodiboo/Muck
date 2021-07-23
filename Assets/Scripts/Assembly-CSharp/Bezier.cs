using UnityEngine;

public class Bezier
{
    public static Vector3 CalculateCubicBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3)
    {
        float num = 1f - t;
        float num2 = t * t;
        float num3 = num * num;
        float num4 = num3 * num;
        float num5 = num2 * t;
        return num4 * p0 + 3f * num3 * t * p1 + 3f * num * num2 * p2 + num5 * p3;
    }
}
