using System;
using UnityEngine;

// Token: 0x02000103 RID: 259
[CreateAssetMenu]
public class MeshSettings : UpdatableData
{
	// Token: 0x1700004F RID: 79
	// (get) Token: 0x060006BC RID: 1724 RVA: 0x000063A1 File Offset: 0x000045A1
	public int numVertsPerLine
	{
		get
		{
			return MeshSettings.supportedChunkSizes[this.useFlatShading ? this.flatshadedChunkSizeIndex : this.chunkSizeIndex] + 5;
		}
	}

	// Token: 0x17000050 RID: 80
	// (get) Token: 0x060006BD RID: 1725 RVA: 0x000063C1 File Offset: 0x000045C1
	public float meshWorldSize
	{
		get
		{
			return (float)(this.numVertsPerLine - 3) * this.meshScale;
		}
	}

	// Token: 0x040006A2 RID: 1698
	public const int numSupportedLODs = 5;

	// Token: 0x040006A3 RID: 1699
	public const int numSupportedChunkSizes = 9;

	// Token: 0x040006A4 RID: 1700
	public const int numSupportedFlatshadedChunkSizes = 3;

	// Token: 0x040006A5 RID: 1701
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

	// Token: 0x040006A6 RID: 1702
	public float meshScale = 2.5f;

	// Token: 0x040006A7 RID: 1703
	public bool useFlatShading;

	// Token: 0x040006A8 RID: 1704
	[Range(0f, 8f)]
	public int chunkSizeIndex;

	// Token: 0x040006A9 RID: 1705
	[Range(0f, 2f)]
	public int flatshadedChunkSizeIndex;
}
