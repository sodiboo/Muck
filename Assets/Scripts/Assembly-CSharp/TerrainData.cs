using System;
using UnityEngine;

// Token: 0x020000F0 RID: 240
[CreateAssetMenu]
public class TerrainData : UpdateableData
{
	// Token: 0x17000058 RID: 88
	// (get) Token: 0x06000748 RID: 1864 RVA: 0x00025396 File Offset: 0x00023596
	public float minHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(0f);
		}
	}

	// Token: 0x17000059 RID: 89
	// (get) Token: 0x06000749 RID: 1865 RVA: 0x000253B6 File Offset: 0x000235B6
	public float maxHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(1f);
		}
	}

	// Token: 0x040006D1 RID: 1745
	public float uniformScale = 2.5f;

	// Token: 0x040006D2 RID: 1746
	public bool useFalloff;

	// Token: 0x040006D3 RID: 1747
	public float heightMultiplier;

	// Token: 0x040006D4 RID: 1748
	public AnimationCurve heightCurve;
}
