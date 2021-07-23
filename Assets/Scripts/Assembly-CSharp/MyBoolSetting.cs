using UnityEngine;

public class MyBoolSetting : Setting
{
    public GameObject checkMark;

    public void SetSetting(int s)
    {
        currentSetting = s;
        UpdateSetting();
    }

    public void SetSetting(bool s)
    {
        if (s)
        {
            currentSetting = 1;
        }
        else
        {
            currentSetting = 0;
        }
        UpdateSetting();
    }

    public void ToggleSetting()
    {
        if (currentSetting == 1)
        {
            currentSetting = 0;
        }
        else
        {
            currentSetting = 1;
        }
        UpdateSetting();
    }

    private void UpdateSetting()
    {
        if (currentSetting == 1)
        {
            checkMark.SetActive(value: true);
        }
        else
        {
            checkMark.SetActive(value: false);
        }
        m_OnClick.Invoke();
    }
}
