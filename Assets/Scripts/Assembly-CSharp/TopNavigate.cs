using System;
using TMPro;
using UnityEngine;

// Token: 0x0200014C RID: 332
public class TopNavigate : MonoBehaviour
{
	// Token: 0x060007F8 RID: 2040 RVA: 0x000073A9 File Offset: 0x000055A9
	private void OnEnable()
	{
		this.Select(0);
	}

	// Token: 0x060007F9 RID: 2041 RVA: 0x0002720C File Offset: 0x0002540C
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

	// Token: 0x04000839 RID: 2105
	public GameObject[] settingMenus;

	// Token: 0x0400083A RID: 2106
	public TextMeshProUGUI[] texts;

	// Token: 0x0400083B RID: 2107
	public Color selectedColor;

	// Token: 0x0400083C RID: 2108
	public Color idleColor;
}
