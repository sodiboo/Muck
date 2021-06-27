using System;
using TMPro;
using UnityEngine;

// Token: 0x02000128 RID: 296
public class TopNavigate : MonoBehaviour
{
	// Token: 0x06000880 RID: 2176 RVA: 0x0002A77E File Offset: 0x0002897E
	private void OnEnable()
	{
		this.Select(0);
	}

	// Token: 0x06000881 RID: 2177 RVA: 0x0002A788 File Offset: 0x00028988
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

	// Token: 0x04000818 RID: 2072
	public GameObject[] settingMenus;

	// Token: 0x04000819 RID: 2073
	public TextMeshProUGUI[] texts;

	// Token: 0x0400081A RID: 2074
	public Color selectedColor;

	// Token: 0x0400081B RID: 2075
	public Color idleColor;
}
