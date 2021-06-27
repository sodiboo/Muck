using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200005D RID: 93
public class LoadingScreen : MonoBehaviour
{
	// Token: 0x06000211 RID: 529 RVA: 0x0000CAD4 File Offset: 0x0000ACD4
	private void Awake()
	{
		LoadingScreen.Instance = this;
		this.canvasGroup.alpha = 0f;
		this.background.gameObject.SetActive(false);
		this.players = new bool[10];
		if (LocalClient.serverOwner)
		{
			InvokeRepeating(nameof(CheckAllPlayersLoading), 10f, 10f);
		}
	}

	// Token: 0x06000212 RID: 530 RVA: 0x0000CB34 File Offset: 0x0000AD34
	private void CheckAllPlayersLoading()
	{
		if (GameManager.state == GameManager.GameState.Playing)
		{
			base.CancelInvoke("CheckAllPlayersLoading");
			return;
		}
		Debug.LogError("Checking all players");
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null)
			{
				Debug.LogError("Checking players");
				if (!client.player.loading)
				{
					ServerSend.StartGame(client.player.id, GameManager.gameSettings);
					Debug.LogError(client.player.username + " failed to load, trying to get him to load again...");
				}
			}
		}
	}

	// Token: 0x06000213 RID: 531 RVA: 0x0000CBF8 File Offset: 0x0000ADF8
	private void Start()
	{
		if (this.loadingInGame)
		{
			this.InitLoadingPlayers();
		}
	}

	// Token: 0x06000214 RID: 532 RVA: 0x0000CC08 File Offset: 0x0000AE08
	public void SetText(string s, float loadProgress)
	{
		this.background.gameObject.SetActive(true);
		this.text.text = s;
		this.desiredLoad = loadProgress;
	}

	// Token: 0x06000215 RID: 533 RVA: 0x0000CC30 File Offset: 0x0000AE30
	public void Hide(float fadeTime = 1f)
	{
		this.desiredAlpha = 0f;
		this.totalFadeTime = fadeTime;
		this.currentFadeTime = 0f;
		if (fadeTime == 0f)
		{
			this.canvasGroup.alpha = 0f;
		}
		Invoke(nameof(HideStuff), this.totalFadeTime);
	}

	// Token: 0x06000216 RID: 534 RVA: 0x0000CC83 File Offset: 0x0000AE83
	private void HideStuff()
	{
		this.background.gameObject.SetActive(false);
	}

	// Token: 0x06000217 RID: 535 RVA: 0x0000CC98 File Offset: 0x0000AE98
	public void FinishLoading()
	{
		GameObject[] array = this.loadingObject;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(false);
		}
		this.loadingParent.gameObject.SetActive(true);
	}

	// Token: 0x06000218 RID: 536 RVA: 0x0000CCD4 File Offset: 0x0000AED4
	public void UpdateStatuses(int id)
	{
		this.players[id] = true;
		if (this.loadingParent.childCount > id)
		{
			this.loadingParent.GetChild(id).GetComponent<PlayerLoading>().ChangeStatus("<color=green>Ready");
		}
	}

	// Token: 0x06000219 RID: 537 RVA: 0x0000CD08 File Offset: 0x0000AF08
	public void Show(float fadeTime = 1f)
	{
		this.desiredAlpha = 1f;
		this.currentFadeTime = 0f;
		this.totalFadeTime = fadeTime;
		if (fadeTime == 0f)
		{
			this.canvasGroup.alpha = 1f;
		}
		this.background.gameObject.SetActive(true);
	}

	// Token: 0x0600021A RID: 538 RVA: 0x0000CD5C File Offset: 0x0000AF5C
	public void InitLoadingPlayers()
	{
		this.loadingParent.gameObject.SetActive(false);
		for (int i = 0; i < NetworkController.Instance.playerNames.Length; i++)
		{
			PlayerLoading component = Instantiate<GameObject>(this.loadingPlayerPrefab, this.loadingParent).GetComponent<PlayerLoading>();
			string status = "<color=red>Loading";
			component.SetStatus(NetworkController.Instance.playerNames[i], status);
		}
	}

	// Token: 0x17000015 RID: 21
	// (get) Token: 0x0600021B RID: 539 RVA: 0x0000CDBF File Offset: 0x0000AFBF
	// (set) Token: 0x0600021C RID: 540 RVA: 0x0000CDC7 File Offset: 0x0000AFC7
	public float totalFadeTime { get; set; } = 1f;

	// Token: 0x0600021D RID: 541 RVA: 0x0000CDD0 File Offset: 0x0000AFD0
	private void Update()
	{
		this.loadingBar.transform.localScale = new Vector3(this.desiredLoad, 1f, 1f);
		if (this.currentFadeTime < this.totalFadeTime && this.totalFadeTime > 0f)
		{
			this.currentFadeTime += Time.deltaTime;
			this.canvasGroup.alpha = Mathf.Lerp(this.canvasGroup.alpha, this.desiredAlpha, this.currentFadeTime / this.totalFadeTime);
		}
	}

	// Token: 0x0400022E RID: 558
	public TextMeshProUGUI text;

	// Token: 0x0400022F RID: 559
	public RawImage loadingBar;

	// Token: 0x04000230 RID: 560
	public RawImage background;

	// Token: 0x04000231 RID: 561
	private float desiredLoad;

	// Token: 0x04000232 RID: 562
	private Graphic[] allGraphics;

	// Token: 0x04000233 RID: 563
	public CanvasGroup canvasGroup;

	// Token: 0x04000234 RID: 564
	public Transform loadingParent;

	// Token: 0x04000235 RID: 565
	public GameObject loadingPlayerPrefab;

	// Token: 0x04000236 RID: 566
	public static LoadingScreen Instance;

	// Token: 0x04000237 RID: 567
	public bool[] players;

	// Token: 0x04000238 RID: 568
	public CanvasGroup loadBar;

	// Token: 0x04000239 RID: 569
	public CanvasGroup playerStatuses;

	// Token: 0x0400023A RID: 570
	public GameObject[] loadingObject;

	// Token: 0x0400023B RID: 571
	public bool loadingInGame;

	// Token: 0x0400023C RID: 572
	private float currentFadeTime;

	// Token: 0x0400023E RID: 574
	private float desiredAlpha;
}
