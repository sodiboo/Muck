using System;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x02000062 RID: 98
public class NetworkController : MonoBehaviour
{
	// Token: 0x17000010 RID: 16
	// (get) Token: 0x060001FB RID: 507 RVA: 0x00003881 File Offset: 0x00001A81
	// (set) Token: 0x060001FC RID: 508 RVA: 0x00003889 File Offset: 0x00001A89
	public bool loading { get; set; }

	// Token: 0x060001FD RID: 509 RVA: 0x00003892 File Offset: 0x00001A92
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

	// Token: 0x060001FE RID: 510 RVA: 0x000038BD File Offset: 0x00001ABD
	public void LoadGame(string[] names)
	{
		this.loading = true;
		this.playerNames = names;
		LoadingScreen.Instance.Show(1f);
		base.Invoke(nameof(StartLoadingScene), LoadingScreen.Instance.totalFadeTime);
	}

	// Token: 0x060001FF RID: 511 RVA: 0x000038F1 File Offset: 0x00001AF1
	private void StartLoadingScene()
	{
		SceneManager.LoadScene("GameAfterLobby");
	}

	// Token: 0x04000210 RID: 528
	public NetworkController.NetworkType networkType;

	// Token: 0x04000211 RID: 529
	public GameObject steam;

	// Token: 0x04000212 RID: 530
	public GameObject classic;

	// Token: 0x04000213 RID: 531
	public Lobby lobby;

	// Token: 0x04000214 RID: 532
	public string[] playerNames;

	// Token: 0x04000215 RID: 533
	public static NetworkController Instance;

	// Token: 0x02000063 RID: 99
	public enum NetworkType
	{
		// Token: 0x04000217 RID: 535
		Steam,
		// Token: 0x04000218 RID: 536
		Classic
	}
}
