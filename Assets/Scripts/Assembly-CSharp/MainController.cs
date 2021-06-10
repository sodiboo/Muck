
using UnityEngine;

// Token: 0x02000045 RID: 69
public class MainController : MonoBehaviour
{
	// Token: 0x04000198 RID: 408
	public static bool isHost;

	// Token: 0x04000199 RID: 409
	public static MainController.MainState state;

	// Token: 0x0200010D RID: 269
	public enum MainState
	{
		// Token: 0x04000734 RID: 1844
		None,
		// Token: 0x04000735 RID: 1845
		Lobby,
		// Token: 0x04000736 RID: 1846
		Loading,
		// Token: 0x04000737 RID: 1847
		Playing,
		// Token: 0x04000738 RID: 1848
		EndScreen
	}
}
