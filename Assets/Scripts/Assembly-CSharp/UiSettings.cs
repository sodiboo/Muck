using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200012E RID: 302
public class UiSettings : MonoBehaviour
{
	// Token: 0x17000065 RID: 101
	// (get) Token: 0x060008B0 RID: 2224 RVA: 0x0002B56B File Offset: 0x0002976B
	// (set) Token: 0x060008B1 RID: 2225 RVA: 0x0002B573 File Offset: 0x00029773
	public int setting { get; private set; }

	// Token: 0x060008B2 RID: 2226 RVA: 0x0002B57C File Offset: 0x0002977C
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

	// Token: 0x060008B3 RID: 2227 RVA: 0x0002B614 File Offset: 0x00029814
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

	// Token: 0x060008B4 RID: 2228 RVA: 0x0002B665 File Offset: 0x00029865
	private void UpdateSetting(int i)
	{
		this.setting = i;
		this.UpdateSelection();
	}

	// Token: 0x0400083F RID: 2111
	public GameObject settingButton;

	// Token: 0x04000840 RID: 2112
	private TextMeshProUGUI[] texts;

	// Token: 0x04000841 RID: 2113
	private Color selected = Color.white;

	// Token: 0x04000842 RID: 2114
	private Color deselected = Color.gray;
}
