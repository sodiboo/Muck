using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x0200013B RID: 315
public class SteamManager : MonoBehaviour
{
	// Token: 0x17000054 RID: 84
	// (get) Token: 0x06000792 RID: 1938 RVA: 0x00007059 File Offset: 0x00005259
	// (set) Token: 0x06000793 RID: 1939 RVA: 0x00007061 File Offset: 0x00005261
	public string PlayerName { get; set; }

	// Token: 0x17000055 RID: 85
	// (get) Token: 0x06000794 RID: 1940 RVA: 0x0000706A File Offset: 0x0000526A
	// (set) Token: 0x06000795 RID: 1941 RVA: 0x00007072 File Offset: 0x00005272
	public SteamId PlayerSteamId { get; set; }

	// Token: 0x17000056 RID: 86
	// (get) Token: 0x06000796 RID: 1942 RVA: 0x0000707B File Offset: 0x0000527B
	public string PlayerSteamIdString
	{
		get
		{
			return this.playerSteamIdString;
		}
	}

	// Token: 0x17000057 RID: 87
	// (get) Token: 0x06000797 RID: 1943 RVA: 0x00007083 File Offset: 0x00005283
	// (set) Token: 0x06000798 RID: 1944 RVA: 0x0000708B File Offset: 0x0000528B
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

	// Token: 0x17000058 RID: 88
	// (get) Token: 0x06000799 RID: 1945 RVA: 0x00007094 File Offset: 0x00005294
	// (set) Token: 0x0600079A RID: 1946 RVA: 0x0000709C File Offset: 0x0000529C
	public SteamId lobbyOwnerSteamId { get; set; }

	// Token: 0x17000059 RID: 89
	// (get) Token: 0x0600079B RID: 1947 RVA: 0x000070A5 File Offset: 0x000052A5
	// (set) Token: 0x0600079C RID: 1948 RVA: 0x000070AD File Offset: 0x000052AD
	public bool LobbyPartnerDisconnected { get; set; }

	// Token: 0x0600079D RID: 1949 RVA: 0x00025870 File Offset: 0x00023A70
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

	// Token: 0x0600079E RID: 1950 RVA: 0x00025984 File Offset: 0x00023B84
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

	// Token: 0x0600079F RID: 1951 RVA: 0x000070B6 File Offset: 0x000052B6
	public bool ConnectedToSteam()
	{
		return this.connectedToSteam;
	}

	// Token: 0x060007A0 RID: 1952 RVA: 0x000070BE File Offset: 0x000052BE
	public void StartLobby()
	{
		this.CreateLobby(0);
	}

	// Token: 0x060007A1 RID: 1953 RVA: 0x000070C8 File Offset: 0x000052C8
	public void StopLobby()
	{
		this.leaveLobby();
	}

	// Token: 0x060007A2 RID: 1954 RVA: 0x00025A34 File Offset: 0x00023C34
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

	// Token: 0x060007A3 RID: 1955 RVA: 0x000070D0 File Offset: 0x000052D0
	private void Update()
	{
		SteamClient.RunCallbacks();
	}

	// Token: 0x060007A4 RID: 1956 RVA: 0x000070D7 File Offset: 0x000052D7
	private void OnDisable()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x060007A5 RID: 1957 RVA: 0x000070D7 File Offset: 0x000052D7
	private void OnDestroy()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x060007A6 RID: 1958 RVA: 0x000070D7 File Offset: 0x000052D7
	private void OnApplicationQuit()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x060007A7 RID: 1959 RVA: 0x000070E7 File Offset: 0x000052E7
	private void gameCleanup()
	{
		if (!this.applicationHasQuit)
		{
			this.applicationHasQuit = true;
			this.leaveLobby();
			SteamClient.Shutdown();
		}
	}

	// Token: 0x060007A8 RID: 1960 RVA: 0x00007103 File Offset: 0x00005303
	private void OnLobbyMemberDisconnectedCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	// Token: 0x060007A9 RID: 1961 RVA: 0x00007103 File Offset: 0x00005303
	private void OnLobbyMemberLeaveCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	// Token: 0x060007AA RID: 1962 RVA: 0x00025AF0 File Offset: 0x00023CF0
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

	// Token: 0x060007AB RID: 1963 RVA: 0x00002147 File Offset: 0x00000347
	private void OnLobbyGameCreatedCallback(Lobby lobby, uint ip, ushort port, SteamId steamId)
	{
	}

	// Token: 0x060007AC RID: 1964 RVA: 0x00025BE8 File Offset: 0x00023DE8
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

	// Token: 0x060007AD RID: 1965 RVA: 0x00025C2C File Offset: 0x00023E2C
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

	// Token: 0x060007AE RID: 1966 RVA: 0x0000710C File Offset: 0x0000530C
	private void OnChatMessageCallback(Lobby lobby, Friend friend, string message)
	{
		if (friend.Id != this.PlayerSteamId)
		{
			Debug.Log("incoming chat message");
			Debug.Log(message);
			lobby.SetGameServer(this.PlayerSteamId);
		}
	}

	// Token: 0x060007AF RID: 1967 RVA: 0x00025C60 File Offset: 0x00023E60
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

	// Token: 0x060007B0 RID: 1968 RVA: 0x00025D28 File Offset: 0x00023F28
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

	// Token: 0x060007B1 RID: 1969 RVA: 0x00025D6C File Offset: 0x00023F6C
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

	// Token: 0x060007B2 RID: 1970 RVA: 0x00025DF4 File Offset: 0x00023FF4
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

	// Token: 0x060007B3 RID: 1971 RVA: 0x00025E94 File Offset: 0x00024094
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

	// Token: 0x060007B4 RID: 1972 RVA: 0x00025F68 File Offset: 0x00024168
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

	// Token: 0x060007B5 RID: 1973 RVA: 0x00025FB0 File Offset: 0x000241B0
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

	// Token: 0x060007B6 RID: 1974 RVA: 0x00007143 File Offset: 0x00005343
	public void OpenFriendOverlayForGameInvite()
	{
		SteamFriends.OpenGameInviteOverlay(this.currentLobby.Id);
	}

	// Token: 0x060007B7 RID: 1975 RVA: 0x00007155 File Offset: 0x00005355
	private void OnSceneLoaded(Scene scene, LoadSceneMode loadSceneMode)
	{
		this.UpdateRichPresenceStatus(scene.name);
	}

	// Token: 0x060007B8 RID: 1976 RVA: 0x00025FF8 File Offset: 0x000241F8
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

	// Token: 0x040007D0 RID: 2000
	public static SteamManager Instance;

	// Token: 0x040007D1 RID: 2001
	private static uint gameAppId = 1625450U;

	// Token: 0x040007D4 RID: 2004
	private string playerSteamIdString;

	// Token: 0x040007D5 RID: 2005
	private bool connectedToSteam;

	// Token: 0x040007D6 RID: 2006
	private Friend lobbyPartner;

	// Token: 0x040007D9 RID: 2009
	public List<Lobby> activeUnrankedLobbies;

	// Token: 0x040007DA RID: 2010
	public List<Lobby> activeRankedLobbies;

	// Token: 0x040007DB RID: 2011
	public Lobby currentLobby;

	// Token: 0x040007DC RID: 2012
	private Lobby hostedMultiplayerLobby;

	// Token: 0x040007DD RID: 2013
	private SteamId originalLobbyOwnerId;

	// Token: 0x040007DE RID: 2014
	private bool applicationHasQuit;

	// Token: 0x040007DF RID: 2015
	private bool daRealOne;
}
