using System;
using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using TMPro;
using UnityEngine;

// Token: 0x02000050 RID: 80
public class LobbyVisuals : MonoBehaviour
{
	// Token: 0x060001AD RID: 429 RVA: 0x0000E898 File Offset: 0x0000CA98
	private void Awake()
	{
		LobbyVisuals.Instance = this;
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
	}

	// Token: 0x060001AE RID: 430 RVA: 0x00003418 File Offset: 0x00001618
	private void Start()
	{
		MusicController.Instance.PlaySong(MusicController.SongType.Day, false);
	}

	// Token: 0x060001AF RID: 431 RVA: 0x00003426 File Offset: 0x00001626
	public void CopyLobbyId()
	{
		GUIUtility.systemCopyBuffer = string.Concat(this.currentLobby.Id.Value);
	}

	// Token: 0x060001B0 RID: 432 RVA: 0x0000E8E0 File Offset: 0x0000CAE0
	public void CloseLobby()
	{
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
		this.menuUi.LeaveLobby();
	}

	// Token: 0x060001B1 RID: 433 RVA: 0x0000E92C File Offset: 0x0000CB2C
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

	// Token: 0x060001B2 RID: 434 RVA: 0x0000EA70 File Offset: 0x0000CC70
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

	// Token: 0x060001B3 RID: 435 RVA: 0x0000EAF0 File Offset: 0x0000CCF0
	public void DespawnLobbyPlayer(Friend friend)
	{
		int num = this.steamToLobbyId[friend.Id.Value];
		this.lobbyPlayers[num].SetActive(false);
		this.playerNames[num].text = "";
		this.steamToLobbyId.Remove(friend.Id.Value);
		this.playerNames[num].text = "";
	}

	// Token: 0x060001B4 RID: 436 RVA: 0x0000EB60 File Offset: 0x0000CD60
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

	// Token: 0x060001B5 RID: 437 RVA: 0x00003447 File Offset: 0x00001647
	public void ExitGame()
	{
		Application.Quit(0);
	}

	// Token: 0x040001C2 RID: 450
	private Dictionary<ulong, int> steamToLobbyId = new Dictionary<ulong, int>();

	// Token: 0x040001C3 RID: 451
	public GameObject[] lobbyPlayers;

	// Token: 0x040001C4 RID: 452
	public TextMeshProUGUI[] playerNames;

	// Token: 0x040001C5 RID: 453
	public TextMeshProUGUI lobbyId;

	// Token: 0x040001C6 RID: 454
	private Lobby currentLobby;

	// Token: 0x040001C7 RID: 455
	public MenuUI menuUi;

	// Token: 0x040001C8 RID: 456
	public static LobbyVisuals Instance;
}
