using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000085 RID: 133
public class ResolutionSetting : Setting
{
	// Token: 0x0600032C RID: 812 RVA: 0x00011690 File Offset: 0x0000F890
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

	// Token: 0x0600032D RID: 813 RVA: 0x000116F3 File Offset: 0x0000F8F3
	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

	// Token: 0x0600032E RID: 814 RVA: 0x0001170C File Offset: 0x0000F90C
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

	// Token: 0x0600032F RID: 815 RVA: 0x000117A3 File Offset: 0x0000F9A3
	private string ResolutionToText(Resolution r)
	{
		return r.ToString();
	}

	// Token: 0x06000330 RID: 816 RVA: 0x000117B4 File Offset: 0x0000F9B4
	public void ApplySetting()
	{
		Resolution resolution = this.resolutions[this.currentSetting];
		CurrentSettings.Instance.UpdateResolution(resolution.width, resolution.height, resolution.refreshRate);
	}

	// Token: 0x04000328 RID: 808
	public RawImage scrollLeft;

	// Token: 0x04000329 RID: 809
	public RawImage scrollRight;

	// Token: 0x0400032A RID: 810
	public TextMeshProUGUI settingText;

	// Token: 0x0400032B RID: 811
	private Resolution[] resolutions;
}
