
using UnityEngine;

// Token: 0x02000051 RID: 81
public class MyBoolSetting : Setting
{
	// Token: 0x060001CB RID: 459 RVA: 0x0000AB74 File Offset: 0x00008D74
	public void SetSetting(int s)
	{
		this.currentSetting = s;
		this.UpdateSetting();
	}

	// Token: 0x060001CC RID: 460 RVA: 0x0000AB83 File Offset: 0x00008D83
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

	// Token: 0x060001CD RID: 461 RVA: 0x0000AB9E File Offset: 0x00008D9E
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

	// Token: 0x060001CE RID: 462 RVA: 0x0000ABBF File Offset: 0x00008DBF
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

	// Token: 0x040001CE RID: 462
	public GameObject checkMark;
}
