using System;
using UnityEngine;

// Token: 0x020000EE RID: 238
[CreateAssetMenu]
public class MeshSettings : UpdatableData
{
	// Token: 0x17000056 RID: 86
	// (get) Token: 0x06000743 RID: 1859 RVA: 0x00025330 File Offset: 0x00023530
	public int numVertsPerLine
	{
		get
		{
			return MeshSettings.supportedChunkSizes[this.useFlatShading ? this.flatshadedChunkSizeIndex : this.chunkSizeIndex] + 5;
		}
	}

	// Token: 0x17000057 RID: 87
	// (get) Token: 0x06000744 RID: 1860 RVA: 0x00025350 File Offset: 0x00023550
	public float meshWorldSize
	{
		get
		{
			return (float)(this.numVertsPerLine - 3) * this.meshScale;
		}
	}

	// Token: 0x040006C1 RID: 1729
	public const int numSupportedLODs = 5;

	// Token: 0x040006C2 RID: 1730
	public const int numSupportedChunkSizes = 9;

	// Token: 0x040006C3 RID: 1731
	public const int numSupportedFlatshadedChunkSizes = 3;

	// Token: 0x040006C4 RID: 1732
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

	// Token: 0x040006C5 RID: 1733
	public float meshScale = 2.5f;

	// Token: 0x040006C6 RID: 1734
	public bool useFlatShading;

	// Token: 0x040006C7 RID: 1735
	[Range(0f, 8f)]
	public int chunkSizeIndex;

	// Token: 0x040006C8 RID: 1736
	[Range(0f, 2f)]
	public int flatshadedChunkSizeIndex;
}
