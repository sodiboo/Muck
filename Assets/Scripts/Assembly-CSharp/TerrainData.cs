
using UnityEngine;

// Token: 0x020000C8 RID: 200
[CreateAssetMenu]
public class TerrainData : UpdateableData
{
	// Token: 0x17000048 RID: 72
	// (get) Token: 0x0600062E RID: 1582 RVA: 0x0001F2B6 File Offset: 0x0001D4B6
	public float minHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(0f);
		}
	}

	// Token: 0x17000049 RID: 73
	// (get) Token: 0x0600062F RID: 1583 RVA: 0x0001F2D6 File Offset: 0x0001D4D6
	public float maxHeight
	{
		get
		{
			return this.uniformScale * this.heightMultiplier * this.heightCurve.Evaluate(1f);
		}
	}

	// Token: 0x040005AB RID: 1451
	public float uniformScale = 2.5f;

	// Token: 0x040005AC RID: 1452
	public bool useFalloff;

	// Token: 0x040005AD RID: 1453
	public float heightMultiplier;

	// Token: 0x040005AE RID: 1454
	public AnimationCurve heightCurve;
}
