using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

public class SteamLobby : MonoBehaviour
{
    private Lobby currentLobby;

    public static Dictionary<ulong, int> steamIdToClientId = new Dictionary<ulong, int>();

    public GameObject startButton;

    public static int lobbySize = 10;

    private bool started;

    public static SteamLobby Instance;

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

    private void InitLobby(Lobby l)
    {
        currentLobby = l;
        InitLobbyClients();
        steamIdToClientId = new Dictionary<ulong, int>();
    }

    public void StartLobby(SteamId hostSteamId, Lobby l)
    {
        InitLobby(l);
        LobbySettings.Instance.startButton.SetActive(value: true);
        AddPlayerToLobby(new Friend(hostSteamId));
        started = false;
    }

    public void CloseLobby()
    {
        steamIdToClientId = new Dictionary<ulong, int>();
        startButton.SetActive(value: false);
        started = false;
    }

    public void AddPlayerToLobby(Friend friend)
    {
        SteamId steamId = friend.Id.Value;
        int num = FindAvailableLobbyId();
        if (num != -1)
        {
            Debug.Log("Found available id in steam as: " + num + ", steam name: " + friend.Name);
            steamIdToClientId[steamId] = num;
            Client client = Server.clients[num];
            client.inLobby = true;
            Player player = (client.player = new Player(num, friend.Name, UnityEngine.Color.black, steamId));
            MonoBehaviour.print("finished adding player");
        }
    }

    public void RemovePlayerFromLobby(Friend friend)
    {
        SteamId steamId = friend.Id.Value;
        int num = steamIdToClientId[steamId.Value];
        Server.clients[num] = new Client(num);
        steamIdToClientId.Remove(friend.Id.Value);
        if (started && (bool)GameManager.instance)
        {
            ServerSend.DisconnectPlayer(num);
        }
    }

    private void InitLobbyClients()
    {
        MonoBehaviour.print("initing lobby");
        Server.clients = new Dictionary<int, Client>();
        for (int i = 0; i < lobbySize; i++)
        {
            Server.clients[i] = new Client(i);
        }
    }

    private int FindAvailableLobbyId()
    {
        for (int i = 0; i < lobbySize; i++)
        {
            if (!Server.clients[i].inLobby)
            {
                return i;
            }
        }
        return -1;
    }

    public void StartGame()
    {
        if (SteamClient.SteamId.Value != currentLobby.Owner.Id.Value)
        {
            Debug.LogError("not owner, so cant start lobby");
            return;
        }
        MonoBehaviour.print("starting lobby");
        GameSettings gameSettings = MakeSettings();
        if (gameSettings.gameMode == GameSettings.GameMode.Versus && currentLobby.MemberCount < 2)
        {
            StatusMessage.Instance.DisplayMessage("Need at least 2 players to play versus.");
            return;
        }
        foreach (Client value in Server.clients.Values)
        {
            MonoBehaviour.print(value);
            if (value != null)
            {
                MonoBehaviour.print(value.player);
            }
            if (value?.player != null)
            {
                MonoBehaviour.print("sending start game");
                ServerSend.StartGame(value.player.id, gameSettings);
            }
        }
        currentLobby.SetJoinable(b: false);
        started = true;
        MonoBehaviour.print("Starting game done");
        LocalClient.serverOwner = true;
        LocalClient.instance.serverHost = SteamManager.Instance.PlayerSteamId;
    }

    private int FindSeed()
    {
        int num = 0;
        string text = LobbySettings.Instance.seed.text;
        if (text == "")
        {
            return Random.Range(int.MinValue, int.MaxValue);
        }
        if (int.TryParse(text, out var result))
        {
            return result;
        }
        return text.GetHashCode();
    }

    private GameSettings MakeSettings()
    {
        GameSettings gameSettings = new GameSettings(FindSeed());
        gameSettings.difficulty = (GameSettings.Difficulty)LobbySettings.Instance.difficultySetting.setting;
        gameSettings.friendlyFire = (GameSettings.FriendlyFire)LobbySettings.Instance.friendlyFireSetting.setting;
        gameSettings.gameMode = (GameSettings.GameMode)LobbySettings.Instance.gamemodeSetting.setting;
        gameSettings.multiplayer = (GameSettings.Multiplayer)Mathf.Clamp(currentLobby.MemberCount - 1, 0, 1);
        if (gameSettings.gameMode == GameSettings.GameMode.Versus)
        {
            gameSettings.friendlyFire = GameSettings.FriendlyFire.On;
        }
        return gameSettings;
    }
}
