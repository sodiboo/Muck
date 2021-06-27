using System;
using TMPro;
using UnityEngine;

public class TopNavigate : MonoBehaviour
{
	private void OnEnable()
	{
		this.Select(0);
	}

	public void Select(int selected)
	{
		for (int i = 0; i < this.settingMenus.Length; i++)
		{
			if (i == selected)
			{
				this.settingMenus[i].SetActive(true);
				this.texts[i].color = this.selectedColor;
			}
			else
			{
				this.settingMenus[i].SetActive(false);
				this.texts[i].color = this.idleColor;
			}
		}
	}

	public GameObject[] settingMenus;

	public TextMeshProUGUI[] texts;

	public Color selectedColor;

	public Color idleColor;
}
