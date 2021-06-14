using System;
using UnityEngine;

// Token: 0x02000015 RID: 21
[ExecuteInEditMode]
public class ColorAtmosphere : MonoBehaviour
{
	// Token: 0x0600006A RID: 106 RVA: 0x000090AC File Offset: 0x000072AC
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

	// Token: 0x0600006B RID: 107 RVA: 0x00009174 File Offset: 0x00007374
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

	// Token: 0x04000068 RID: 104
	[Header("Ground / Grass")]
	public TextureData textureData;

	// Token: 0x04000069 RID: 105
	public Color defaultGrassColor;

	// Token: 0x0400006A RID: 106
	public Color[] colorRange;

	// Token: 0x0400006B RID: 107
	public Color[] grassColorRange;

	// Token: 0x0400006C RID: 108
	public Color groundColor;

	// Token: 0x0400006D RID: 109
	public Color grassColor;

	// Token: 0x0400006E RID: 110
	public Material grass;

	// Token: 0x0400006F RID: 111
	[Header("Fog")]
	public DayCycle dayCycle;

	// Token: 0x04000070 RID: 112
	public Color[] fogColors;
}
