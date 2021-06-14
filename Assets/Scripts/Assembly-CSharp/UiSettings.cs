using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000153 RID: 339
public class UiSettings : MonoBehaviour
{
	// Token: 0x1700005E RID: 94
	// (get) Token: 0x06000826 RID: 2086 RVA: 0x00007567 File Offset: 0x00005767
	// (set) Token: 0x06000827 RID: 2087 RVA: 0x0000756F File Offset: 0x0000576F
	public int setting { get; private set; }

	// Token: 0x06000828 RID: 2088 RVA: 0x00027DF4 File Offset: 0x00025FF4
	public void AddSettings(int defaultValue, string[] enumNames)
	{
		this.setting = defaultValue;
		this.texts = new TextMeshProUGUI[enumNames.Length];
		for (int i = 0; i < enumNames.Length; i++)
		{
			int index = i;
			Button component =Instantiate<GameObject>(this.settingButton, base.transform).GetComponent<Button>();
			component.onClick.AddListener(delegate()
			{
				this.UpdateSetting(index);
			});
			this.texts[i] = component.GetComponentInChildren<TextMeshProUGUI>();
			this.texts[i].text = enumNames[i];
		}
		this.UpdateSelection();
	}

	// Token: 0x06000829 RID: 2089 RVA: 0x00027E8C File Offset: 0x0002608C
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

	// Token: 0x0600082A RID: 2090 RVA: 0x00007578 File Offset: 0x00005778
	private void UpdateSetting(int i)
	{
		this.setting = i;
		this.UpdateSelection();
	}

	// Token: 0x04000868 RID: 2152
	public GameObject settingButton;

	// Token: 0x04000869 RID: 2153
	private TextMeshProUGUI[] texts;

	// Token: 0x0400086A RID: 2154
	private Color selected = Color.white;

	// Token: 0x0400086B RID: 2155
	private Color deselected = Color.gray;
}
