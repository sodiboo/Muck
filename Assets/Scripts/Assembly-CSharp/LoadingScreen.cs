
using TMPro;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000041 RID: 65
public class LoadingScreen : MonoBehaviour
{
	// Token: 0x06000175 RID: 373 RVA: 0x00009ABB File Offset: 0x00007CBB
	private void Awake()
	{
		LoadingScreen.Instance = this;
		this.canvasGroup.alpha = 0f;
		this.background.gameObject.SetActive(false);
		this.players = new bool[10];
	}

	// Token: 0x06000176 RID: 374 RVA: 0x00009AF1 File Offset: 0x00007CF1
	private void Start()
	{
		if (this.loadingInGame)
		{
			this.InitLoadingPlayers();
		}
	}

	// Token: 0x06000177 RID: 375 RVA: 0x00009B01 File Offset: 0x00007D01
	public void SetText(string s, float loadProgress)
	{
		this.background.gameObject.SetActive(true);
		this.text.text = s;
		this.desiredLoad = loadProgress;
	}

	// Token: 0x06000178 RID: 376 RVA: 0x00009B28 File Offset: 0x00007D28
	public void Hide(float fadeTime = 1f)
	{
		this.desiredAlpha = 0f;
		this.totalFadeTime = fadeTime;
		this.currentFadeTime = 0f;
		if (fadeTime == 0f)
		{
			this.canvasGroup.alpha = 0f;
		}
		base.Invoke("HideStuff", this.totalFadeTime);
	}

	// Token: 0x06000179 RID: 377 RVA: 0x00009B7B File Offset: 0x00007D7B
	private void HideStuff()
	{
		this.background.gameObject.SetActive(false);
	}

	// Token: 0x0600017A RID: 378 RVA: 0x00009B90 File Offset: 0x00007D90
	public void FinishLoading()
	{
		GameObject[] array = this.loadingObject;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(false);
		}
		this.loadingParent.gameObject.SetActive(true);
	}

	// Token: 0x0600017B RID: 379 RVA: 0x00009BCC File Offset: 0x00007DCC
	public void UpdateStatuses(int id)
	{
		this.players[id] = true;
		if (this.loadingParent.childCount > id)
		{
			this.loadingParent.GetChild(id).GetComponent<PlayerLoading>().ChangeStatus("<color=green>Ready");
		}
	}

	// Token: 0x0600017C RID: 380 RVA: 0x00009C00 File Offset: 0x00007E00
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

	// Token: 0x0600017D RID: 381 RVA: 0x00009C54 File Offset: 0x00007E54
	public void InitLoadingPlayers()
	{
		this.loadingParent.gameObject.SetActive(false);
		for (int i = 0; i < NetworkController.Instance.playerNames.Length; i++)
		{
			PlayerLoading component =Instantiate(this.loadingPlayerPrefab, this.loadingParent).GetComponent<PlayerLoading>();
			string status = "<color=red>Loading";
			component.SetStatus(NetworkController.Instance.playerNames[i], status);
		}
	}

	// Token: 0x1700000D RID: 13
	// (get) Token: 0x0600017E RID: 382 RVA: 0x00009CB7 File Offset: 0x00007EB7
	// (set) Token: 0x0600017F RID: 383 RVA: 0x00009CBF File Offset: 0x00007EBF
	public float totalFadeTime { get; set; } = 1f;

	// Token: 0x06000180 RID: 384 RVA: 0x00009CC8 File Offset: 0x00007EC8
	private void Update()
	{
		this.loadingBar.transform.localScale = new Vector3(this.desiredLoad, 1f, 1f);
		if (this.currentFadeTime < this.totalFadeTime && this.totalFadeTime > 0f)
		{
			this.currentFadeTime += Time.deltaTime;
			this.canvasGroup.alpha = Mathf.Lerp(this.canvasGroup.alpha, this.desiredAlpha, this.currentFadeTime / this.totalFadeTime);
		}
	}

	// Token: 0x04000176 RID: 374
	public TextMeshProUGUI text;

	// Token: 0x04000177 RID: 375
	public RawImage loadingBar;

	// Token: 0x04000178 RID: 376
	public RawImage background;

	// Token: 0x04000179 RID: 377
	private float desiredLoad;

	// Token: 0x0400017A RID: 378
	private Graphic[] allGraphics;

	// Token: 0x0400017B RID: 379
	public CanvasGroup canvasGroup;

	// Token: 0x0400017C RID: 380
	public Transform loadingParent;

	// Token: 0x0400017D RID: 381
	public GameObject loadingPlayerPrefab;

	// Token: 0x0400017E RID: 382
	public static LoadingScreen Instance;

	// Token: 0x0400017F RID: 383
	public bool[] players;

	// Token: 0x04000180 RID: 384
	public CanvasGroup loadBar;

	// Token: 0x04000181 RID: 385
	public CanvasGroup playerStatuses;

	// Token: 0x04000182 RID: 386
	public GameObject[] loadingObject;

	// Token: 0x04000183 RID: 387
	public bool loadingInGame;

	// Token: 0x04000184 RID: 388
	private float currentFadeTime;

	// Token: 0x04000186 RID: 390
	private float desiredAlpha;
}
