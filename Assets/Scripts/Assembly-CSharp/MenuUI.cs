using System;
using TMPro;
using UnityEngine;

public class MenuUI : MonoBehaviour
{
	private void Start()
	{
		this.lobbyUi.SetActive(false);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
		PPController.Instance.Reset();
		this.version.text = "Version" + Application.version;
	}

	public void StartLobby()
	{
		SteamManager.Instance.StartLobby();
	}

	public void JoinLobby()
	{
		this.lobbyUi.SetActive(true);
		this.mainUi.SetActive(false);
		this.menuCam.Lobby();
	}

	public void LeaveLobby()
	{
		this.lobbyUi.SetActive(false);
		this.mainUi.SetActive(true);
		this.menuCam.Menu();
	}

	public void LeaveGame()
	{
		SteamManager.Instance.leaveLobby();
		this.startBtn.SetActive(false);
	}

	public void StartGame()
	{
		SteamLobby.Instance.StartGame();
	}

	public GameObject startBtn;

	public GameObject lobbyUi;

	public GameObject mainUi;

	public TextMeshProUGUI version;

	public MenuCamera menuCam;
}
