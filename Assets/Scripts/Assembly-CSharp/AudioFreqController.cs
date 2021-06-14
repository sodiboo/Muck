using System;
using UnityEngine;

// Token: 0x02000004 RID: 4
public class AudioFreqController : MonoBehaviour
{
	// Token: 0x0600000E RID: 14 RVA: 0x00007A70 File Offset: 0x00005C70
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
		this.filter.cutoffFrequency = Mathf.Lerp(this.filter.cutoffFrequency, 22000f * num, Time.deltaTime * 8f);
	}

	// Token: 0x0400000C RID: 12
	public AudioLowPassFilter filter;
}
