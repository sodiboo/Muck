using System;
using TMPro;
using UnityEngine.UI;

// Token: 0x02000114 RID: 276
public class ScrollSettings : Setting
{
	// Token: 0x060006EF RID: 1775 RVA: 0x00006673 File Offset: 0x00004873
	public void SetSettings(string[] settings, int startVal)
	{
		this.settingNames = settings;
		this.currentSetting = startVal;
		this.UpdateSetting();
	}

	// Token: 0x060006F0 RID: 1776 RVA: 0x00006689 File Offset: 0x00004889
	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

	// Token: 0x060006F1 RID: 1777 RVA: 0x000238FC File Offset: 0x00021AFC
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

	// Token: 0x040006ED RID: 1773
	public TextMeshProUGUI settingText;

	// Token: 0x040006EE RID: 1774
	private string[] settingNames;

	// Token: 0x040006EF RID: 1775
	public RawImage scrollLeft;

	// Token: 0x040006F0 RID: 1776
	public RawImage scrollRight;
}
