using System;
using TMPro;
using UnityEngine.UI;

// Token: 0x020000FB RID: 251
public class ScrollSettings : Setting
{
	// Token: 0x0600076D RID: 1901 RVA: 0x000261F3 File Offset: 0x000243F3
	public void SetSettings(string[] settings, int startVal)
	{
		this.settingNames = settings;
		this.currentSetting = startVal;
		this.UpdateSetting();
	}

	// Token: 0x0600076E RID: 1902 RVA: 0x00026209 File Offset: 0x00024409
	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

	// Token: 0x0600076F RID: 1903 RVA: 0x00026220 File Offset: 0x00024420
	private void UpdateSetting()
	{
		this.settingText.text = this.settingNames[this.currentSetting];
		if (this.currentSetting == 0)
		{
			this.scrollLeft.enabled = false;
		}
		else if (this.currentSetting > 0)
		{
			this.scrollLeft.enabled = true;
		}
		if (this.currentSetting == this.settingNames.Length - 1)
		{
			this.scrollRight.enabled = false;
		}
		else if (this.currentSetting < this.settingNames.Length - 1)
		{
			this.scrollRight.enabled = true;
		}
		this.m_OnClick.Invoke();
	}

	// Token: 0x040006F5 RID: 1781
	public TextMeshProUGUI settingText;

	// Token: 0x040006F6 RID: 1782
	private string[] settingNames;

	// Token: 0x040006F7 RID: 1783
	public RawImage scrollLeft;

	// Token: 0x040006F8 RID: 1784
	public RawImage scrollRight;
}
