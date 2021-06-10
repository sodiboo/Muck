
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000023 RID: 35
public class EscapeUI : MonoBehaviour
{
	// Token: 0x060000CF RID: 207 RVA: 0x000061FC File Offset: 0x000043FC
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			this.backBtn.onClick.Invoke();
			UiSfx.Instance.PlayClick();
		}
	}

	// Token: 0x040000CF RID: 207
	public Button backBtn;
}
