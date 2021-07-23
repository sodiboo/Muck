using TMPro;
using UnityEngine;

public class ControlSetting : Setting
{
    public TextMeshProUGUI keyText;

    public KeyCode currentKey;

    private string actionName;

    public void SetSetting(KeyCode k, string actionName)
    {
        currentKey = k;
        MonoBehaviour.print("key: " + k);
        this.actionName = actionName;
        UpdateSetting();
    }

    private void UpdateSetting()
    {
        keyText.text = currentKey.ToString() ?? "";
    }

    public void SetKey(KeyCode k)
    {
        currentKey = k;
        base.onClick.Invoke();
        UpdateSetting();
    }

    public void StartListening()
    {
        KeyListener.Instance.ListenForKey(this, actionName);
    }
}
