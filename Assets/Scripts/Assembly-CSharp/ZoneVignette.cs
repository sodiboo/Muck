using System;
using UnityEngine;
using UnityEngine.UI;

public class ZoneVignette : MonoBehaviour
{
	private void Awake()
	{
		ZoneVignette.Instance = this;
		this.img = base.GetComponent<RawImage>();
		this.img.CrossFadeAlpha(0f, 0f, true);
		Color color = this.img.color;
		color.a = 0.8f;
		this.img.color = color;
	}

	public void SetVignette(bool on)
	{
		if (on)
		{
			this.img.CrossFadeAlpha(0.8f, 3f, true);
			this.desiredScale = Vector3.one * 1.6f;
			return;
		}
		this.img.CrossFadeAlpha(0f, 2f, true);
		this.desiredScale = Vector3.one * 1f;
	}

	private void Update()
	{
		base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.desiredScale, Time.deltaTime * 0.2f);
	}

	private float intensity;

	private RawImage img;

	public static ZoneVignette Instance;

	private Vector3 desiredScale = Vector3.one;
}
