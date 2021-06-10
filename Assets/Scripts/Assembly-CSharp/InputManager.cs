
using UnityEngine;

// Token: 0x02000036 RID: 54
public class InputManager : MonoBehaviour
{
	// Token: 0x06000137 RID: 311 RVA: 0x00008868 File Offset: 0x00006A68
	private void Start()
	{
		this.Init();
	}

	// Token: 0x06000138 RID: 312 RVA: 0x00008870 File Offset: 0x00006A70
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

	// Token: 0x04000137 RID: 311
	public static KeyCode forward;

	// Token: 0x04000138 RID: 312
	public static KeyCode backwards;

	// Token: 0x04000139 RID: 313
	public static KeyCode left;

	// Token: 0x0400013A RID: 314
	public static KeyCode right;

	// Token: 0x0400013B RID: 315
	public static KeyCode jump;

	// Token: 0x0400013C RID: 316
	public static KeyCode sprint;

	// Token: 0x0400013D RID: 317
	public static KeyCode interact;

	// Token: 0x0400013E RID: 318
	public static KeyCode inventory;

	// Token: 0x0400013F RID: 319
	public static KeyCode map;

	// Token: 0x04000140 RID: 320
	public static KeyCode leftClick;

	// Token: 0x04000141 RID: 321
	public static KeyCode rightClick;
}
