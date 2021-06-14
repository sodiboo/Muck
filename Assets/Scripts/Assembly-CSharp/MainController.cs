using System;
using UnityEngine;

// Token: 0x02000052 RID: 82
public class MainController : MonoBehaviour
{
	// Token: 0x040001CE RID: 462
	public static bool isHost;

	// Token: 0x040001CF RID: 463
	public static MainController.MainState state;

	// Token: 0x02000053 RID: 83
	public enum MainState
	{
		// Token: 0x040001D1 RID: 465
		None,
		// Token: 0x040001D2 RID: 466
		Lobby,
		// Token: 0x040001D3 RID: 467
		Loading,
		// Token: 0x040001D4 RID: 468
		Playing,
		// Token: 0x040001D5 RID: 469
		EndScreen
	}
}
