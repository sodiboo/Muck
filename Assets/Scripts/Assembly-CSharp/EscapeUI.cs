using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000031 RID: 49
public class EscapeUI : MonoBehaviour
{
	// Token: 0x06000121 RID: 289 RVA: 0x000076A8 File Offset: 0x000058A8
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			this.backBtn.onClick.Invoke();
			UiSfx.Instance.PlayClick();
		}
	}

	// Token: 0x0400012A RID: 298
	public Button backBtn;
}
