
using UnityEngine;

// Token: 0x020000C6 RID: 198
[CreateAssetMenu]
public class MeshSettings : UpdatableData
{
	// Token: 0x17000046 RID: 70
	// (get) Token: 0x06000629 RID: 1577 RVA: 0x0001F250 File Offset: 0x0001D450
	public int numVertsPerLine
	{
		get
		{
			return MeshSettings.supportedChunkSizes[this.useFlatShading ? this.flatshadedChunkSizeIndex : this.chunkSizeIndex] + 5;
		}
	}

	// Token: 0x17000047 RID: 71
	// (get) Token: 0x0600062A RID: 1578 RVA: 0x0001F270 File Offset: 0x0001D470
	public float meshWorldSize
	{
		get
		{
			return (float)(this.numVertsPerLine - 3) * this.meshScale;
		}
	}

	// Token: 0x0400059B RID: 1435
	public const int numSupportedLODs = 5;

	// Token: 0x0400059C RID: 1436
	public const int numSupportedChunkSizes = 9;

	// Token: 0x0400059D RID: 1437
	public const int numSupportedFlatshadedChunkSizes = 3;

	// Token: 0x0400059E RID: 1438
	public static readonly int[] supportedChunkSizes = new int[]
	{
		48,
		72,
		96,
		120,
		144,
		168,
		192,
		216,
		240
	};

	// Token: 0x0400059F RID: 1439
	public float meshScale = 2.5f;

	// Token: 0x040005A0 RID: 1440
	public bool useFlatShading;

	// Token: 0x040005A1 RID: 1441
	[Range(0f, 8f)]
	public int chunkSizeIndex;

	// Token: 0x040005A2 RID: 1442
	[Range(0f, 2f)]
	public int flatshadedChunkSizeIndex;
}
