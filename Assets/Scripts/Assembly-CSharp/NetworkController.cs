
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x02000053 RID: 83
public class NetworkController : MonoBehaviour
{
	// Token: 0x060001D2 RID: 466 RVA: 0x0000AC2D File Offset: 0x00008E2D
	private void Awake()
	{
		if (NetworkController.Instance)
		{
		Destroy(base.gameObject);
			return;
		}
		NetworkController.Instance = this;
		Object.DontDestroyOnLoad(base.gameObject);
	}

	// Token: 0x060001D3 RID: 467 RVA: 0x0000AC58 File Offset: 0x00008E58
	public void LoadGame(string[] names)
	{
		this.playerNames = names;
		LoadingScreen.Instance.Show(1f);
		base.Invoke("StartLoadingScene", LoadingScreen.Instance.totalFadeTime);
	}

	// Token: 0x060001D4 RID: 468 RVA: 0x0000AC85 File Offset: 0x00008E85
	private void StartLoadingScene()
	{
		SceneManager.LoadScene("GameAfterLobby");
	}

	// Token: 0x040001CF RID: 463
	public NetworkController.NetworkType networkType;

	// Token: 0x040001D0 RID: 464
	public GameObject steam;

	// Token: 0x040001D1 RID: 465
	public GameObject classic;

	// Token: 0x040001D2 RID: 466
	public Lobby lobby;

	// Token: 0x040001D3 RID: 467
	public string[] playerNames;

	// Token: 0x040001D4 RID: 468
	public static NetworkController Instance;

	// Token: 0x0200010F RID: 271
	public enum NetworkType
	{
		// Token: 0x0400073E RID: 1854
		Steam,
		// Token: 0x0400073F RID: 1855
		Classic
	}
}
