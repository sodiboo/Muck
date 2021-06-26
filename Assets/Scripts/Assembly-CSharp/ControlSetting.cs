using System;
using TMPro;
using UnityEngine;


public class ControlSetting : Setting
{

	public void SetSetting(KeyCode k, string actionName)
	{
		this.currentKey = k;
		MonoBehaviour.print("key: " + k);
		this.actionName = actionName;
		actionText.text = actionName;
		this.UpdateSetting();
	}


	private void UpdateSetting()
	{
		this.keyText.text = (this.currentKey.ToString() ?? "");
	}


	public void SetKey(KeyCode k)
	{
		this.currentKey = k;
		base.onClick.Invoke();
		this.UpdateSetting();
	}


	public void StartListening()
	{
		KeyListener.Instance.ListenForKey(this, this.actionName);
	}

	public TextMeshProUGUI actionText;

	public TextMeshProUGUI keyText;


	public KeyCode currentKey;


	private string actionName;
}
