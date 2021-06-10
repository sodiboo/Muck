
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000063 RID: 99
public class ResolutionSetting : Setting
{
	// Token: 0x0600025E RID: 606 RVA: 0x0000D380 File Offset: 0x0000B580
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

	// Token: 0x0600025F RID: 607 RVA: 0x0000D3E3 File Offset: 0x0000B5E3
	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

	// Token: 0x06000260 RID: 608 RVA: 0x0000D3FC File Offset: 0x0000B5FC
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

	// Token: 0x06000261 RID: 609 RVA: 0x0000D493 File Offset: 0x0000B693
	private string ResolutionToText(Resolution r)
	{
		return r.ToString();
	}

	// Token: 0x06000262 RID: 610 RVA: 0x0000D4A4 File Offset: 0x0000B6A4
	public void ApplySetting()
	{
		Resolution resolution = this.resolutions[this.currentSetting];
		CurrentSettings.Instance.UpdateResolution(resolution.width, resolution.height, resolution.refreshRate);
	}

	// Token: 0x04000243 RID: 579
	public RawImage scrollLeft;

	// Token: 0x04000244 RID: 580
	public RawImage scrollRight;

	// Token: 0x04000245 RID: 581
	public TextMeshProUGUI settingText;

	// Token: 0x04000246 RID: 582
	private Resolution[] resolutions;
}
