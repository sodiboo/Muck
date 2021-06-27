using System;
using UnityEngine;

public class Bezier
{
	public static Vector3 CalculateCubicBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3)
	{
		float num = 1f - t;
		float num2 = t * t;
		float num3 = num * num;
		float d = num3 * num;
		float d2 = num2 * t;
		return d * p0 + 3f * num3 * t * p1 + 3f * num * num2 * p2 + d2 * p3;
	}
}
