using System;
using UnityEngine;

// Token: 0x02000104 RID: 260
[CreateAssetMenu]
public class NoiseData : UpdateableData
{
	// Token: 0x040006AA RID: 1706
	public float noiseScale;

	// Token: 0x040006AB RID: 1707
	[Range(1f, 20f)]
	public int octaves;

	// Token: 0x040006AC RID: 1708
	[Range(0f, 1f)]
	public float persistance;

	// Token: 0x040006AD RID: 1709
	public float lacunarity;

	// Token: 0x040006AE RID: 1710
	public float blend;

	// Token: 0x040006AF RID: 1711
	public float blendStrength;

	// Token: 0x040006B0 RID: 1712
	public int seed;

	// Token: 0x040006B1 RID: 1713
	public Vector2 offset;
}
