using System;
using UnityEngine;
using UnityEngine.UI;

public class FadeScreen : MonoBehaviour
{
	private void Awake()
	{
		FadeScreen.Instance = this;
		this.blackImg.CrossFadeAlpha(0f, 0f, true);
		this.blackImg.gameObject.SetActive(true);
	}

	public void StartFade(float alpha, float duration)
	{
		this.blackImg.CrossFadeAlpha(alpha, duration, true);
	}

	public RawImage blackImg;

	public static FadeScreen Instance;
}
