using System;
using UnityEngine;

// Token: 0x0200006E RID: 110
public class MyBoolSetting : Setting
{
	// Token: 0x06000277 RID: 631 RVA: 0x0000E438 File Offset: 0x0000C638
	public void SetSetting(int s)
	{
		this.currentSetting = s;
		this.UpdateSetting();
	}

	// Token: 0x06000278 RID: 632 RVA: 0x0000E447 File Offset: 0x0000C647
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

	// Token: 0x06000279 RID: 633 RVA: 0x0000E462 File Offset: 0x0000C662
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

	// Token: 0x0600027A RID: 634 RVA: 0x0000E483 File Offset: 0x0000C683
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

	// Token: 0x04000293 RID: 659
	public GameObject checkMark;
}
