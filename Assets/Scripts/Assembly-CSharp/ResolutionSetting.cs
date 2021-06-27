using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ResolutionSetting : Setting
{
	public void SetSettings(Resolution[] resolutions, Resolution current)
	{
		this.resolutions = resolutions;
		for (int i = 0; i < resolutions.Length; i++)
		{
			if (current.width == resolutions[i].width && current.height == resolutions[i].height)
			{
				this.currentSetting = i;
				MonoBehaviour.print("found current res");
			}
		}
		this.UpdateSetting();
	}

	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

	private void UpdateSetting()
	{
		this.settingText.text = this.ResolutionToText(this.resolutions[this.currentSetting]);
		if (this.currentSetting == 0)
		{
			this.scrollLeft.enabled = false;
		}
		else if (this.currentSetting > 0)
		{
			this.scrollLeft.enabled = true;
		}
		if (this.currentSetting == this.resolutions.Length - 1)
		{
			this.scrollRight.enabled = false;
			return;
		}
		if (this.currentSetting < this.resolutions.Length - 1)
		{
			this.scrollRight.enabled = true;
		}
	}

	private string ResolutionToText(Resolution r)
	{
		return r.ToString();
	}

	public void ApplySetting()
	{
		Resolution resolution = this.resolutions[this.currentSetting];
		CurrentSettings.Instance.UpdateResolution(resolution.width, resolution.height, resolution.refreshRate);
	}

	public RawImage scrollLeft;

	public RawImage scrollRight;

	public TextMeshProUGUI settingText;

	private Resolution[] resolutions;
}
