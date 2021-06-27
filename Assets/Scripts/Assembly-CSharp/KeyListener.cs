using System;
using TMPro;
using UnityEngine;

public class KeyListener : MonoBehaviour
{
	private void Awake()
	{
		KeyListener.Instance = this;
		this.overlay.SetActive(false);
	}

	public void ListenForKey(ControlSetting listener, string actionName)
	{
		this.alertText.text = "Press any key for\n\"" + actionName + "\"\n\n<i><size=60%>...escape to go back";
		this.currentlyChanging = listener;
		this.overlay.SetActive(true);
	}

	private void Update()
	{
		if (!this.overlay.activeInHierarchy)
		{
			return;
		}
		MonoBehaviour.print("listenign");
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			this.CloseListener();
			return;
		}
		foreach (object obj in Enum.GetValues(typeof(KeyCode)))
		{
			KeyCode key = (KeyCode)obj;
			if (Input.GetKey(key))
			{
				this.currentlyChanging.SetKey(key);
				this.CloseListener();
				break;
			}
		}
	}

	private void CloseListener()
	{
		this.overlay.SetActive(false);
		this.currentlyChanging = null;
		UiSfx.Instance.PlayClick();
	}

	public ControlSetting currentlyChanging;

	public TextMeshProUGUI alertText;

	public GameObject overlay;

	public static KeyListener Instance;
}
