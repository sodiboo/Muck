using UnityEngine;

public class ColorAtmosphere : MonoBehaviour
{
    [Header("Ground / Grass")]
    public TextureData textureData;

    public Color defaultGrassColor;

    public Color[] colorRange;

    public Color[] grassColorRange;

    public Color groundColor;

    public Color grassColor;

    public Material grass;

    [Header("Fog")]
    public DayCycle dayCycle;

    public Color[] fogColors;

    private void Awake()
    {
        ConsistentRandom consistentRandom = new ConsistentRandom(GameManager.GetSeed());
        float num = (float)consistentRandom.NextDouble();
        Color tint = FindRandomBlendColor(colorRange, num);
        Color color = FindRandomBlendColor(grassColorRange, num);
        textureData.layers[2].tint = tint;
        Color value = color * 1.5f;
        Color value2 = color;
        grass.SetColor("_BottomColor", value2);
        grass.SetColor("_TopColor", value);
        Debug.Log("grassindex: " + num * (float)colorRange.Length);
        float rand = (float)consistentRandom.NextDouble();
        Color dayFog = (RenderSettings.fogColor = FindRandomBlendColor(fogColors, rand));
        dayCycle.dayFog = dayFog;
    }

    public Color FindRandomBlendColor(Color[] colors, float rand)
    {
        rand *= (float)(colors.Length - 1);
        int num = Mathf.FloorToInt(rand);
        int num2 = Mathf.CeilToInt(rand);
        Color color = colors[num];
        Color color2 = colors[num2];
        float num3 = rand - (float)num;
        float num4 = 1f - num3;
        return color * num3 + color2 * num4;
    }
}
