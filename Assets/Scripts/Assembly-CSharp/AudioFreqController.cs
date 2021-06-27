using System;
using UnityEngine;

public class AudioFreqController : MonoBehaviour
{
	private void Update()
	{
		if (!PlayerStatus.Instance)
		{
			return;
		}
		float num;
		if (PlayerStatus.Instance.hp <= 0f)
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
				num = 1f;
			}
			else
			{
				num = (float)num3 / ((float)num4 * num2);
			}
		}
		if (PlayerMovement.Instance.IsUnderWater())
		{
			num = 0.05f;
		}
		this.filter.cutoffFrequency = Mathf.Lerp(this.filter.cutoffFrequency, 22000f * num, Time.deltaTime * 8f);
	}

	public AudioLowPassFilter filter;
}
