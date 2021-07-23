using System;
using TMPro;
using UnityEngine.UI;

public class SliderSetting : Setting
{
    public Slider slider;

    public TextMeshProUGUI value;

    public void SetSettings(int startVal)
    {
        currentSetting = startVal;
        slider.value = startVal;
        UpdateSettings();
    }

    public void UpdateSettings()
    {
        currentSetting = (int)slider.value;
        value.text = string.Concat(currentSetting);
        m_OnClick.Invoke();
    }

    public static float Truncate(float value, int digits)
    {
        double num = Math.Pow(10.0, digits);
        return (float)(Math.Truncate(num * (double)value) / num);
    }
}
