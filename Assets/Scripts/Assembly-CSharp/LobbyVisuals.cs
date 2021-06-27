using System;
using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using TMPro;
using UnityEngine;

public class LobbyVisuals : MonoBehaviour
{
	private void Awake()
	{
		LobbyVisuals.Instance = this;
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
	}

	private void Start()
	{
		MusicController.Instance.PlaySong(MusicController.SongType.Day, false);
	}

	public void CopyLobbyId()
	{
		GUIUtility.systemCopyBuffer = string.Concat(this.currentLobby.Id.Value);
	}

	public void CloseLobby()
	{
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
		this.menuUi.LeaveLobby();
	}

	public void OpenLobby(Lobby lobby)
	{
		this.steamToLobbyId = new Dictionary<ulong, int>();
		this.currentLobby = lobby;
		NetworkController.Instance.lobby = this.currentLobby;
		LocalClient.instance.serverHost = lobby.Owner.Id.Value;
		string str = string.Concat(lobby.Id.Value);
		this.lobbyId.text = "Lobby ID: (send to friend)<size=90%>\n" + str;
		if (SteamManager.Instance.PlayerSteamId.Value != lobby.Owner.Id)
		{
			LobbySettings.Instance.startButton.SetActive(false);
		}
		else
		{
			LobbySettings.Instance.startButton.SetActive(true);
		}
		foreach (Friend friend in lobby.Members)
		{
			int nextId = this.GetNextId();
			if (nextId == -1)
			{
				return;
			}
			SteamId steamId = friend.Id.Value;
			this.steamToLobbyId[steamId] = nextId;
			this.SpawnLobbyPlayer(new Friend(steamId));
		}
		this.menuUi.JoinLobby();
	}

	public void SpawnLobbyPlayer(Friend friend)
	{
		MonoBehaviour.print("spawning lobby player: " + friend.Name);
		int nextId = this.GetNextId();
		string name = friend.Name;
		this.steamToLobbyId[friend.Id.Value] = nextId;
		this.lobbyPlayers[nextId].SetActive(true);
		this.lobbyPlayers[nextId].GetComponentInChildren<TextMeshProUGUI>().text = name;
		this.playerNames[nextId].text = friend.Name;
	}

	public void DespawnLobbyPlayer(Friend friend)
	{
		int num = this.steamToLobbyId[friend.Id.Value];
		this.lobbyPlayers[num].SetActive(false);
		this.playerNames[num].text = "";
		this.steamToLobbyId.Remove(friend.Id.Value);
		this.playerNames[num].text = "";
	}

	private int GetNextId()
	{
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			if (!this.lobbyPlayers[i].activeInHierarchy)
			{
				return i;
			}
		}
		return -1;
	}

	public void ExitGame()
	{
		Application.Quit(0);
	}

	private Dictionary<ulong, int> steamToLobbyId = new Dictionary<ulong, int>();

	public GameObject[] lobbyPlayers;

	public TextMeshProUGUI[] playerNames;

	public TextMeshProUGUI lobbyId;

	private Lobby currentLobby;

	public MenuUI menuUi;

	public static LobbyVisuals Instance;
}
