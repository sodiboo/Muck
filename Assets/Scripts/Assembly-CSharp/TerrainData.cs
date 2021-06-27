using System;
using UnityEngine;

[CreateAssetMenu]
public class TerrainData : UpdateableData
{
	public float minHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(0f);
		}
	}

	public float maxHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(1f);
		}
	}

	public float uniformScale = 2.5f;

	public bool useFalloff;

	public float heightMultiplier;

	public AnimationCurve heightCurve;
}
