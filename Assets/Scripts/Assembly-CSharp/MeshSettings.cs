using System;
using UnityEngine;

[CreateAssetMenu]
public class MeshSettings : UpdatableData
{
	public int numVertsPerLine
	{
		get
		{
			return MeshSettings.supportedChunkSizes[this.useFlatShading ? this.flatshadedChunkSizeIndex : this.chunkSizeIndex] + 5;
		}
	}

	public float meshWorldSize
	{
		get
		{
			return (float)(this.numVertsPerLine - 3) * this.meshScale;
		}
	}

	public const int numSupportedLODs = 5;

	public const int numSupportedChunkSizes = 9;

	public const int numSupportedFlatshadedChunkSizes = 3;

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

	public float meshScale = 2.5f;

	public bool useFlatShading;

	[Range(0f, 8f)]
	public int chunkSizeIndex;

	[Range(0f, 2f)]
	public int flatshadedChunkSizeIndex;
}
