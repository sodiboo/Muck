using System;
using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using TMPro;
using UnityEngine;

// Token: 0x0200005F RID: 95
public class LobbyVisuals : MonoBehaviour
{
	// Token: 0x06000222 RID: 546 RVA: 0x0000CED8 File Offset: 0x0000B0D8
	private void Awake()
	{
		LobbyVisuals.Instance = this;
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
	}

	// Token: 0x06000223 RID: 547 RVA: 0x0000CF1E File Offset: 0x0000B11E
	private void Start()
	{
		MusicController.Instance.PlaySong(MusicController.SongType.Day, false);
	}

	// Token: 0x06000224 RID: 548 RVA: 0x0000CF2C File Offset: 0x0000B12C
	public void CopyLobbyId()
	{
		GUIUtility.systemCopyBuffer = string.Concat(this.currentLobby.Id.Value);
	}

	// Token: 0x06000225 RID: 549 RVA: 0x0000CF50 File Offset: 0x0000B150
	public void CloseLobby()
	{
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
		this.menuUi.LeaveLobby();
	}

	// Token: 0x06000226 RID: 550 RVA: 0x0000CF9C File Offset: 0x0000B19C
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

	// Token: 0x06000227 RID: 551 RVA: 0x0000D0E0 File Offset: 0x0000B2E0
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

	// Token: 0x06000228 RID: 552 RVA: 0x0000D160 File Offset: 0x0000B360
	public void DespawnLobbyPlayer(Friend friend)
	{
		int num = this.steamToLobbyId[friend.Id.Value];
		this.lobbyPlayers[num].SetActive(false);
		this.playerNames[num].text = "";
		this.steamToLobbyId.Remove(friend.Id.Value);
		this.playerNames[num].text = "";
	}

	// Token: 0x06000229 RID: 553 RVA: 0x0000D1D0 File Offset: 0x0000B3D0
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

	// Token: 0x0600022A RID: 554 RVA: 0x0000D202 File Offset: 0x0000B402
	public void ExitGame()
	{
		Application.Quit(0);
	}

	// Token: 0x04000245 RID: 581
	private Dictionary<ulong, int> steamToLobbyId = new Dictionary<ulong, int>();

	// Token: 0x04000246 RID: 582
	public GameObject[] lobbyPlayers;

	// Token: 0x04000247 RID: 583
	public TextMeshProUGUI[] playerNames;

	// Token: 0x04000248 RID: 584
	public TextMeshProUGUI lobbyId;

	// Token: 0x04000249 RID: 585
	private Lobby currentLobby;

	// Token: 0x0400024A RID: 586
	public MenuUI menuUi;

	// Token: 0x0400024B RID: 587
	public static LobbyVisuals Instance;
}
