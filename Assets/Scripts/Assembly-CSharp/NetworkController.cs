using System;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x02000070 RID: 112
public class NetworkController : MonoBehaviour
{
	// Token: 0x17000016 RID: 22
	// (get) Token: 0x0600027E RID: 638 RVA: 0x0000E4F1 File Offset: 0x0000C6F1
	// (set) Token: 0x0600027F RID: 639 RVA: 0x0000E4F9 File Offset: 0x0000C6F9
	public bool loading { get; set; }

	// Token: 0x06000280 RID: 640 RVA: 0x0000E502 File Offset: 0x0000C702
	private void Awake()
	{
		if (NetworkController.Instance)
		{
			Destroy(base.gameObject);
			return;
		}
		NetworkController.Instance = this;
		DontDestroyOnLoad(base.gameObject);
	}

	// Token: 0x06000281 RID: 641 RVA: 0x0000E52D File Offset: 0x0000C72D
	public void LoadGame(string[] names)
	{
		this.loading = true;
		this.playerNames = names;
		LoadingScreen.Instance.Show(1f);
		Invoke(nameof(StartLoadingScene), LoadingScreen.Instance.totalFadeTime);
	}

	// Token: 0x06000282 RID: 642 RVA: 0x0000E561 File Offset: 0x0000C761
	private void StartLoadingScene()
	{
		SceneManager.LoadScene("GameAfterLobby");
	}

	// Token: 0x04000295 RID: 661
	public NetworkController.NetworkType networkType;

	// Token: 0x04000296 RID: 662
	public GameObject steam;

	// Token: 0x04000297 RID: 663
	public GameObject classic;

	// Token: 0x04000298 RID: 664
	public Lobby lobby;

	// Token: 0x04000299 RID: 665
	public string[] playerNames;

	// Token: 0x0400029A RID: 666
	public static NetworkController Instance;

	// Token: 0x02000149 RID: 329
	public enum NetworkType
	{
		// Token: 0x040008A8 RID: 2216
		Steam,
		// Token: 0x040008A9 RID: 2217
		Classic
	}
}
