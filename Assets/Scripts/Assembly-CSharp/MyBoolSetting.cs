using System;
using UnityEngine;

public class MyBoolSetting : Setting
{
	public void SetSetting(int s)
	{
		this.currentSetting = s;
		this.UpdateSetting();
	}

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

	public GameObject checkMark;
}
