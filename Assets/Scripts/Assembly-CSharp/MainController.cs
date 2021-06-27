using System;
using UnityEngine;

// Token: 0x02000061 RID: 97
public class MainController : MonoBehaviour
{
	// Token: 0x04000251 RID: 593
	public static bool isHost;

	// Token: 0x04000252 RID: 594
	public static MainController.MainState state;

	// Token: 0x02000147 RID: 327
	public enum MainState
	{
		// Token: 0x0400089E RID: 2206
		None,
		// Token: 0x0400089F RID: 2207
		Lobby,
		// Token: 0x040008A0 RID: 2208
		Loading,
		// Token: 0x040008A1 RID: 2209
		Playing,
		// Token: 0x040008A2 RID: 2210
		EndScreen
	}
}
