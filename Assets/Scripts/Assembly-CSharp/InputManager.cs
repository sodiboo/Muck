using System;
using UnityEngine;

// Token: 0x02000050 RID: 80
public class InputManager : MonoBehaviour
{
	// Token: 0x060001C8 RID: 456 RVA: 0x0000B3C0 File Offset: 0x000095C0
	private void Start()
	{
		this.Init();
	}

	// Token: 0x060001C9 RID: 457 RVA: 0x0000B3C8 File Offset: 0x000095C8
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

	// Token: 0x040001DE RID: 478
	public static KeyCode forward;

	// Token: 0x040001DF RID: 479
	public static KeyCode backwards;

	// Token: 0x040001E0 RID: 480
	public static KeyCode left;

	// Token: 0x040001E1 RID: 481
	public static KeyCode right;

	// Token: 0x040001E2 RID: 482
	public static KeyCode jump;

	// Token: 0x040001E3 RID: 483
	public static KeyCode sprint;

	// Token: 0x040001E4 RID: 484
	public static KeyCode interact;

	// Token: 0x040001E5 RID: 485
	public static KeyCode inventory;

	// Token: 0x040001E6 RID: 486
	public static KeyCode map;

	// Token: 0x040001E7 RID: 487
	public static KeyCode leftClick;

	// Token: 0x040001E8 RID: 488
	public static KeyCode rightClick;
}
