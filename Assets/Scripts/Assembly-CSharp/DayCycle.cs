using System;
using UnityEngine;

public class DayCycle : MonoBehaviour
{
	private static DayCycle Instance;

	private void Awake()
	{
		Instance = this;
		this.sky.mainTextureOffset = new Vector2(0.5f, 0f);
		this.waterColor = this.water.material.GetColor("_ShallowColor");
		this.waterShallowColor = this.water.material.GetColor("_DeepColor");
		DayCycle.totalTime = 0f;
	}

	public static float totalTime { get; set; }

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
		DayCycle.totalTime += num2;
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

	private float EvaluateWaterColor(float x)
	{
		return this.waterGraph.Evaluate(x);
	}

	public bool alwaysDay;

	public static float dayDuration = 1f;

	public float nightDuration = 0.5f;

	public float timeSpeed = 0.01f;

	public static float time => Instance.alwaysDay ? 0.25f : totalTime % 1f ;

	public Transform sun;

	public Material sky;

	public float skyOffset;

	public MeshRenderer water;

	public Color waterColor;

	public Color waterShallowColor;

	public Material skybox;

	public Light sunLight;

	public Light moonLight;

	public Color dayFog;

	public Color nightFog;

	public Color waterFog;

	private float desiredSunlight;

	private float desiredMoonlight;

	public AnimationCurve waterGraph;
}
