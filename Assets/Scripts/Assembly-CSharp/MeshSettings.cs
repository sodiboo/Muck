using UnityEngine;

[CreateAssetMenu]
public class MeshSettings : UpdatableData
{
    public const int numSupportedLODs = 5;

    public const int numSupportedChunkSizes = 9;

    public const int numSupportedFlatshadedChunkSizes = 3;

    public static readonly int[] supportedChunkSizes = new int[9] { 48, 72, 96, 120, 144, 168, 192, 216, 240 };

    public float meshScale = 2.5f;

    public bool useFlatShading;

    [Range(0f, 8f)]
    public int chunkSizeIndex;

    [Range(0f, 2f)]
    public int flatshadedChunkSizeIndex;

    public int numVertsPerLine => supportedChunkSizes[useFlatShading ? flatshadedChunkSizeIndex : chunkSizeIndex] + 5;

    public float meshWorldSize => (float)(numVertsPerLine - 3) * meshScale;
}
