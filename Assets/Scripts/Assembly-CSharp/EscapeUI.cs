using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000029 RID: 41
public class EscapeUI : MonoBehaviour
{
	// Token: 0x060000DB RID: 219 RVA: 0x00002BE0 File Offset: 0x00000DE0
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			this.backBtn.onClick.Invoke();
			UiSfx.Instance.PlayClick();
		}
	}

	// Token: 0x040000E4 RID: 228
	public Button backBtn;
}
