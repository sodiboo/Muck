using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SteamManager : MonoBehaviour
{
	public string PlayerName { get; set; }

	public SteamId PlayerSteamId { get; set; }

	public string PlayerSteamIdString
	{
		get
		{
			return this.playerSteamIdString;
		}
	}

	public Friend LobbyPartner
	{
		get
		{
			return this.lobbyPartner;
		}
		set
		{
			this.lobbyPartner = value;
		}
	}

	public SteamId lobbyOwnerSteamId { get; set; }

	public bool LobbyPartnerDisconnected { get; set; }

	public void Awake()
	{
		if (SteamManager.Instance == null)
		{
			this.daRealOne = true;
			DontDestroyOnLoad(base.gameObject);
			SteamManager.Instance = this;
			this.PlayerName = "";
			try
			{
				SteamClient.Init(SteamManager.gameAppId, true);
				if (!SteamClient.IsValid)
				{
					Debug.Log("Steam client not valid");
					throw new Exception();
				}
				this.PlayerName = SteamClient.Name;
				this.PlayerSteamId = SteamClient.SteamId;
				this.playerSteamIdString = this.PlayerSteamId.ToString();
				this.activeUnrankedLobbies = new List<Lobby>();
				this.activeRankedLobbies = new List<Lobby>();
				this.connectedToSteam = true;
				Debug.Log("Steam initialized: " + this.PlayerName);
				return;
			}
			catch (Exception message)
			{
				this.connectedToSteam = false;
				this.playerSteamIdString = "NoSteamId";
				Debug.Log("Error connecting to Steam");
				Debug.Log(message);
				return;
			}
		}
		if (SteamManager.Instance != this)
		{
			Destroy(base.gameObject);
		}
	}

	public bool TryToReconnectToSteam()
	{
		Debug.Log("Attempting to reconnect to Steam");
		bool result;
		try
		{
			SteamClient.Init(SteamManager.gameAppId, true);
			if (!SteamClient.IsValid)
			{
				Debug.Log("Steam client not valid");
				throw new Exception();
			}
			this.PlayerName = SteamClient.Name;
			this.PlayerSteamId = SteamClient.SteamId;
			this.activeUnrankedLobbies = new List<Lobby>();
			this.activeRankedLobbies = new List<Lobby>();
			Debug.Log("Steam initialized: " + this.PlayerName);
			this.connectedToSteam = true;
			result = true;
		}
		catch (Exception message)
		{
			this.connectedToSteam = false;
			Debug.Log("Error connecting to Steam");
			Debug.Log(message);
			result = false;
		}
		return result;
	}

	public bool ConnectedToSteam()
	{
		return this.connectedToSteam;
	}

	public void StartLobby()
	{
		this.CreateLobby(0);
	}

	public void StopLobby()
	{
		this.leaveLobby();
	}

	private void Start()
	{
		SteamMatchmaking.OnLobbyGameCreated += this.OnLobbyGameCreatedCallback;
		SteamMatchmaking.OnLobbyCreated += this.OnLobbyCreatedCallback;
		SteamMatchmaking.OnLobbyEntered += this.OnLobbyEnteredCallback;
		SteamMatchmaking.OnLobbyMemberJoined += this.OnLobbyMemberJoinedCallback;
		SteamMatchmaking.OnChatMessage += this.OnChatMessageCallback;
		SteamMatchmaking.OnLobbyMemberDisconnected += this.OnLobbyMemberDisconnectedCallback;
		SteamMatchmaking.OnLobbyMemberLeave += this.OnLobbyMemberLeaveCallback;
		SteamFriends.OnGameLobbyJoinRequested += this.OnGameLobbyJoinRequestedCallback;
		SceneManager.sceneLoaded += this.OnSceneLoaded;
		this.UpdateRichPresenceStatus(SceneManager.GetActiveScene().name);
	}

	private void Update()
	{
		SteamClient.RunCallbacks();
	}

	private void OnDisable()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	private void OnDestroy()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	private void OnApplicationQuit()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	private void gameCleanup()
	{
		if (!this.applicationHasQuit)
		{
			this.applicationHasQuit = true;
			this.leaveLobby();
			SteamClient.Shutdown();
		}
	}

	private void OnLobbyMemberDisconnectedCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	private void OnLobbyMemberLeaveCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	private void OtherLobbyMemberLeft(Friend friend)
	{
		if (friend.Id.Value == this.PlayerSteamId.Value)
		{
			return;
		}
		Debug.LogError("someone is leaving lobby");
		if (friend.Id != this.PlayerSteamId)
		{
			this.LobbyPartnerDisconnected = true;
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
		if (this.originalLobbyOwnerId.Value == this.PlayerSteamId.Value)
		{
			Debug.LogError("player left sucess");
			SteamLobby.Instance.RemovePlayerFromLobby(friend);
		}
		if (this.originalLobbyOwnerId.Value == friend.Id.Value)
		{
			this.leaveLobby();
			StatusMessage.Instance.DisplayMessage("Server host left the lobby...");
			if (GameManager.instance)
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
		if (lobby.Id.Value == this.currentLobby.Id.Value)
		{
			Debug.LogError("Attempted to join the same lobby twice...");
		}
		else
		{
			LocalClient.serverOwner = false;
			this.leaveLobby();
			if (await lobby.Join() != RoomEnter.Success)
			{
				Debug.Log("failed to join lobby");
				StatusMessage.Instance.DisplayMessage("Couldn't find lobby. Make sure it's a valid lobbyID from someone");
			}
			else
			{
				this.currentLobby = lobby;
				this.lobbyOwnerSteamId = lobby.Owner.Id.Value;
				this.LobbyPartnerDisconnected = false;
				this.AcceptP2P(this.lobbyOwnerSteamId);
			}
		}
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
		if (friend.Id != this.PlayerSteamId)
		{
			Debug.Log("incoming chat message");
			Debug.Log(message);
			lobby.SetGameServer(this.PlayerSteamId);
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
			StatusMessage.Instance.DisplayMessage(string.Concat(new string[]
			{
				"You're on version ",
				version,
				", but server is on ",
				data,
				". Update your game on Steam to play.\n<size=60%>If there is no update button, right click on the game > manage > uninstall, then install again"
			}));
			this.leaveLobby();
			return;
		}
		LobbyVisuals.Instance.OpenLobby(lobby);
		LocalClient.serverOwner = false;
		this.originalLobbyOwnerId = lobby.Owner.Id.Value;
		if (lobby.MemberCount != 1)
		{
			this.AcceptP2P(this.originalLobbyOwnerId);
			lobby.SendChatString("incoming player info");
		}
	}

	private async void OnGameLobbyJoinRequestedCallback(Lobby joinedLobby, SteamId id)
	{
		Debug.LogError("trying to join lobby");
		if (joinedLobby.Id.Value == this.currentLobby.Id.Value)
		{
			Debug.LogError("Attempted to join the same lobby twice...");
		}
		else
		{
			LocalClient.serverOwner = false;
			this.leaveLobby();
			if (await joinedLobby.Join() != RoomEnter.Success)
			{
				Debug.Log("failed to join lobby");
			}
			else
			{
				this.currentLobby = joinedLobby;
				this.lobbyOwnerSteamId = joinedLobby.Owner.Id.Value;
				this.LobbyPartnerDisconnected = false;
				this.AcceptP2P(this.lobbyOwnerSteamId);
				Debug.LogError("Join success");
			}
		}
	}

	private void OnLobbyCreatedCallback(Result result, Lobby lobby)
	{
		Debug.LogError("lobbyu created opkay");
		this.LobbyPartnerDisconnected = false;
		if (result != Result.OK)
		{
			Debug.Log("lobby creation result not ok");
			Debug.Log(result.ToString());
		}
		this.lobbyOwnerSteamId = this.PlayerSteamId;
		lobby.SetData("Version", Application.version);
		Debug.Log("on version: " + lobby.GetData("Version"));
		SteamLobby.Instance.StartLobby(this.PlayerSteamId, lobby);
	}

	private void OnLobbyMemberJoinedCallback(Lobby lobby, Friend friend)
	{
		Debug.Log("someone else joined lobby");
		if (friend.Id != this.PlayerSteamId)
		{
			this.LobbyPartner = friend;
			this.lobbyOwnerSteamId = lobby.Owner.Id.Value;
			this.AcceptP2P(this.lobbyOwnerSteamId);
			this.LobbyPartnerDisconnected = false;
			LobbyVisuals.Instance.SpawnLobbyPlayer(friend);
		}
		if (this.currentLobby.Owner.Id.Value == this.PlayerSteamId)
		{
			SteamLobby.Instance.AddPlayerToLobby(friend);
		}
	}

	public void leaveLobby()
	{
		try
		{
			if (this.currentLobby.Owner.Id.Value == this.PlayerSteamId.Value)
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
			this.currentLobby.Leave();
			Debug.Log("Lobby left successfully");
		}
		catch
		{
			Debug.Log("Error leaving current lobby");
		}
		try
		{
			SteamNetworking.CloseP2PSessionWithUser(this.lobbyOwnerSteamId);
		}
		catch
		{
			Debug.Log("Error closing P2P session with opponent");
		}
		this.currentLobby = default(Lobby);
	}

	public async Task<bool> CreateFriendLobby()
	{
		bool result;
		try
		{
			Lobby? lobby = await SteamMatchmaking.CreateLobbyAsync(8);
			if (lobby == null)
			{
				Debug.Log("Lobby created but not correctly instantiated");
				throw new Exception();
			}
			this.LobbyPartnerDisconnected = false;
			this.hostedMultiplayerLobby = lobby.Value;
			this.hostedMultiplayerLobby.SetFriendsOnly();
			this.currentLobby = this.hostedMultiplayerLobby;
			this.hostedMultiplayerLobby.SetData("Version", Application.version ?? "");
			result = true;
		}
		catch (Exception ex)
		{
			Debug.Log("Failed to create multiplayer lobby");
			Debug.Log(ex.ToString());
			result = false;
		}
		return result;
	}

	public async Task<bool> CreateLobby(int lobbyParameters)
	{
		bool result;
		try
		{
			Lobby? lobby = await SteamMatchmaking.CreateLobbyAsync(8);
			if (lobby == null)
			{
				Debug.Log("Lobby created but not correctly instantiated");
				throw new Exception();
			}
			this.LobbyPartnerDisconnected = false;
			this.hostedMultiplayerLobby = lobby.Value;
			this.hostedMultiplayerLobby.SetPublic();
			this.hostedMultiplayerLobby.SetJoinable(true);
			this.hostedMultiplayerLobby.SetData("Version", Application.version ?? "");
			this.currentLobby = this.hostedMultiplayerLobby;
			result = true;
		}
		catch (Exception ex)
		{
			Debug.Log("Failed to create multiplayer lobby");
			StatusMessage.Instance.DisplayMessage("Failed to connect to Steam, can't start a lobby. \n<size=72%><i>Make sure you have an internet connection on a valid steam account");
			Debug.Log(ex.ToString());
			this.TryToReconnectToSteam();
			result = false;
		}
		return result;
	}

	public void OpenFriendOverlayForGameInvite()
	{
		SteamFriends.OpenGameInviteOverlay(this.currentLobby.Id);
	}

	private void OnSceneLoaded(Scene scene, LoadSceneMode loadSceneMode)
	{
		this.UpdateRichPresenceStatus(scene.name);
	}

	public void UpdateRichPresenceStatus(string SceneName)
	{
		if (this.connectedToSteam)
		{
			string key = "steam_display";
			if (SceneName.Equals("SillyScene"))
			{
				SteamFriends.SetRichPresence(key, "#SillyScene");
				return;
			}
			if (SceneName.Contains("SillyScene2"))
			{
				SteamFriends.SetRichPresence(key, "#SillyScene2");
			}
		}
	}

	public static SteamManager Instance;

	private static uint gameAppId = 1625450U;

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
}
