
using UnityEngine;

// Token: 0x020000C7 RID: 199
[CreateAssetMenu]
public class NoiseData : UpdateableData
{
	// Token: 0x040005A3 RID: 1443
	public float noiseScale;

	// Token: 0x040005A4 RID: 1444
	[Range(1f, 20f)]
	public int octaves;

	// Token: 0x040005A5 RID: 1445
	[Range(0f, 1f)]
	public float persistance;

	// Token: 0x040005A6 RID: 1446
	public float lacunarity;

	// Token: 0x040005A7 RID: 1447
	public float blend;

	// Token: 0x040005A8 RID: 1448
	public float blendStrength;

	// Token: 0x040005A9 RID: 1449
	public int seed;

	// Token: 0x040005AA RID: 1450
	public Vector2 offset;
}
