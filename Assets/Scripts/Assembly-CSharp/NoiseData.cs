using System;
using UnityEngine;

// Token: 0x020000EF RID: 239
[CreateAssetMenu]
public class NoiseData : UpdateableData
{
	// Token: 0x040006C9 RID: 1737
	public float noiseScale;

	// Token: 0x040006CA RID: 1738
	[Range(1f, 20f)]
	public int octaves;

	// Token: 0x040006CB RID: 1739
	[Range(0f, 1f)]
	public float persistance;

	// Token: 0x040006CC RID: 1740
	public float lacunarity;

	// Token: 0x040006CD RID: 1741
	public float blend;

	// Token: 0x040006CE RID: 1742
	public float blendStrength;

	// Token: 0x040006CF RID: 1743
	public int seed;

	// Token: 0x040006D0 RID: 1744
	public Vector2 offset;
}
