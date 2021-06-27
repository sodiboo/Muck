using System;
using UnityEngine;

// Token: 0x02000019 RID: 25
[ExecuteInEditMode]
public class ColorAtmosphere : MonoBehaviour
{
	// Token: 0x0600009A RID: 154 RVA: 0x00004FD4 File Offset: 0x000031D4
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

	// Token: 0x0600009B RID: 155 RVA: 0x0000509C File Offset: 0x0000329C
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

	// Token: 0x0400009C RID: 156
	[Header("Ground / Grass")]
	public TextureData textureData;

	// Token: 0x0400009D RID: 157
	public Color defaultGrassColor;

	// Token: 0x0400009E RID: 158
	public Color[] colorRange;

	// Token: 0x0400009F RID: 159
	public Color[] grassColorRange;

	// Token: 0x040000A0 RID: 160
	public Color groundColor;

	// Token: 0x040000A1 RID: 161
	public Color grassColor;

	// Token: 0x040000A2 RID: 162
	public Material grass;

	// Token: 0x040000A3 RID: 163
	[Header("Fog")]
	public DayCycle dayCycle;

	// Token: 0x040000A4 RID: 164
	public Color[] fogColors;
}
