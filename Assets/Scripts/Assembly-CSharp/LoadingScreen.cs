using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LoadingScreen : MonoBehaviour
{
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

    public float totalFadeTime { get; set; } = 1f;


    private void Awake()
    {
        Instance = this;
        canvasGroup.alpha = 0f;
        background.gameObject.SetActive(value: false);
        players = new bool[10];
        if (LocalClient.serverOwner)
        {
            InvokeRepeating(nameof(CheckAllPlayersLoading), 5f, 5f);
        }
    }

    private void CheckAllPlayersLoading()
    {
        if (GameManager.state == GameManager.GameState.Playing)
        {
            CancelInvoke(nameof(CheckAllPlayersLoading));
            return;
        }
        Debug.LogError("Checking all players");
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player != null && !value.player.loading)
            {
                ServerSend.StartGame(value.player.id, GameManager.gameSettings);
                Debug.LogError(value.player.username + " failed to load, trying to get him to load again...");
            }
        }
    }

    private void Start()
    {
        if (loadingInGame)
        {
            InitLoadingPlayers();
        }
    }

    public void SetText(string s, float loadProgress)
    {
        background.gameObject.SetActive(value: true);
        text.text = s;
        desiredLoad = loadProgress;
    }

    public void Hide(float fadeTime = 1f)
    {
        desiredAlpha = 0f;
        totalFadeTime = fadeTime;
        currentFadeTime = 0f;
        if (fadeTime == 0f)
        {
            canvasGroup.alpha = 0f;
        }
        Invoke(nameof(HideStuff), totalFadeTime);
    }

    private void HideStuff()
    {
        background.gameObject.SetActive(value: false);
    }

    public void FinishLoading()
    {
        GameObject[] array = loadingObject;
        for (int i = 0; i < array.Length; i++)
        {
            array[i].SetActive(value: false);
        }
        loadingParent.gameObject.SetActive(value: true);
    }

    public void UpdateStatuses(int id)
    {
        players[id] = true;
        if (loadingParent.childCount > id)
        {
            loadingParent.GetChild(id).GetComponent<PlayerLoading>().ChangeStatus("<color=green>Ready");
        }
    }

    public void Show(float fadeTime = 1f)
    {
        desiredAlpha = 1f;
        currentFadeTime = 0f;
        totalFadeTime = fadeTime;
        if (fadeTime == 0f)
        {
            canvasGroup.alpha = 1f;
        }
        background.gameObject.SetActive(value: true);
    }

    public void InitLoadingPlayers()
    {
        loadingParent.gameObject.SetActive(value: false);
        for (int i = 0; i < NetworkController.Instance.playerNames.Length; i++)
        {
            PlayerLoading component = Object.Instantiate(loadingPlayerPrefab, loadingParent).GetComponent<PlayerLoading>();
            string status = "<color=red>Loading";
            component.SetStatus(NetworkController.Instance.playerNames[i], status);
        }
    }

    private void Update()
    {
        loadingBar.transform.localScale = new Vector3(desiredLoad, 1f, 1f);
        if (currentFadeTime < totalFadeTime && totalFadeTime > 0f)
        {
            currentFadeTime += Time.deltaTime;
            canvasGroup.alpha = Mathf.Lerp(canvasGroup.alpha, desiredAlpha, currentFadeTime / totalFadeTime);
        }
    }
}
