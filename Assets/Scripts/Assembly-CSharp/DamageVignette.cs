using System;
using UnityEngine;
using UnityEngine.UI;

public class DamageVignette : MonoBehaviour
{
	private void Awake()
	{
		DamageVignette.Instance = this;
	}

	private void Update()
	{
		if (!PlayerStatus.Instance)
		{
			return;
		}
		float num;
		if (MoveCamera.Instance && MoveCamera.Instance.state == MoveCamera.CameraState.Spectate)
		{
			num = 0f;
		}
		else if (PlayerStatus.Instance.hp <= 0f)
		{
			num = 1f;
		}
		else
		{
			float num2 = 0.75f;
			int num3 = PlayerStatus.Instance.HpAndShield();
			int num4 = PlayerStatus.Instance.MaxHpAndShield();
			num = (float)num3 / (float)num4;
			if (num > num2)
			{
				num = 0f;
			}
			else
			{
				num = 1f - (float)num3 / ((float)num4 * num2);
			}
		}
		Color color = this.vignette.color;
		color.a = num;
		this.vignette.color = Color.Lerp(this.vignette.color, color, Time.deltaTime * 12f);
	}

	public void VignetteHit()
	{
		Color color = this.vignette.color;
		color.a += 0.8f;
		this.vignette.color = color;
	}

	public RawImage vignette;

	public static DamageVignette Instance;
}
