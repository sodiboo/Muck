using System;
using UnityEngine;

// Token: 0x0200001F RID: 31
public class DayCycle : MonoBehaviour
{
	// Token: 0x060000A5 RID: 165 RVA: 0x00009A30 File Offset: 0x00007C30
	private void Awake()
	{
		this.sky.mainTextureOffset = new Vector2(0.5f, 0f);
		this.waterColor = this.water.material.GetColor("_ShallowColor");
		this.waterShallowColor = this.water.material.GetColor("_DeepColor");
		DayCycle.time = 0f;
		DayCycle.totalTime = 0f;
	}

	// Token: 0x17000006 RID: 6
	// (get) Token: 0x060000A6 RID: 166 RVA: 0x00002991 File Offset: 0x00000B91
	// (set) Token: 0x060000A7 RID: 167 RVA: 0x00002998 File Offset: 0x00000B98
	public static float totalTime { get; private set; }

	// Token: 0x060000A8 RID: 168 RVA: 0x00009AA4 File Offset: 0x00007CA4
	private void Update()
	{
		if (GameManager.state != GameManager.GameState.Playing)
		{
			return;
		}
		float num = 1f * this.timeSpeed / DayCycle.dayDuration;
		if (DayCycle.time > 0.5f)
		{
			num /= this.nightDuration;
		}
		float num2 = num * Time.deltaTime;
		DayCycle.time += num2;
		DayCycle.time %= 1f;
		DayCycle.totalTime += num2;
		if (this.alwaysDay)
		{
			DayCycle.time = 0.25f;
		}
		this.sun.rotation = Quaternion.Euler(new Vector3(DayCycle.time * 360f, 0f, 0f));
		this.sky.mainTextureOffset = new Vector2(DayCycle.time - 0.25f, 0f);
		this.SunLight();
		float num3 = this.EvaluateWaterColor((DayCycle.time + 0.75f) % 1f);
		RenderSettings.fogColor = Color.Lerp(this.dayFog, this.nightFog, num3);
		this.skybox.SetFloat("_Exposure", 1f - num3);
		float num4 = 0.75f - num3 * 0.5f;
		Color b = new Color(num4, num4, num4);
		RenderSettings.ambientSkyColor = Color.Lerp(RenderSettings.ambientSkyColor, b, Time.deltaTime * 0.5f);
		Color value = this.waterColor * (1f - num3) + Color.black * num3;
		Color value2 = this.waterShallowColor * (1f - num3) + Color.black * num3;
		this.water.material.SetColor("_ShallowColor", value);
		this.water.material.SetColor("_DeepColor", value2);
	}

	// Token: 0x060000A9 RID: 169 RVA: 0x00009C64 File Offset: 0x00007E64
	private void SunLight()
	{
		if (DayCycle.time > 0.5f)
		{
			this.desiredSunlight = 0f;
		}
		else if (DayCycle.time < 0.5f && this.moonLight.intensity < 0.05f)
		{
			this.desiredSunlight = 0.6f;
		}
		if (this.sunLight.intensity < 0.05f && DayCycle.time > 0.5f && DayCycle.time < 0.75f)
		{
			this.desiredMoonlight = 0.6f;
		}
		else if (DayCycle.time > 0.97f || DayCycle.time < 0.5f)
		{
			this.desiredMoonlight = 0f;
		}
		this.sunLight.intensity = Mathf.Lerp(this.sunLight.intensity, this.desiredSunlight, Time.deltaTime * 1f);
		this.moonLight.intensity = Mathf.Lerp(this.moonLight.intensity, this.desiredMoonlight, Time.deltaTime * 1f);
	}

	// Token: 0x060000AA RID: 170 RVA: 0x000029A0 File Offset: 0x00000BA0
	private float EvaluateWaterColor(float x)
	{
		return this.waterGraph.Evaluate(x);
	}

	// Token: 0x0400009C RID: 156
	public bool alwaysDay;

	// Token: 0x0400009D RID: 157
	public static float dayDuration = 1f;

	// Token: 0x0400009E RID: 158
	public float nightDuration = 0.5f;

	// Token: 0x0400009F RID: 159
	public float timeSpeed = 0.01f;

	// Token: 0x040000A0 RID: 160
	public static float time;

	// Token: 0x040000A1 RID: 161
	public Transform sun;

	// Token: 0x040000A2 RID: 162
	public Material sky;

	// Token: 0x040000A3 RID: 163
	public float skyOffset;

	// Token: 0x040000A4 RID: 164
	public MeshRenderer water;

	// Token: 0x040000A5 RID: 165
	public Color waterColor;

	// Token: 0x040000A6 RID: 166
	public Color waterShallowColor;

	// Token: 0x040000A7 RID: 167
	public Material skybox;

	// Token: 0x040000A8 RID: 168
	public Light sunLight;

	// Token: 0x040000A9 RID: 169
	public Light moonLight;

	// Token: 0x040000AA RID: 170
	public Color dayFog;

	// Token: 0x040000AB RID: 171
	public Color nightFog;

	// Token: 0x040000AC RID: 172
	private float desiredSunlight;

	// Token: 0x040000AD RID: 173
	private float desiredMoonlight;

	// Token: 0x040000AF RID: 175
	public AnimationCurve waterGraph;
}
