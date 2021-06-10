using System;
using TMPro;
using UnityEngine.UI;

// Token: 0x020000E0 RID: 224
public class SliderSetting : Setting
{
	// Token: 0x060006A7 RID: 1703 RVA: 0x000217C9 File Offset: 0x0001F9C9
	public void SetSettings(int startVal)
	{
		this.currentSetting = startVal;
		this.slider.value = (float)startVal;
		this.UpdateSettings();
	}

	// Token: 0x060006A8 RID: 1704 RVA: 0x000217E5 File Offset: 0x0001F9E5
	public void UpdateSettings()
	{
		this.currentSetting = (int)this.slider.value;
		this.value.text = string.Concat(this.currentSetting);
		this.m_OnClick.Invoke();
	}

	// Token: 0x060006A9 RID: 1705 RVA: 0x00021820 File Offset: 0x0001FA20
	public static float Truncate(float value, int digits)
	{
		double num = Math.Pow(10.0, (double)digits);
		return (float)(Math.Truncate(num * (double)value) / num);
	}

	// Token: 0x0400064A RID: 1610
	public Slider slider;

	// Token: 0x0400064B RID: 1611
	public TextMeshProUGUI value;
}
