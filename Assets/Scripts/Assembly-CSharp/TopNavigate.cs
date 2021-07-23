using TMPro;
using UnityEngine;

public class TopNavigate : MonoBehaviour
{
    public GameObject[] settingMenus;

    public TextMeshProUGUI[] texts;

    public Color selectedColor;

    public Color idleColor;

    private void OnEnable()
    {
        Select(0);
    }

    public void Select(int selected)
    {
        for (int i = 0; i < settingMenus.Length; i++)
        {
            if (i == selected)
            {
                settingMenus[i].SetActive(value: true);
                texts[i].color = selectedColor;
            }
            else
            {
                settingMenus[i].SetActive(value: false);
                texts[i].color = idleColor;
            }
        }
    }
}
