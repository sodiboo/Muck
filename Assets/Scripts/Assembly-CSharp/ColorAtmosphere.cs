using System;
using UnityEngine;

[ExecuteInEditMode]
public class ColorAtmosphere : MonoBehaviour
{
	private void Awake()
	{
		ConsistentRandom consistentRandom = new ConsistentRandom(GameManager.GetSeed());
		float num = (float)consistentRandom.NextDouble();
		Color tint = this.FindRandomBlendColor(this.colorRange, num);
		Color color = this.FindRandomBlendColor(this.grassColorRange, num);
		this.textureData.layers[2].tint = tint;
		Color value = color * 1.5f;
		Color value2 = color;
		this.grass.SetColor("_BottomColor", value2);
		this.grass.SetColor("_TopColor", value);
		Debug.Log("grassindex: " + num * (float)this.colorRange.Length);
		float rand = (float)consistentRandom.NextDouble();
		Color color2 = this.FindRandomBlendColor(this.fogColors, rand);
		RenderSettings.fogColor = color2;
		this.dayCycle.dayFog = color2;
	}

	public Color FindRandomBlendColor(Color[] colors, float rand)
	{
		rand *= (float)(colors.Length - 1);
		int num = Mathf.FloorToInt(rand);
		int num2 = Mathf.CeilToInt(rand);
		Color a = colors[num];
		Color a2 = colors[num2];
		float num3 = rand - (float)num;
		float b = 1f - num3;
		return a * num3 + a2 * b;
	}

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
}
