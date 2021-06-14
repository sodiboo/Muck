using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200004E RID: 78
public class LoadingScreen : MonoBehaviour
{
	// Token: 0x0600019C RID: 412 RVA: 0x0000E53C File Offset: 0x0000C73C
	private void Awake()
	{
		LoadingScreen.Instance = this;
		this.canvasGroup.alpha = 0f;
		this.background.gameObject.SetActive(false);
		this.players = new bool[10];
		if (LocalClient.serverOwner)
		{
			base.InvokeRepeating(nameof(CheckAllPlayersLoading), 10f, 10f);
		}
	}

	// Token: 0x0600019D RID: 413 RVA: 0x0000E59C File Offset: 0x0000C79C
	private void CheckAllPlayersLoading()
	{
		if (GameManager.state == GameManager.GameState.Playing)
		{
			base.CancelInvoke(nameof(CheckAllPlayersLoading));
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

	// Token: 0x0600019E RID: 414 RVA: 0x0000336F File Offset: 0x0000156F
	private void Start()
	{
		if (this.loadingInGame)
		{
			this.InitLoadingPlayers();
		}
	}

	// Token: 0x0600019F RID: 415 RVA: 0x0000337F File Offset: 0x0000157F
	public void SetText(string s, float loadProgress)
	{
		this.background.gameObject.SetActive(true);
		this.text.text = s;
		this.desiredLoad = loadProgress;
	}

	// Token: 0x060001A0 RID: 416 RVA: 0x0000E660 File Offset: 0x0000C860
	public void Hide(float fadeTime = 1f)
	{
		this.desiredAlpha = 0f;
		this.totalFadeTime = fadeTime;
		this.currentFadeTime = 0f;
		if (fadeTime == 0f)
		{
			this.canvasGroup.alpha = 0f;
		}
		base.Invoke(nameof(HideStuff), this.totalFadeTime);
	}

	// Token: 0x060001A1 RID: 417 RVA: 0x000033A5 File Offset: 0x000015A5
	private void HideStuff()
	{
		this.background.gameObject.SetActive(false);
	}

	// Token: 0x060001A2 RID: 418 RVA: 0x0000E6B4 File Offset: 0x0000C8B4
	public void FinishLoading()
	{
		GameObject[] array = this.loadingObject;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(false);
		}
		this.loadingParent.gameObject.SetActive(true);
	}

	// Token: 0x060001A3 RID: 419 RVA: 0x000033B8 File Offset: 0x000015B8
	public void UpdateStatuses(int id)
	{
		this.players[id] = true;
		if (this.loadingParent.childCount > id)
		{
			this.loadingParent.GetChild(id).GetComponent<PlayerLoading>().ChangeStatus("<color=green>Ready");
		}
	}

	// Token: 0x060001A4 RID: 420 RVA: 0x0000E6F0 File Offset: 0x0000C8F0
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

	// Token: 0x060001A5 RID: 421 RVA: 0x0000E744 File Offset: 0x0000C944
	public void InitLoadingPlayers()
	{
		this.loadingParent.gameObject.SetActive(false);
		for (int i = 0; i < NetworkController.Instance.playerNames.Length; i++)
		{
			PlayerLoading component =Instantiate<GameObject>(this.loadingPlayerPrefab, this.loadingParent).GetComponent<PlayerLoading>();
			string status = "<color=red>Loading";
			component.SetStatus(NetworkController.Instance.playerNames[i], status);
		}
	}

	// Token: 0x1700000F RID: 15
	// (get) Token: 0x060001A6 RID: 422 RVA: 0x000033EC File Offset: 0x000015EC
	// (set) Token: 0x060001A7 RID: 423 RVA: 0x000033F4 File Offset: 0x000015F4
	public float totalFadeTime { get; set; } = 1f;

	// Token: 0x060001A8 RID: 424 RVA: 0x0000E7A8 File Offset: 0x0000C9A8
	private void Update()
	{
		this.loadingBar.transform.localScale = new Vector3(this.desiredLoad, 1f, 1f);
		if (this.currentFadeTime < this.totalFadeTime && this.totalFadeTime > 0f)
		{
			this.currentFadeTime += Time.deltaTime;
			this.canvasGroup.alpha = Mathf.Lerp(this.canvasGroup.alpha, this.desiredAlpha, this.currentFadeTime / this.totalFadeTime);
		}
	}

	// Token: 0x040001AB RID: 427
	public TextMeshProUGUI text;

	// Token: 0x040001AC RID: 428
	public RawImage loadingBar;

	// Token: 0x040001AD RID: 429
	public RawImage background;

	// Token: 0x040001AE RID: 430
	private float desiredLoad;

	// Token: 0x040001AF RID: 431
	private Graphic[] allGraphics;

	// Token: 0x040001B0 RID: 432
	public CanvasGroup canvasGroup;

	// Token: 0x040001B1 RID: 433
	public Transform loadingParent;

	// Token: 0x040001B2 RID: 434
	public GameObject loadingPlayerPrefab;

	// Token: 0x040001B3 RID: 435
	public static LoadingScreen Instance;

	// Token: 0x040001B4 RID: 436
	public bool[] players;

	// Token: 0x040001B5 RID: 437
	public CanvasGroup loadBar;

	// Token: 0x040001B6 RID: 438
	public CanvasGroup playerStatuses;

	// Token: 0x040001B7 RID: 439
	public GameObject[] loadingObject;

	// Token: 0x040001B8 RID: 440
	public bool loadingInGame;

	// Token: 0x040001B9 RID: 441
	private float currentFadeTime;

	// Token: 0x040001BB RID: 443
	private float desiredAlpha;
}
