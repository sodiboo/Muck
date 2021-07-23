using TMPro;
using UnityEngine;

public class MenuUI : MonoBehaviour
{
    public GameObject startBtn;

    public GameObject lobbyUi;

    public GameObject mainUi;

    public TextMeshProUGUI version;

    public MenuCamera menuCam;

    private void Start()
    {
        lobbyUi.SetActive(value: false);
        Cursor.visible = true;
        Cursor.lockState = CursorLockMode.None;
        PPController.Instance.Reset();
        version.text = "Version" + Application.version;
    }

    public void StartLobby()
    {
        SteamManager.Instance.StartLobby();
    }

    public void JoinLobby()
    {
        lobbyUi.SetActive(value: true);
        mainUi.SetActive(value: false);
        menuCam.Lobby();
    }

    public void LeaveLobby()
    {
        lobbyUi.SetActive(value: false);
        mainUi.SetActive(value: true);
        menuCam.Menu();
    }

    public void LeaveGame()
    {
        SteamManager.Instance.leaveLobby();
        startBtn.SetActive(value: false);
    }

    public void StartGame()
    {
        SteamLobby.Instance.StartGame();
    }
}
