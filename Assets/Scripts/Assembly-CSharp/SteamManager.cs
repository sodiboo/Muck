using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x0200011B RID: 283
public class SteamManager : MonoBehaviour
{
	// Token: 0x1700005B RID: 91
	// (get) Token: 0x06000821 RID: 2081 RVA: 0x00029023 File Offset: 0x00027223
	// (set) Token: 0x06000822 RID: 2082 RVA: 0x0002902B File Offset: 0x0002722B
	public string PlayerName { get; set; }

	// Token: 0x1700005C RID: 92
	// (get) Token: 0x06000823 RID: 2083 RVA: 0x00029034 File Offset: 0x00027234
	// (set) Token: 0x06000824 RID: 2084 RVA: 0x0002903C File Offset: 0x0002723C
	public SteamId PlayerSteamId { get; set; }

	// Token: 0x1700005D RID: 93
	// (get) Token: 0x06000825 RID: 2085 RVA: 0x00029045 File Offset: 0x00027245
	public string PlayerSteamIdString
	{
		get
		{
			return this.playerSteamIdString;
		}
	}

	// Token: 0x1700005E RID: 94
	// (get) Token: 0x06000826 RID: 2086 RVA: 0x0002904D File Offset: 0x0002724D
	// (set) Token: 0x06000827 RID: 2087 RVA: 0x00029055 File Offset: 0x00027255
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

	// Token: 0x1700005F RID: 95
	// (get) Token: 0x06000828 RID: 2088 RVA: 0x0002905E File Offset: 0x0002725E
	// (set) Token: 0x06000829 RID: 2089 RVA: 0x00029066 File Offset: 0x00027266
	public SteamId lobbyOwnerSteamId { get; set; }

	// Token: 0x17000060 RID: 96
	// (get) Token: 0x0600082A RID: 2090 RVA: 0x0002906F File Offset: 0x0002726F
	// (set) Token: 0x0600082B RID: 2091 RVA: 0x00029077 File Offset: 0x00027277
	public bool LobbyPartnerDisconnected { get; set; }

	// Token: 0x0600082C RID: 2092 RVA: 0x00029080 File Offset: 0x00027280
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

	// Token: 0x0600082D RID: 2093 RVA: 0x00029194 File Offset: 0x00027394
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

	// Token: 0x0600082E RID: 2094 RVA: 0x00029244 File Offset: 0x00027444
	public bool ConnectedToSteam()
	{
		return this.connectedToSteam;
	}

	// Token: 0x0600082F RID: 2095 RVA: 0x0002924C File Offset: 0x0002744C
	public void StartLobby()
	{
		this.CreateLobby(0);
	}

	// Token: 0x06000830 RID: 2096 RVA: 0x00029256 File Offset: 0x00027456
	public void StopLobby()
	{
		this.leaveLobby();
	}

	// Token: 0x06000831 RID: 2097 RVA: 0x00029260 File Offset: 0x00027460
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

	// Token: 0x06000832 RID: 2098 RVA: 0x00029319 File Offset: 0x00027519
	private void Update()
	{
		SteamClient.RunCallbacks();
	}

	// Token: 0x06000833 RID: 2099 RVA: 0x00029320 File Offset: 0x00027520
	private void OnDisable()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x06000834 RID: 2100 RVA: 0x00029320 File Offset: 0x00027520
	private void OnDestroy()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x06000835 RID: 2101 RVA: 0x00029320 File Offset: 0x00027520
	private void OnApplicationQuit()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x06000836 RID: 2102 RVA: 0x00029330 File Offset: 0x00027530
	private void gameCleanup()
	{
		if (!this.applicationHasQuit)
		{
			this.applicationHasQuit = true;
			this.leaveLobby();
			SteamClient.Shutdown();
		}
	}

	// Token: 0x06000837 RID: 2103 RVA: 0x0002934C File Offset: 0x0002754C
	private void OnLobbyMemberDisconnectedCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	// Token: 0x06000838 RID: 2104 RVA: 0x0002934C File Offset: 0x0002754C
	private void OnLobbyMemberLeaveCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	// Token: 0x06000839 RID: 2105 RVA: 0x00029358 File Offset: 0x00027558
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

	// Token: 0x0600083A RID: 2106 RVA: 0x000030D7 File Offset: 0x000012D7
	private void OnLobbyGameCreatedCallback(Lobby lobby, uint ip, ushort port, SteamId steamId)
	{
	}

	// Token: 0x0600083B RID: 2107 RVA: 0x00029450 File Offset: 0x00027650
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

	// Token: 0x0600083C RID: 2108 RVA: 0x00029494 File Offset: 0x00027694
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

	// Token: 0x0600083D RID: 2109 RVA: 0x000294C8 File Offset: 0x000276C8
	private void OnChatMessageCallback(Lobby lobby, Friend friend, string message)
	{
		if (friend.Id != this.PlayerSteamId)
		{
			Debug.Log("incoming chat message");
			Debug.Log(message);
			lobby.SetGameServer(this.PlayerSteamId);
		}
	}

	// Token: 0x0600083E RID: 2110 RVA: 0x00029500 File Offset: 0x00027700
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

	// Token: 0x0600083F RID: 2111 RVA: 0x000295C8 File Offset: 0x000277C8
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

	// Token: 0x06000840 RID: 2112 RVA: 0x0002960C File Offset: 0x0002780C
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

	// Token: 0x06000841 RID: 2113 RVA: 0x00029694 File Offset: 0x00027894
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

	// Token: 0x06000842 RID: 2114 RVA: 0x00029734 File Offset: 0x00027934
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

	// Token: 0x06000843 RID: 2115 RVA: 0x00029808 File Offset: 0x00027A08
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

	// Token: 0x06000844 RID: 2116 RVA: 0x00029850 File Offset: 0x00027A50
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

	// Token: 0x06000845 RID: 2117 RVA: 0x00029895 File Offset: 0x00027A95
	public void OpenFriendOverlayForGameInvite()
	{
		SteamFriends.OpenGameInviteOverlay(this.currentLobby.Id);
	}

	// Token: 0x06000846 RID: 2118 RVA: 0x000298A7 File Offset: 0x00027AA7
	private void OnSceneLoaded(Scene scene, LoadSceneMode loadSceneMode)
	{
		this.UpdateRichPresenceStatus(scene.name);
	}

	// Token: 0x06000847 RID: 2119 RVA: 0x000298B8 File Offset: 0x00027AB8
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

	// Token: 0x040007C3 RID: 1987
	public static SteamManager Instance;

	// Token: 0x040007C4 RID: 1988
	private static uint gameAppId = 1625450U;

	// Token: 0x040007C7 RID: 1991
	private string playerSteamIdString;

	// Token: 0x040007C8 RID: 1992
	private bool connectedToSteam;

	// Token: 0x040007C9 RID: 1993
	private Friend lobbyPartner;

	// Token: 0x040007CC RID: 1996
	public List<Lobby> activeUnrankedLobbies;

	// Token: 0x040007CD RID: 1997
	public List<Lobby> activeRankedLobbies;

	// Token: 0x040007CE RID: 1998
	public Lobby currentLobby;

	// Token: 0x040007CF RID: 1999
	private Lobby hostedMultiplayerLobby;

	// Token: 0x040007D0 RID: 2000
	private SteamId originalLobbyOwnerId;

	// Token: 0x040007D1 RID: 2001
	private bool applicationHasQuit;

	// Token: 0x040007D2 RID: 2002
	private bool daRealOne;
}
