using UnityEngine;

[CreateAssetMenu]
public class TerrainData : UpdateableData
{
    public float uniformScale = 2.5f;

    public bool useFalloff;

    public float heightMultiplier;

    public AnimationCurve heightCurve;

    public float minHeight => uniformScale * heightMultiplier * heightCurve.Evaluate(0f);

    public float maxHeight => uniformScale * heightMultiplier * heightCurve.Evaluate(1f);
}
