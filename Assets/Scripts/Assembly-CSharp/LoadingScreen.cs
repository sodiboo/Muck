using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LoadingScreen : MonoBehaviour
{
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

	private void Start()
	{
		if (this.loadingInGame)
		{
			this.InitLoadingPlayers();
		}
	}

	public void SetText(string s, float loadProgress)
	{
		this.background.gameObject.SetActive(true);
		this.text.text = s;
		this.desiredLoad = loadProgress;
	}

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

	private void HideStuff()
	{
		this.background.gameObject.SetActive(false);
	}

	public void FinishLoading()
	{
		GameObject[] array = this.loadingObject;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(false);
		}
		this.loadingParent.gameObject.SetActive(true);
	}

	public void UpdateStatuses(int id)
	{
		this.players[id] = true;
		if (this.loadingParent.childCount > id)
		{
			this.loadingParent.GetChild(id).GetComponent<PlayerLoading>().ChangeStatus("<color=green>Ready");
		}
	}

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

	public float totalFadeTime { get; set; } = 1f;

	private void Update()
	{
		this.loadingBar.transform.localScale = new Vector3(this.desiredLoad, 1f, 1f);
		if (this.currentFadeTime < this.totalFadeTime && this.totalFadeTime > 0f)
		{
			this.currentFadeTime += Time.deltaTime;
			this.canvasGroup.alpha = Mathf.Lerp(this.canvasGroup.alpha, this.desiredAlpha, this.currentFadeTime / this.totalFadeTime);
		}
	}

	public TextMeshProUGUI text;

	public RawImage loadingBar;

	public RawImage background;

	private float desiredLoad;

	private Graphic[] allGraphics;

	public CanvasGroup canvasGroup;

	public Transform loadingParent;

	public GameObject loadingPlayerPrefab;

	public static LoadingScreen Instance;

	public bool[] players;

	public CanvasGroup loadBar;

	public CanvasGroup playerStatuses;

	public GameObject[] loadingObject;

	public bool loadingInGame;

	private float currentFadeTime;

	private float desiredAlpha;
}
