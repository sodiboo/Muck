
using TMPro;
using UnityEngine.UI;

// Token: 0x020000D3 RID: 211
public class ScrollSettings : Setting
{
	// Token: 0x06000653 RID: 1619 RVA: 0x00020113 File Offset: 0x0001E313
	public void SetSettings(string[] settings, int startVal)
	{
		this.settingNames = settings;
		this.currentSetting = startVal;
		this.UpdateSetting();
	}

	// Token: 0x06000654 RID: 1620 RVA: 0x00020129 File Offset: 0x0001E329
	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

	// Token: 0x06000655 RID: 1621 RVA: 0x00020140 File Offset: 0x0001E340
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

	// Token: 0x040005CF RID: 1487
	public TextMeshProUGUI settingText;

	// Token: 0x040005D0 RID: 1488
	private string[] settingNames;

	// Token: 0x040005D1 RID: 1489
	public RawImage scrollLeft;

	// Token: 0x040005D2 RID: 1490
	public RawImage scrollRight;
}
