using UnityEngine;

public class DayCycle : MonoBehaviour
{
    public bool alwaysDay;

    public static float dayDuration = 1f;

    public float nightDuration = 0.5f;

    public float timeSpeed = 0.01f;

    public static float time;

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

    public static float totalTime { get; private set; }

    private void Awake()
    {
        sky.mainTextureOffset = new Vector2(0.5f, 0f);
        waterColor = water.material.GetColor("_ShallowColor");
        waterShallowColor = water.material.GetColor("_DeepColor");
        time = 0f;
        totalTime = 0f;
    }

    private void Update()
    {
        if (GameManager.state == GameManager.GameState.Playing)
        {
            float num = 1f * timeSpeed / dayDuration;
            if (time > 0.5f)
            {
                num /= nightDuration;
            }
            float num2 = num * Time.deltaTime;
            time += num2;
            time %= 1f;
            totalTime += num2;
            if (alwaysDay)
            {
                time = 0.25f;
            }
            sun.rotation = Quaternion.Euler(new Vector3(time * 360f, 0f, 0f));
            sky.mainTextureOffset = new Vector2(time - 0.25f, 0f);
            SunLight();
            float num3 = EvaluateWaterColor((time + 0.75f) % 1f);
            Color fogColor = Color.Lerp(dayFog, nightFog, num3);
            if (MoveCamera.Instance != null && MoveCamera.Instance.transform.position.y < World.Instance.water.position.y)
            {
                RenderSettings.fogDensity = 0.015f;
                fogColor = waterFog;
            }
            else
            {
                RenderSettings.fogDensity = 0.0035f;
            }
            RenderSettings.fogColor = fogColor;
            skybox.SetFloat("_Exposure", 1f - num3);
            float num4 = 0.75f - num3 * 0.5f;
            RenderSettings.ambientSkyColor = Color.Lerp(b: new Color(num4, num4, num4), a: RenderSettings.ambientSkyColor, t: Time.deltaTime * 0.5f);
            Color value = waterColor * (1f - num3) + Color.black * num3;
            Color value2 = waterShallowColor * (1f - num3) + Color.black * num3;
            water.material.SetColor("_ShallowColor", value);
            water.material.SetColor("_DeepColor", value2);
        }
    }

    private void SunLight()
    {
        if (time > 0.5f)
        {
            desiredSunlight = 0f;
        }
        else if (time < 0.5f && moonLight.intensity < 0.05f)
        {
            desiredSunlight = 0.6f;
        }
        if (sunLight.intensity < 0.05f && time > 0.5f && time < 0.75f)
        {
            desiredMoonlight = 0.6f;
        }
        else if (time > 0.97f || time < 0.5f)
        {
            desiredMoonlight = 0f;
        }
        sunLight.intensity = Mathf.Lerp(sunLight.intensity, desiredSunlight, Time.deltaTime * 1f);
        moonLight.intensity = Mathf.Lerp(moonLight.intensity, desiredMoonlight, Time.deltaTime * 1f);
    }

    private float EvaluateWaterColor(float x)
    {
        return waterGraph.Evaluate(x);
    }
}
