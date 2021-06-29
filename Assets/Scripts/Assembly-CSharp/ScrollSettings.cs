using TMPro;
using UnityEngine.UI;

public class ScrollSettings : Setting
{
	public void SetSettings(string[] settings, int startVal)
	{
		this.settingNames = settings;
		this.currentSetting = startVal;
		this.UpdateSetting();
	}

	public void Scroll(int i)
	{
		this.currentSetting += i;
		this.UpdateSetting();
	}

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

	public TextMeshProUGUI settingText;

	private string[] settingNames;

	public RawImage scrollLeft;

	public RawImage scrollRight;
}
