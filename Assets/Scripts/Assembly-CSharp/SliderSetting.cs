using System;
using TMPro;
using UnityEngine.UI;

// Token: 0x0200012C RID: 300
public class SliderSetting : Setting
{
	// Token: 0x06000754 RID: 1876 RVA: 0x00006D39 File Offset: 0x00004F39
	public void SetSettings(int startVal)
	{
		this.currentSetting = startVal;
		this.slider.value = (float)startVal;
		this.UpdateSettings();
	}

	// Token: 0x06000755 RID: 1877 RVA: 0x00006D55 File Offset: 0x00004F55
	public void UpdateSettings()
	{
		this.currentSetting = (int)this.slider.value;
		this.value.text = string.Concat(this.currentSetting);
		this.m_OnClick.Invoke();
	}

	// Token: 0x06000756 RID: 1878 RVA: 0x00024B60 File Offset: 0x00022D60
	public static float Truncate(float value, int digits)
	{
		double num = Math.Pow(10.0, (double)digits);
		return (float)(Math.Truncate(num * (double)value) / num);
	}

	// Token: 0x04000795 RID: 1941
	public Slider slider;

	// Token: 0x04000796 RID: 1942
	public TextMeshProUGUI value;
}
