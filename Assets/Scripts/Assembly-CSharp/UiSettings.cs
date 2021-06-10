
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000FD RID: 253
public class UiSettings : MonoBehaviour
{
	// Token: 0x17000055 RID: 85
	// (get) Token: 0x06000769 RID: 1897 RVA: 0x00024C4B File Offset: 0x00022E4B
	// (set) Token: 0x0600076A RID: 1898 RVA: 0x00024C53 File Offset: 0x00022E53
	public int setting { get; private set; }

	// Token: 0x0600076B RID: 1899 RVA: 0x00024C5C File Offset: 0x00022E5C
	public void AddSettings(int defaultValue, string[] enumNames)
	{
		this.setting = defaultValue;
		this.texts = new TextMeshProUGUI[enumNames.Length];
		for (int i = 0; i < enumNames.Length; i++)
		{
			int index = i;
			Button component =Instantiate(this.settingButton, base.transform).GetComponent<Button>();
			component.onClick.AddListener(delegate()
			{
				this.UpdateSetting(index);
			});
			this.texts[i] = component.GetComponentInChildren<TextMeshProUGUI>();
			this.texts[i].text = enumNames[i];
		}
		this.UpdateSelection();
	}

	// Token: 0x0600076C RID: 1900 RVA: 0x00024CF4 File Offset: 0x00022EF4
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

	// Token: 0x0600076D RID: 1901 RVA: 0x00024D45 File Offset: 0x00022F45
	private void UpdateSetting(int i)
	{
		this.setting = i;
		this.UpdateSelection();
	}

	// Token: 0x040006F7 RID: 1783
	public GameObject settingButton;

	// Token: 0x040006F8 RID: 1784
	private TextMeshProUGUI[] texts;

	// Token: 0x040006F9 RID: 1785
	private Color selected = Color.white;

	// Token: 0x040006FA RID: 1786
	private Color deselected = Color.gray;
}
