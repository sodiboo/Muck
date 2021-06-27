using System;
using TMPro;
using UnityEngine.UI;

// Token: 0x0200010C RID: 268
public class SliderSetting : Setting
{
	// Token: 0x060007E2 RID: 2018 RVA: 0x00027E0D File Offset: 0x0002600D
	public void SetSettings(int startVal)
	{
		this.currentSetting = startVal;
		this.slider.value = (float)startVal;
		this.UpdateSettings();
	}

	// Token: 0x060007E3 RID: 2019 RVA: 0x00027E29 File Offset: 0x00026029
	public void UpdateSettings()
	{
		this.currentSetting = (int)this.slider.value;
		this.value.text = string.Concat(this.currentSetting);
		this.m_OnClick.Invoke();
	}

	// Token: 0x060007E4 RID: 2020 RVA: 0x00027E64 File Offset: 0x00026064
	public static float Truncate(float value, int digits)
	{
		double num = Math.Pow(10.0, (double)digits);
		return (float)(Math.Truncate(num * (double)value) / num);
	}

	// Token: 0x04000785 RID: 1925
	public Slider slider;

	// Token: 0x04000786 RID: 1926
	public TextMeshProUGUI value;
}
