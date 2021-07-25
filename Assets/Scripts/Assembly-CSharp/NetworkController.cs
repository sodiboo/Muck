using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

public class NetworkController : MonoBehaviour
{
    public enum NetworkType
    {
        Steam,
        Classic
    }

    public NetworkType networkType;

    public GameObject steam;

    public GameObject classic;

    public int nPlayers;

    public static int maxPlayers = 10;

    public Lobby lobby;

    public string[] playerNames;

    public static NetworkController Instance;

    public bool loading { get; set; }

    private void Awake()
    {
        if ((bool)Instance)
        {
            Object.Destroy(base.gameObject);
            return;
        }
        Instance = this;
        Object.DontDestroyOnLoad(base.gameObject);
    }

    public void LoadGame(string[] names)
    {
        loading = true;
        playerNames = names;
        LoadingScreen.Instance.Show();
        Invoke(nameof(StartLoadingScene), LoadingScreen.Instance.totalFadeTime);
    }

    private void StartLoadingScene()
    {
        SceneManager.LoadScene("GameAfterLobby");
    }
}
