using System;
using UnityEngine;

// Token: 0x02000043 RID: 67
public class InputManager : MonoBehaviour
{
	// Token: 0x0600015E RID: 350 RVA: 0x00003134 File Offset: 0x00001334
	private void Start()
	{
		this.Init();
	}

	// Token: 0x0600015F RID: 351 RVA: 0x0000D50C File Offset: 0x0000B70C
	private void Init()
	{
		InputManager.forward = SaveManager.Instance.state.forward;
		InputManager.backwards = SaveManager.Instance.state.backwards;
		InputManager.left = SaveManager.Instance.state.left;
		InputManager.right = SaveManager.Instance.state.right;
		InputManager.jump = SaveManager.Instance.state.jump;
		InputManager.sprint = SaveManager.Instance.state.sprint;
		InputManager.interact = SaveManager.Instance.state.interact;
		InputManager.inventory = SaveManager.Instance.state.inventory;
		InputManager.map = SaveManager.Instance.state.map;
		InputManager.leftClick = SaveManager.Instance.state.leftClick;
		InputManager.rightClick = SaveManager.Instance.state.rightClick;
	}

	// Token: 0x0400016C RID: 364
	public static KeyCode forward;

	// Token: 0x0400016D RID: 365
	public static KeyCode backwards;

	// Token: 0x0400016E RID: 366
	public static KeyCode left;

	// Token: 0x0400016F RID: 367
	public static KeyCode right;

	// Token: 0x04000170 RID: 368
	public static KeyCode jump;

	// Token: 0x04000171 RID: 369
	public static KeyCode sprint;

	// Token: 0x04000172 RID: 370
	public static KeyCode interact;

	// Token: 0x04000173 RID: 371
	public static KeyCode inventory;

	// Token: 0x04000174 RID: 372
	public static KeyCode map;

	// Token: 0x04000175 RID: 373
	public static KeyCode leftClick;

	// Token: 0x04000176 RID: 374
	public static KeyCode rightClick;
}
