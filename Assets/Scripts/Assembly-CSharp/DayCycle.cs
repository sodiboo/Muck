using UnityEngine;

public class DayCycle : MonoBehaviour
{
	public bool alwaysDay;
	public float nightDuration;
	public float timeSpeed;
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
	public AnimationCurve waterGraph;
}
