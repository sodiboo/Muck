
using UnityEngine;

// Token: 0x02000019 RID: 25
public class DayCycle : MonoBehaviour
{
	// Token: 0x06000099 RID: 153 RVA: 0x00005014 File Offset: 0x00003214
	private void Awake()
	{
		this.sky.mainTextureOffset = new Vector2(0.5f, 0f);
		this.waterColor = this.water.material.GetColor("_ShallowColor");
		this.waterShallowColor = this.water.material.GetColor("_DeepColor");
		DayCycle.time = 0f;
		DayCycle.totalTime = 0f;
	}

	// Token: 0x17000005 RID: 5
	// (get) Token: 0x0600009A RID: 154 RVA: 0x00005085 File Offset: 0x00003285
	// (set) Token: 0x0600009B RID: 155 RVA: 0x0000508C File Offset: 0x0000328C
	public static float totalTime { get; private set; }

	// Token: 0x0600009C RID: 156 RVA: 0x00005094 File Offset: 0x00003294
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

	// Token: 0x0600009D RID: 157 RVA: 0x00005254 File Offset: 0x00003454
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

	// Token: 0x0600009E RID: 158 RVA: 0x00005355 File Offset: 0x00003555
	private float EvaluateWaterColor(float x)
	{
		return this.waterGraph.Evaluate(x);
	}

	// Token: 0x04000088 RID: 136
	public bool alwaysDay;

	// Token: 0x04000089 RID: 137
	public static float dayDuration = 1f;

	// Token: 0x0400008A RID: 138
	public float nightDuration = 0.5f;

	// Token: 0x0400008B RID: 139
	public float timeSpeed = 0.01f;

	// Token: 0x0400008C RID: 140
	public static float time;

	// Token: 0x0400008D RID: 141
	public Transform sun;

	// Token: 0x0400008E RID: 142
	public Material sky;

	// Token: 0x0400008F RID: 143
	public float skyOffset;

	// Token: 0x04000090 RID: 144
	public MeshRenderer water;

	// Token: 0x04000091 RID: 145
	public Color waterColor;

	// Token: 0x04000092 RID: 146
	public Color waterShallowColor;

	// Token: 0x04000093 RID: 147
	public Material skybox;

	// Token: 0x04000094 RID: 148
	public Light sunLight;

	// Token: 0x04000095 RID: 149
	public Light moonLight;

	// Token: 0x04000096 RID: 150
	public Color dayFog;

	// Token: 0x04000097 RID: 151
	public Color nightFog;

	// Token: 0x04000098 RID: 152
	private float desiredSunlight;

	// Token: 0x04000099 RID: 153
	private float desiredMoonlight;

	// Token: 0x0400009B RID: 155
	public AnimationCurve waterGraph;
}
