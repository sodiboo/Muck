
using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using TMPro;
using UnityEngine;

// Token: 0x02000043 RID: 67
public class LobbyVisuals : MonoBehaviour
{
	// Token: 0x06000185 RID: 389 RVA: 0x00009DD0 File Offset: 0x00007FD0
	private void Awake()
	{
		LobbyVisuals.Instance = this;
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
	}

	// Token: 0x06000186 RID: 390 RVA: 0x00009E16 File Offset: 0x00008016
	private void Start()
	{
		MusicController.Instance.PlaySong(MusicController.SongType.Day, false);
	}

	// Token: 0x06000187 RID: 391 RVA: 0x00009E24 File Offset: 0x00008024
	public void CopyLobbyId()
	{
		GUIUtility.systemCopyBuffer = string.Concat(this.currentLobby.Id.Value);
	}

	// Token: 0x06000188 RID: 392 RVA: 0x00009E48 File Offset: 0x00008048
	public void CloseLobby()
	{
		for (int i = 0; i < this.lobbyPlayers.Length; i++)
		{
			this.lobbyPlayers[i].SetActive(false);
			this.playerNames[i].text = "";
		}
		this.menuUi.LeaveLobby();
	}

	// Token: 0x06000189 RID: 393 RVA: 0x00009E94 File Offset: 0x00008094
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

	// Token: 0x0600018A RID: 394 RVA: 0x00009FD8 File Offset: 0x000081D8
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

	// Token: 0x0600018B RID: 395 RVA: 0x0000A058 File Offset: 0x00008258
	public void DespawnLobbyPlayer(Friend friend)
	{
		int num = this.steamToLobbyId[friend.Id.Value];
		this.lobbyPlayers[num].SetActive(false);
		this.playerNames[num].text = "";
		this.steamToLobbyId.Remove(friend.Id.Value);
		this.playerNames[num].text = "";
	}

	// Token: 0x0600018C RID: 396 RVA: 0x0000A0C8 File Offset: 0x000082C8
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

	// Token: 0x0600018D RID: 397 RVA: 0x0000A0FA File Offset: 0x000082FA
	public void ExitGame()
	{
		Application.Quit(0);
	}

	// Token: 0x0400018D RID: 397
	private Dictionary<ulong, int> steamToLobbyId = new Dictionary<ulong, int>();

	// Token: 0x0400018E RID: 398
	public GameObject[] lobbyPlayers;

	// Token: 0x0400018F RID: 399
	public TextMeshProUGUI[] playerNames;

	// Token: 0x04000190 RID: 400
	public TextMeshProUGUI lobbyId;

	// Token: 0x04000191 RID: 401
	private Lobby currentLobby;

	// Token: 0x04000192 RID: 402
	public MenuUI menuUi;

	// Token: 0x04000193 RID: 403
	public static LobbyVisuals Instance;
}
