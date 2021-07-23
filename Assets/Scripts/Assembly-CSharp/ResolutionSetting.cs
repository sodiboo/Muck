using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ResolutionSetting : Setting
{
    public RawImage scrollLeft;

    public RawImage scrollRight;

    public TextMeshProUGUI settingText;

    private Resolution[] resolutions;

    public void SetSettings(Resolution[] resolutions, Resolution current)
    {
        this.resolutions = resolutions;
        for (int i = 0; i < resolutions.Length; i++)
        {
            if (current.width == resolutions[i].width && current.height == resolutions[i].height)
            {
                currentSetting = i;
                MonoBehaviour.print("found current res");
            }
        }
        UpdateSetting();
    }

    public void Scroll(int i)
    {
        currentSetting += i;
        UpdateSetting();
    }

    private void UpdateSetting()
    {
        settingText.text = ResolutionToText(resolutions[currentSetting]);
        if (currentSetting == 0)
        {
            scrollLeft.enabled = false;
        }
        else if (currentSetting > 0)
        {
            scrollLeft.enabled = true;
        }
        if (currentSetting == resolutions.Length - 1)
        {
            scrollRight.enabled = false;
        }
        else if (currentSetting < resolutions.Length - 1)
        {
            scrollRight.enabled = true;
        }
    }

    private string ResolutionToText(Resolution r)
    {
        return r.ToString();
    }

    public void ApplySetting()
    {
        Resolution resolution = resolutions[currentSetting];
        CurrentSettings.Instance.UpdateResolution(resolution.width, resolution.height, resolution.refreshRate);
    }
}
