using System;
using UnityEngine;

// Token: 0x02000105 RID: 261
[CreateAssetMenu]
public class TerrainData : UpdateableData
{
	// Token: 0x17000051 RID: 81
	// (get) Token: 0x060006C1 RID: 1729 RVA: 0x00006407 File Offset: 0x00004607
	public float minHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(0f);
		}
	}

	// Token: 0x17000052 RID: 82
	// (get) Token: 0x060006C2 RID: 1730 RVA: 0x00006427 File Offset: 0x00004627
	public float maxHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(1f);
		}
	}

	// Token: 0x040006B2 RID: 1714
	public float uniformScale = 2.5f;

	// Token: 0x040006B3 RID: 1715
	public bool useFalloff;

	// Token: 0x040006B4 RID: 1716
	public float heightMultiplier;

	// Token: 0x040006B5 RID: 1717
	public AnimationCurve heightCurve;
}
