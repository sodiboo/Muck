using System;
using UnityEngine;

// Token: 0x02000060 RID: 96
public class MyBoolSetting : Setting
{
	// Token: 0x060001F4 RID: 500 RVA: 0x00003806 File Offset: 0x00001A06
	public void SetSetting(int s)
	{
		this.currentSetting = s;
		this.UpdateSetting();
	}

	// Token: 0x060001F5 RID: 501 RVA: 0x00003815 File Offset: 0x00001A15
	public void SetSetting(bool s)
	{
		if (s)
		{
			this.currentSetting = 1;
		}
		else
		{
			this.currentSetting = 0;
		}
		this.UpdateSetting();
	}

	// Token: 0x060001F6 RID: 502 RVA: 0x00003830 File Offset: 0x00001A30
	public void ToggleSetting()
	{
		if (this.currentSetting == 1)
		{
			this.currentSetting = 0;
		}
		else
		{
			this.currentSetting = 1;
		}
		this.UpdateSetting();
	}

	// Token: 0x060001F7 RID: 503 RVA: 0x00003851 File Offset: 0x00001A51
	private void UpdateSetting()
	{
		if (this.currentSetting == 1)
		{
			this.checkMark.SetActive(true);
		}
		else
		{
			this.checkMark.SetActive(false);
		}
		this.m_OnClick.Invoke();
	}

	// Token: 0x0400020E RID: 526
	public GameObject checkMark;
}
