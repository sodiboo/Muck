using System;
using UnityEngine;

// Token: 0x0200012C RID: 300
public class UiController : MonoBehaviour
{
	// Token: 0x0600089D RID: 2205 RVA: 0x0002B174 File Offset: 0x00029374
	private void Awake()
	{
		UiController.Instance = this;
	}

	// Token: 0x0600089E RID: 2206 RVA: 0x0002B17C File Offset: 0x0002937C
	public void ToggleHud()
	{
		this.hudActive = !this.hudActive;
		this.canvas.enabled = this.hudActive;
	}

	// Token: 0x04000831 RID: 2097
	public Canvas canvas;

	// Token: 0x04000832 RID: 2098
	public static UiController Instance;

	// Token: 0x04000833 RID: 2099
	private bool hudActive = true;
}
