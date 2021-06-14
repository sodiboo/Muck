using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000077 RID: 119
public class ResolutionSetting : Setting
{
	// Token: 0x06000293 RID: 659 RVA: 0x000117CC File Offset: 0x0000F9CC
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

	// Token: 0x06000294 RID: 660 RVA: 0x00003E5B File Offset: 0x0000205B
	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

	// Token: 0x06000295 RID: 661 RVA: 0x00011830 File Offset: 0x0000FA30
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

	// Token: 0x06000296 RID: 662 RVA: 0x00003E71 File Offset: 0x00002071
	private string ResolutionToText(Resolution r)
	{
		return r.ToString();
	}

	// Token: 0x06000297 RID: 663 RVA: 0x000118C8 File Offset: 0x0000FAC8
	public void ApplySetting()
	{
		Resolution resolution = this.resolutions[this.currentSetting];
		CurrentSettings.Instance.UpdateResolution(resolution.width, resolution.height, resolution.refreshRate);
	}

	// Token: 0x0400029E RID: 670
	public RawImage scrollLeft;

	// Token: 0x0400029F RID: 671
	public RawImage scrollRight;

	// Token: 0x040002A0 RID: 672
	public TextMeshProUGUI settingText;

	// Token: 0x040002A1 RID: 673
	private Resolution[] resolutions;
}
