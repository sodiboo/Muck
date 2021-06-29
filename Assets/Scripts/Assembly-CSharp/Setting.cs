using System;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;

public class Setting : MonoBehaviour
{
	public Setting.ButtonClickedEvent onClick
	{
		get
		{
			return this.m_OnClick;
		}
		set
		{
			this.m_OnClick = value;
		}
	}

	public int currentSetting;

	[FormerlySerializedAs("onClick")]
	[SerializeField]
	public Setting.ButtonClickedEvent m_OnClick = new Setting.ButtonClickedEvent();

	public class ButtonClickedEvent : UnityEvent
	{
	}

	protected string settingName;

	public TextMeshProUGUI nameText;

	public void SetName(string name) {
		settingName = name;
		nameText.text = name;
	}
}
