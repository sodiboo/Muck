using System;
using TMPro;
using UnityEngine;

public class KeyListener : MonoBehaviour
{
    public ControlSetting currentlyChanging;

    public TextMeshProUGUI alertText;

    public GameObject overlay;

    public static KeyListener Instance;

    private void Awake()
    {
        Instance = this;
        overlay.SetActive(value: false);
    }

    public void ListenForKey(ControlSetting listener, string actionName)
    {
        alertText.text = "Press any key for\n\"" + actionName + "\"\n\n<i><size=60%>...escape to go back";
        currentlyChanging = listener;
        overlay.SetActive(value: true);
    }

    private void Update()
    {
        if (!overlay.activeInHierarchy)
        {
            return;
        }
        MonoBehaviour.print("listenign");
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            CloseListener();
            return;
        }
        foreach (KeyCode value in Enum.GetValues(typeof(KeyCode)))
        {
            if (Input.GetKey(value))
            {
                currentlyChanging.SetKey(value);
                CloseListener();
                break;
            }
        }
    }

    private void CloseListener()
    {
        overlay.SetActive(value: false);
        currentlyChanging = null;
        UiSfx.Instance.PlayClick();
    }
}
