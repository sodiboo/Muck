using System;
using UnityEngine;

// Token: 0x02000023 RID: 35
public class DayCycle : MonoBehaviour
{
	// Token: 0x060000D7 RID: 215 RVA: 0x00005F54 File Offset: 0x00004154
	private void Awake()
	{
		this.sky.mainTextureOffset = new Vector2(0.5f, 0f);
		this.waterColor = this.water.material.GetColor("_ShallowColor");
		this.waterShallowColor = this.water.material.GetColor("_DeepColor");
		DayCycle.time = 0f;
		DayCycle.totalTime = 0f;
	}

	// Token: 0x1700000B RID: 11
	// (get) Token: 0x060000D8 RID: 216 RVA: 0x00005FC5 File Offset: 0x000041C5
	// (set) Token: 0x060000D9 RID: 217 RVA: 0x00005FCC File Offset: 0x000041CC
	public static float totalTime { get; private set; }

	// Token: 0x060000DA RID: 218 RVA: 0x00005FD4 File Offset: 0x000041D4
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
		Color fogColor = Color.Lerp(this.dayFog, this.nightFog, num3);
		if (MoveCamera.Instance != null && MoveCamera.Instance.transform.position.y < World.Instance.water.position.y)
		{
			RenderSettings.fogDensity = 0.015f;
			fogColor = this.waterFog;
		}
		else
		{
			RenderSettings.fogDensity = 0.0035f;
		}
		RenderSettings.fogColor = fogColor;
		this.skybox.SetFloat("_Exposure", 1f - num3);
		float num4 = 0.75f - num3 * 0.5f;
		Color b = new Color(num4, num4, num4);
		RenderSettings.ambientSkyColor = Color.Lerp(RenderSettings.ambientSkyColor, b, Time.deltaTime * 0.5f);
		Color value = this.waterColor * (1f - num3) + Color.black * num3;
		Color value2 = this.waterShallowColor * (1f - num3) + Color.black * num3;
		this.water.material.SetColor("_ShallowColor", value);
		this.water.material.SetColor("_DeepColor", value2);
	}

	// Token: 0x060000DB RID: 219 RVA: 0x000061F0 File Offset: 0x000043F0
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

	// Token: 0x060000DC RID: 220 RVA: 0x000062F1 File Offset: 0x000044F1
	private float EvaluateWaterColor(float x)
	{
		return this.waterGraph.Evaluate(x);
	}

	// Token: 0x040000D3 RID: 211
	public bool alwaysDay;

	// Token: 0x040000D4 RID: 212
	public static float dayDuration = 1f;

	// Token: 0x040000D5 RID: 213
	public float nightDuration = 0.5f;

	// Token: 0x040000D6 RID: 214
	public float timeSpeed = 0.01f;

	// Token: 0x040000D7 RID: 215
	public static float time;

	// Token: 0x040000D8 RID: 216
	public Transform sun;

	// Token: 0x040000D9 RID: 217
	public Material sky;

	// Token: 0x040000DA RID: 218
	public float skyOffset;

	// Token: 0x040000DB RID: 219
	public MeshRenderer water;

	// Token: 0x040000DC RID: 220
	public Color waterColor;

	// Token: 0x040000DD RID: 221
	public Color waterShallowColor;

	// Token: 0x040000DE RID: 222
	public Material skybox;

	// Token: 0x040000DF RID: 223
	public Light sunLight;

	// Token: 0x040000E0 RID: 224
	public Light moonLight;

	// Token: 0x040000E1 RID: 225
	public Color dayFog;

	// Token: 0x040000E2 RID: 226
	public Color nightFog;

	// Token: 0x040000E3 RID: 227
	public Color waterFog;

	// Token: 0x040000E4 RID: 228
	private float desiredSunlight;

	// Token: 0x040000E5 RID: 229
	private float desiredMoonlight;

	// Token: 0x040000E7 RID: 231
	public AnimationCurve waterGraph;
}
