using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SteamManager : MonoBehaviour
{
    public static SteamManager Instance;

    private static uint gameAppId = 1625450u;

    private string playerSteamIdString;

    private bool connectedToSteam;

    private Friend lobbyPartner;

    public List<Lobby> activeUnrankedLobbies;

    public List<Lobby> activeRankedLobbies;

    public Lobby currentLobby;

    private Lobby hostedMultiplayerLobby;

    private SteamId originalLobbyOwnerId;

    private bool applicationHasQuit;

    private bool daRealOne;

    public string PlayerName { get; set; }

    public SteamId PlayerSteamId { get; set; }

    public string PlayerSteamIdString => playerSteamIdString;

    public Friend LobbyPartner
    {
        get
        {
            return lobbyPartner;
        }
        set
        {
            lobbyPartner = value;
        }
    }

    public SteamId lobbyOwnerSteamId { get; set; }

    public bool LobbyPartnerDisconnected { get; set; }

    public void Awake()
    {
        if (Instance == null)
        {
            daRealOne = true;
            UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
            Instance = this;
            PlayerName = "";
            try
            {
                SteamClient.Init(gameAppId);
                if (!SteamClient.IsValid)
                {
                    Debug.Log("Steam client not valid");
                    throw new Exception();
                }
                PlayerName = SteamClient.Name;
                PlayerSteamId = SteamClient.SteamId;
                playerSteamIdString = PlayerSteamId.ToString();
                activeUnrankedLobbies = new List<Lobby>();
                activeRankedLobbies = new List<Lobby>();
                connectedToSteam = true;
                Debug.Log("Steam initialized: " + PlayerName);
            }
            catch (Exception message)
            {
                connectedToSteam = false;
                playerSteamIdString = "NoSteamId";
                Debug.Log("Error connecting to Steam");
                Debug.Log(message);
            }
        }
        else if (Instance != this)
        {
            UnityEngine.Object.Destroy(base.gameObject);
        }
    }

    public bool TryToReconnectToSteam()
    {
        Debug.Log("Attempting to reconnect to Steam");
        try
        {
            SteamClient.Init(gameAppId);
            if (!SteamClient.IsValid)
            {
                Debug.Log("Steam client not valid");
                throw new Exception();
            }
            PlayerName = SteamClient.Name;
            PlayerSteamId = SteamClient.SteamId;
            activeUnrankedLobbies = new List<Lobby>();
            activeRankedLobbies = new List<Lobby>();
            Debug.Log("Steam initialized: " + PlayerName);
            connectedToSteam = true;
            return true;
        }
        catch (Exception message)
        {
            connectedToSteam = false;
            Debug.Log("Error connecting to Steam");
            Debug.Log(message);
            return false;
        }
    }

    public bool ConnectedToSteam()
    {
        return connectedToSteam;
    }

    public void StartLobby()
    {
        CreateLobby(0);
    }

    public void StopLobby()
    {
        leaveLobby();
    }

    private void Start()
    {
        SteamMatchmaking.OnLobbyGameCreated += OnLobbyGameCreatedCallback;
        SteamMatchmaking.OnLobbyCreated += OnLobbyCreatedCallback;
        SteamMatchmaking.OnLobbyEntered += OnLobbyEnteredCallback;
        SteamMatchmaking.OnLobbyMemberJoined += OnLobbyMemberJoinedCallback;
        SteamMatchmaking.OnChatMessage += OnChatMessageCallback;
        SteamMatchmaking.OnLobbyMemberDisconnected += OnLobbyMemberDisconnectedCallback;
        SteamMatchmaking.OnLobbyMemberLeave += OnLobbyMemberLeaveCallback;
        SteamFriends.OnGameLobbyJoinRequested += OnGameLobbyJoinRequestedCallback;
        SceneManager.sceneLoaded += OnSceneLoaded;
        UpdateRichPresenceStatus(SceneManager.GetActiveScene().name);
    }

    private void Update()
    {
        SteamClient.RunCallbacks();
    }

    private void OnDisable()
    {
        if (daRealOne)
        {
            gameCleanup();
        }
    }

    private void OnDestroy()
    {
        if (daRealOne)
        {
            gameCleanup();
        }
    }

    private void OnApplicationQuit()
    {
        if (daRealOne)
        {
            gameCleanup();
        }
    }

    private void gameCleanup()
    {
        if (!applicationHasQuit)
        {
            applicationHasQuit = true;
            leaveLobby();
            SteamClient.Shutdown();
        }
    }

    private void OnLobbyMemberDisconnectedCallback(Lobby lobby, Friend friend)
    {
        OtherLobbyMemberLeft(friend);
    }

    private void OnLobbyMemberLeaveCallback(Lobby lobby, Friend friend)
    {
        OtherLobbyMemberLeft(friend);
    }

    private void OtherLobbyMemberLeft(Friend friend)
    {
        if (friend.Id.Value == PlayerSteamId.Value)
        {
            return;
        }
        Debug.LogError("someone is leaving lobby");
        if ((ulong)friend.Id != (ulong)PlayerSteamId)
        {
            LobbyPartnerDisconnected = true;
            LobbyVisuals.Instance.DespawnLobbyPlayer(friend);
            try
            {
                SteamNetworking.CloseP2PSessionWithUser(friend.Id);
            }
            catch
            {
                Debug.Log("Unable to update disconnected player nameplate / process disconnect cleanly");
            }
        }
        if (originalLobbyOwnerId.Value == PlayerSteamId.Value)
        {
            Debug.LogError("player left sucess");
            SteamLobby.Instance.RemovePlayerFromLobby(friend);
        }
        if (originalLobbyOwnerId.Value == friend.Id.Value)
        {
            leaveLobby();
            StatusMessage.Instance.DisplayMessage("Server host left the lobby...");
            if ((bool)GameManager.instance)
            {
                GameManager.instance.LeaveGame();
            }
        }
    }

    private void OnLobbyGameCreatedCallback(Lobby lobby, uint ip, ushort port, SteamId steamId)
    {
    }

    public async void JoinLobby(Lobby lobby)
    {
        if (lobby.Id.Value == currentLobby.Id.Value)
        {
            Debug.LogError("Attempted to join the same lobby twice...");
            return;
        }
        LocalClient.serverOwner = false;
        leaveLobby();
        if (await lobby.Join() != RoomEnter.Success)
        {
            Debug.Log("failed to join lobby");
            StatusMessage.Instance.DisplayMessage("Couldn't find lobby. Make sure it's a valid lobbyID from someone");
            return;
        }
        currentLobby = lobby;
        lobbyOwnerSteamId = lobby.Owner.Id.Value;
        LobbyPartnerDisconnected = false;
        AcceptP2P(lobbyOwnerSteamId);
    }

    private void AcceptP2P(SteamId opponentId)
    {
        try
        {
            SteamNetworking.AcceptP2PSessionWithUser(opponentId);
        }
        catch
        {
            Debug.Log("Unable to accept P2P Session with user");
        }
    }

    private void OnChatMessageCallback(Lobby lobby, Friend friend, string message)
    {
        if ((ulong)friend.Id != (ulong)PlayerSteamId)
        {
            Debug.Log("incoming chat message");
            Debug.Log(message);
            lobby.SetGameServer(PlayerSteamId);
        }
    }

    private void OnLobbyEnteredCallback(Lobby lobby)
    {
        if (lobby.MemberCount < 1)
        {
            lobby.Leave();
            return;
        }
        string version = Application.version;
        string data = lobby.GetData("Version");
        if (version != data)
        {
            StatusMessage.Instance.DisplayMessage("You're on version " + version + ", but server is on " + data + ". Update your game on Steam to play.\n<size=60%>If there is no update button, right click on the game > manage > uninstall, then install again");
            leaveLobby();
        }
        else
        {
            LobbyVisuals.Instance.OpenLobby(lobby);
            LocalClient.serverOwner = false;
            originalLobbyOwnerId = lobby.Owner.Id.Value;
            if (lobby.MemberCount != 1)
            {
                AcceptP2P(originalLobbyOwnerId);
                lobby.SendChatString("incoming player info");
            }
        }
    }

    private async void OnGameLobbyJoinRequestedCallback(Lobby joinedLobby, SteamId id)
    {
        Debug.LogError("trying to join lobby");
        if (joinedLobby.Id.Value == currentLobby.Id.Value)
        {
            Debug.LogError("Attempted to join the same lobby twice...");
            return;
        }
        LocalClient.serverOwner = false;
        leaveLobby();
        if (await joinedLobby.Join() != RoomEnter.Success)
        {
            Debug.Log("failed to join lobby");
            return;
        }
        currentLobby = joinedLobby;
        lobbyOwnerSteamId = joinedLobby.Owner.Id.Value;
        LobbyPartnerDisconnected = false;
        AcceptP2P(lobbyOwnerSteamId);
        Debug.LogError("Join success");
    }

    private void OnLobbyCreatedCallback(Result result, Lobby lobby)
    {
        Debug.LogError("lobbyu created opkay");
        LobbyPartnerDisconnected = false;
        if (result != Result.OK)
        {
            Debug.Log("lobby creation result not ok");
            Debug.Log(result.ToString());
        }
        lobbyOwnerSteamId = PlayerSteamId;
        lobby.SetData("Version", Application.version);
        Debug.Log("on version: " + lobby.GetData("Version"));
        SteamLobby.Instance.StartLobby(PlayerSteamId, lobby);
    }

    private void OnLobbyMemberJoinedCallback(Lobby lobby, Friend friend)
    {
        Debug.Log("someone else joined lobby");
        if ((ulong)friend.Id != (ulong)PlayerSteamId)
        {
            LobbyPartner = friend;
            lobbyOwnerSteamId = lobby.Owner.Id.Value;
            AcceptP2P(lobbyOwnerSteamId);
            LobbyPartnerDisconnected = false;
            LobbyVisuals.Instance.SpawnLobbyPlayer(friend);
        }
        if (currentLobby.Owner.Id.Value == (ulong)PlayerSteamId)
        {
            SteamLobby.Instance.AddPlayerToLobby(friend);
        }
    }

    public void leaveLobby()
    {
        try
        {
            if (currentLobby.Owner.Id.Value == PlayerSteamId.Value)
            {
                SteamLobby.Instance.CloseLobby();
            }
        }
        catch
        {
            Debug.Log("Steam lobby doesn't exist...");
        }
        if (!GameManager.instance)
        {
            LobbyVisuals.Instance.CloseLobby();
        }
        try
        {
            currentLobby.Leave();
            Debug.Log("Lobby left successfully");
        }
        catch
        {
            Debug.Log("Error leaving current lobby");
        }
        try
        {
            SteamNetworking.CloseP2PSessionWithUser(lobbyOwnerSteamId);
        }
        catch
        {
            Debug.Log("Error closing P2P session with opponent");
        }
        currentLobby = default(Lobby);
    }

    public async Task<bool> CreateFriendLobby()
    {
        try
        {
            Lobby? lobby = await SteamMatchmaking.CreateLobbyAsync(8);
            if (!lobby.HasValue)
            {
                Debug.Log("Lobby created but not correctly instantiated");
                throw new Exception();
            }
            LobbyPartnerDisconnected = false;
            hostedMultiplayerLobby = lobby.Value;
            hostedMultiplayerLobby.SetFriendsOnly();
            currentLobby = hostedMultiplayerLobby;
            hostedMultiplayerLobby.SetData("Version", Application.version ?? "");
            return true;
        }
        catch (Exception ex)
        {
            Debug.Log("Failed to create multiplayer lobby");
            Debug.Log(ex.ToString());
            return false;
        }
    }

    public async Task<bool> CreateLobby(int lobbyParameters)
    {
        try
        {
            Lobby? lobby = await SteamMatchmaking.CreateLobbyAsync(8);
            if (!lobby.HasValue)
            {
                Debug.Log("Lobby created but not correctly instantiated");
                throw new Exception();
            }
            LobbyPartnerDisconnected = false;
            hostedMultiplayerLobby = lobby.Value;
            hostedMultiplayerLobby.SetPublic();
            hostedMultiplayerLobby.SetJoinable(b: true);
            hostedMultiplayerLobby.SetData("Version", Application.version ?? "");
            currentLobby = hostedMultiplayerLobby;
            return true;
        }
        catch (Exception ex)
        {
            Debug.Log("Failed to create multiplayer lobby");
            StatusMessage.Instance.DisplayMessage("Failed to connect to Steam, can't start a lobby. \n<size=72%><i>Make sure you have an internet connection on a valid steam account");
            Debug.Log(ex.ToString());
            TryToReconnectToSteam();
            return false;
        }
    }

    public void OpenFriendOverlayForGameInvite()
    {
        SteamFriends.OpenGameInviteOverlay(currentLobby.Id);
    }

    private void OnSceneLoaded(Scene scene, LoadSceneMode loadSceneMode)
    {
        UpdateRichPresenceStatus(scene.name);
    }

    public void UpdateRichPresenceStatus(string SceneName)
    {
        if (connectedToSteam)
        {
            string key = "steam_display";
            if (SceneName.Equals("SillyScene"))
            {
                SteamFriends.SetRichPresence(key, "#SillyScene");
            }
            else if (SceneName.Contains("SillyScene2"))
            {
                SteamFriends.SetRichPresence(key, "#SillyScene2");
            }
        }
    }
}
