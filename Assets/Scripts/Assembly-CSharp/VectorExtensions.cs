using System;
using UnityEngine;

public class VectorExtensions : MonoBehaviour
{
	public static Vector3 XZVector(Vector3 v)
	{
		return new Vector3(v.x, 0f, v.z);
	}
}
