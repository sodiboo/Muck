using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class UiSettings : MonoBehaviour
{
    public GameObject settingButton;

    private TextMeshProUGUI[] texts;

    private Color selected = Color.white;

    private Color deselected = Color.gray;

    public int setting { get; private set; }

    public void AddSettings(int defaultValue, string[] enumNames)
    {
        setting = defaultValue;
        texts = new TextMeshProUGUI[enumNames.Length];
        for (int i = 0; i < enumNames.Length; i++)
        {
            int index = i;
            Button component = Object.Instantiate(settingButton, base.transform).GetComponent<Button>();
            component.onClick.AddListener(delegate
            {
                UpdateSetting(index);
            });
            texts[i] = component.GetComponentInChildren<TextMeshProUGUI>();
            texts[i].text = enumNames[i];
        }
        UpdateSelection();
    }

    private void UpdateSelection()
    {
        for (int i = 0; i < texts.Length; i++)
        {
            if (i == setting)
            {
                texts[i].color = selected;
            }
            else
            {
                texts[i].color = deselected;
            }
        }
    }

    private void UpdateSetting(int i)
    {
        setting = i;
        UpdateSelection();
    }
}
