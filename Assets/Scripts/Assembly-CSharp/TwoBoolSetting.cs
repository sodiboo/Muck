using System;
using TMPro;
using UnityEngine;

public class TwoBoolSetting : Setting
{
    public void SetSetting(int s)
    {
        this.currentSetting = s;
        this.UpdateSetting();
    }

    public void SetSetting(bool a, bool b)
    {
        currentSetting = (a ? 1 : 0) | (b ? 2 : 0);
        this.UpdateSetting();
    }

    public void ToggleSetting(int bit) {
		currentSetting ^= 1 << bit;
		this.UpdateSetting();
    }

    public void SetLabels(string first, string second) {
        label1.text = first;
        label2.text = second;
    }

    private void UpdateSetting()
    {
        this.checkMark1.SetActive((this.currentSetting & 1) != 0);
        this.checkMark2.SetActive((this.currentSetting & 2) != 0);
        this.m_OnClick.Invoke();
    }

    public GameObject checkMark1;
    public GameObject checkMark2;

    public TextMeshProUGUI label1;
    public TextMeshProUGUI label2;
}
