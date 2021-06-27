using System;
using TMPro;
using UnityEngine.UI;

public class SliderSetting : Setting
{
	public void SetSettings(int startVal)
	{
		this.currentSetting = startVal;
		this.slider.value = (float)startVal;
		this.UpdateSettings();
	}

	public void UpdateSettings()
	{
		this.currentSetting = (int)this.slider.value;
		this.value.text = string.Concat(this.currentSetting);
		this.m_OnClick.Invoke();
	}

	public static float Truncate(float value, int digits)
	{
		double num = Math.Pow(10.0, (double)digits);
		return (float)(Math.Truncate(num * (double)value) / num);
	}

	public Slider slider;

	public TextMeshProUGUI value;
}
