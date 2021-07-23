using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using TMPro;
using UnityEngine;

public class LobbyVisuals : MonoBehaviour
{
    private Dictionary<ulong, int> steamToLobbyId = new Dictionary<ulong, int>();

    public GameObject[] lobbyPlayers;

    public TextMeshProUGUI[] playerNames;

    public TextMeshProUGUI lobbyId;

    private Lobby currentLobby;

    public MenuUI menuUi;

    public static LobbyVisuals Instance;

    public OnlyActivateForHost[] lobbyPlayerNames;

    private void Awake()
    {
        Instance = this;
        for (int i = 0; i < lobbyPlayers.Length; i++)
        {
            lobbyPlayers[i].SetActive(value: false);
            lobbyPlayerNames[i].gameObject.SetActive(value: false);
            playerNames[i].text = "";
        }
    }

    private void Start()
    {
        MusicController.Instance.PlaySong(MusicController.SongType.Day, chanceToSkip: false);
    }

    public void CopyLobbyId()
    {
        GUIUtility.systemCopyBuffer = string.Concat(currentLobby.Id.Value);
    }

    public void CloseLobby()
    {
        for (int i = 0; i < lobbyPlayers.Length; i++)
        {
            lobbyPlayerNames[i].gameObject.SetActive(value: false);
            playerNames[i].text = "";
            lobbyPlayers[i].SetActive(value: false);
        }
        menuUi.LeaveLobby();
    }

    public void OpenLobby(Lobby lobby)
    {
        steamToLobbyId = new Dictionary<ulong, int>();
        currentLobby = lobby;
        NetworkController.Instance.lobby = currentLobby;
        LocalClient.instance.serverHost = lobby.Owner.Id.Value;
        string text = string.Concat(lobby.Id.Value);
        lobbyId.text = "Lobby ID: (send to friend)<size=90%>\n" + text;
        if (SteamManager.Instance.PlayerSteamId.Value != (ulong)lobby.Owner.Id)
        {
            LobbySettings.Instance.startButton.SetActive(value: false);
        }
        else
        {
            LobbySettings.Instance.startButton.SetActive(value: true);
        }
        foreach (Friend member in lobby.Members)
        {
            int nextId = GetNextId();
            if (nextId == -1)
            {
                return;
            }
            SteamId steamId = member.Id.Value;
            steamToLobbyId[steamId] = nextId;
            SpawnLobbyPlayer(new Friend(steamId));
        }
        menuUi.JoinLobby();
        OnlyActivateForHost[] array = lobbyPlayerNames;
        for (int i = 0; i < array.Length; i++)
        {
            array[i].kickBtn.SetActive(SteamManager.Instance.PlayerSteamId.Value == (ulong)lobby.Owner.Id);
        }
    }

    public void SpawnLobbyPlayer(Friend friend)
    {
        MonoBehaviour.print("spawning lobby player: " + friend.Name);
        int nextId = GetNextId();
        string text = friend.Name;
        steamToLobbyId[friend.Id.Value] = nextId;
        lobbyPlayers[nextId].SetActive(value: true);
        lobbyPlayers[nextId].GetComponentInChildren<TextMeshProUGUI>().text = text;
        playerNames[nextId].text = friend.Name;
        lobbyPlayerNames[nextId].gameObject.SetActive(value: true);
        lobbyPlayerNames[nextId].steamId = friend.Id.Value;
    }

    public void DespawnLobbyPlayer(Friend friend)
    {
        int num = steamToLobbyId[friend.Id.Value];
        lobbyPlayers[num].SetActive(value: false);
        playerNames[num].text = "";
        steamToLobbyId.Remove(friend.Id.Value);
        playerNames[num].text = "";
        lobbyPlayerNames[num].gameObject.SetActive(value: false);
    }

    private int GetNextId()
    {
        for (int i = 0; i < lobbyPlayers.Length; i++)
        {
            if (!lobbyPlayers[i].activeInHierarchy)
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
}
