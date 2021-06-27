using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class UiSettings : MonoBehaviour
{
	public int setting { get; private set; }

	public void AddSettings(int defaultValue, string[] enumNames)
	{
		this.setting = defaultValue;
		this.texts = new TextMeshProUGUI[enumNames.Length];
		for (int i = 0; i < enumNames.Length; i++)
		{
			int index = i;
			Button component = Instantiate<GameObject>(this.settingButton, base.transform).GetComponent<Button>();
			component.onClick.AddListener(delegate()
			{
				this.UpdateSetting(index);
			});
			this.texts[i] = component.GetComponentInChildren<TextMeshProUGUI>();
			this.texts[i].text = enumNames[i];
		}
		this.UpdateSelection();
	}

	private void UpdateSelection()
	{
		for (int i = 0; i < this.texts.Length; i++)
		{
			if (i == this.setting)
			{
				this.texts[i].color = this.selected;
			}
			else
			{
				this.texts[i].color = this.deselected;
			}
		}
	}

	private void UpdateSetting(int i)
	{
		this.setting = i;
		this.UpdateSelection();
	}

	public GameObject settingButton;

	private TextMeshProUGUI[] texts;

	private Color selected = Color.white;

	private Color deselected = Color.gray;
}
