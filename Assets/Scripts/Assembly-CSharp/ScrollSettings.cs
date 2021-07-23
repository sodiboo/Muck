using TMPro;
using UnityEngine.UI;

public class ScrollSettings : Setting
{
    public TextMeshProUGUI settingText;

    private string[] settingNames;

    public RawImage scrollLeft;

    public RawImage scrollRight;

    public void SetSettings(string[] settings, int startVal)
    {
        settingNames = settings;
        currentSetting = startVal;
        UpdateSetting();
    }

    public void Scroll(int i)
    {
        currentSetting += i;
        UpdateSetting();
    }

    private void UpdateSetting()
    {
        settingText.text = settingNames[currentSetting];
        if (currentSetting == 0)
        {
            scrollLeft.enabled = false;
        }
        else if (currentSetting > 0)
        {
            scrollLeft.enabled = true;
        }
        if (currentSetting == settingNames.Length - 1)
        {
            scrollRight.enabled = false;
        }
        else if (currentSetting < settingNames.Length - 1)
        {
            scrollRight.enabled = true;
        }
        m_OnClick.Invoke();
    }
}
