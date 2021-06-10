
using TMPro;
using UnityEngine;

// Token: 0x020000F8 RID: 248
public class TopNavigate : MonoBehaviour
{
	// Token: 0x0600073C RID: 1852 RVA: 0x00023E9E File Offset: 0x0002209E
	private void OnEnable()
	{
		this.Select(0);
	}

	// Token: 0x0600073D RID: 1853 RVA: 0x00023EA8 File Offset: 0x000220A8
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

	// Token: 0x040006D3 RID: 1747
	public GameObject[] settingMenus;

	// Token: 0x040006D4 RID: 1748
	public TextMeshProUGUI[] texts;

	// Token: 0x040006D5 RID: 1749
	public Color selectedColor;

	// Token: 0x040006D6 RID: 1750
	public Color idleColor;
}
