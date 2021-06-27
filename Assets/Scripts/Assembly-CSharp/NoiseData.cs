using System;
using UnityEngine;

[CreateAssetMenu]
public class NoiseData : UpdateableData
{
	public float noiseScale;

	[Range(1f, 20f)]
	public int octaves;

	[Range(0f, 1f)]
	public float persistance;

	public float lacunarity;

	public float blend;

	public float blendStrength;

	public int seed;

	public Vector2 offset;
}
