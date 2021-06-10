using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Steamworks;
using Steamworks.Data;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x020000EC RID: 236
public class SteamManager : MonoBehaviour
{
	// Token: 0x1700004B RID: 75
	// (get) Token: 0x060006DF RID: 1759 RVA: 0x00022768 File Offset: 0x00020968
	// (set) Token: 0x060006E0 RID: 1760 RVA: 0x00022770 File Offset: 0x00020970
	public string PlayerName { get; set; }

	// Token: 0x1700004C RID: 76
	// (get) Token: 0x060006E1 RID: 1761 RVA: 0x00022779 File Offset: 0x00020979
	// (set) Token: 0x060006E2 RID: 1762 RVA: 0x00022781 File Offset: 0x00020981
	public SteamId PlayerSteamId { get; set; }

	// Token: 0x1700004D RID: 77
	// (get) Token: 0x060006E3 RID: 1763 RVA: 0x0002278A File Offset: 0x0002098A
	public string PlayerSteamIdString
	{
		get
		{
			return this.playerSteamIdString;
		}
	}

	// Token: 0x1700004E RID: 78
	// (get) Token: 0x060006E4 RID: 1764 RVA: 0x00022792 File Offset: 0x00020992
	// (set) Token: 0x060006E5 RID: 1765 RVA: 0x0002279A File Offset: 0x0002099A
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

	// Token: 0x1700004F RID: 79
	// (get) Token: 0x060006E6 RID: 1766 RVA: 0x000227A3 File Offset: 0x000209A3
	// (set) Token: 0x060006E7 RID: 1767 RVA: 0x000227AB File Offset: 0x000209AB
	public SteamId lobbyOwnerSteamId { get; set; }

	// Token: 0x17000050 RID: 80
	// (get) Token: 0x060006E8 RID: 1768 RVA: 0x000227B4 File Offset: 0x000209B4
	// (set) Token: 0x060006E9 RID: 1769 RVA: 0x000227BC File Offset: 0x000209BC
	public bool LobbyPartnerDisconnected { get; set; }

	// Token: 0x060006EA RID: 1770 RVA: 0x000227C8 File Offset: 0x000209C8
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

	// Token: 0x060006EB RID: 1771 RVA: 0x000228DC File Offset: 0x00020ADC
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

	// Token: 0x060006EC RID: 1772 RVA: 0x0002298C File Offset: 0x00020B8C
	public bool ConnectedToSteam()
	{
		return this.connectedToSteam;
	}

	// Token: 0x060006ED RID: 1773 RVA: 0x00022994 File Offset: 0x00020B94
	public void StartLobby()
	{
		this.CreateLobby(0);
	}

	// Token: 0x060006EE RID: 1774 RVA: 0x0002299E File Offset: 0x00020B9E
	public void StopLobby()
	{
		this.leaveLobby();
	}

	// Token: 0x060006EF RID: 1775 RVA: 0x000229A8 File Offset: 0x00020BA8
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

	// Token: 0x060006F0 RID: 1776 RVA: 0x00022A61 File Offset: 0x00020C61
	private void Update()
	{
		SteamClient.RunCallbacks();
	}

	// Token: 0x060006F1 RID: 1777 RVA: 0x00022A68 File Offset: 0x00020C68
	private void OnDisable()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x060006F2 RID: 1778 RVA: 0x00022A68 File Offset: 0x00020C68
	private void OnDestroy()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x060006F3 RID: 1779 RVA: 0x00022A68 File Offset: 0x00020C68
	private void OnApplicationQuit()
	{
		if (this.daRealOne)
		{
			this.gameCleanup();
		}
	}

	// Token: 0x060006F4 RID: 1780 RVA: 0x00022A78 File Offset: 0x00020C78
	private void gameCleanup()
	{
		if (!this.applicationHasQuit)
		{
			this.applicationHasQuit = true;
			this.leaveLobby();
			SteamClient.Shutdown();
		}
	}

	// Token: 0x060006F5 RID: 1781 RVA: 0x00022A94 File Offset: 0x00020C94
	private void OnLobbyMemberDisconnectedCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	// Token: 0x060006F6 RID: 1782 RVA: 0x00022A94 File Offset: 0x00020C94
	private void OnLobbyMemberLeaveCallback(Lobby lobby, Friend friend)
	{
		this.OtherLobbyMemberLeft(friend);
	}

	// Token: 0x060006F7 RID: 1783 RVA: 0x00022AA0 File Offset: 0x00020CA0
	private void OtherLobbyMemberLeft(Friend friend)
	{
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

	// Token: 0x060006F8 RID: 1784 RVA: 0x0000276E File Offset: 0x0000096E
	private void OnLobbyGameCreatedCallback(Lobby lobby, uint ip, ushort port, SteamId steamId)
	{
	}

	// Token: 0x060006F9 RID: 1785 RVA: 0x00022B7C File Offset: 0x00020D7C
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

	// Token: 0x060006FA RID: 1786 RVA: 0x00022BC0 File Offset: 0x00020DC0
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

	// Token: 0x060006FB RID: 1787 RVA: 0x00022BF4 File Offset: 0x00020DF4
	private void OnChatMessageCallback(Lobby lobby, Friend friend, string message)
	{
		if (friend.Id != this.PlayerSteamId)
		{
			Debug.Log("incoming chat message");
			Debug.Log(message);
			lobby.SetGameServer(this.PlayerSteamId);
		}
	}

	// Token: 0x060006FC RID: 1788 RVA: 0x00022C2C File Offset: 0x00020E2C
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

	// Token: 0x060006FD RID: 1789 RVA: 0x00022CF4 File Offset: 0x00020EF4
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

	// Token: 0x060006FE RID: 1790 RVA: 0x00022D38 File Offset: 0x00020F38
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

	// Token: 0x060006FF RID: 1791 RVA: 0x00022DC0 File Offset: 0x00020FC0
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

	// Token: 0x06000700 RID: 1792 RVA: 0x00022E60 File Offset: 0x00021060
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

	// Token: 0x06000701 RID: 1793 RVA: 0x00022F34 File Offset: 0x00021134
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

	// Token: 0x06000702 RID: 1794 RVA: 0x00022F7C File Offset: 0x0002117C
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

	// Token: 0x06000703 RID: 1795 RVA: 0x00022FC1 File Offset: 0x000211C1
	public void OpenFriendOverlayForGameInvite()
	{
		SteamFriends.OpenGameInviteOverlay(this.currentLobby.Id);
	}

	// Token: 0x06000704 RID: 1796 RVA: 0x00022FD3 File Offset: 0x000211D3
	private void OnSceneLoaded(Scene scene, LoadSceneMode loadSceneMode)
	{
		this.UpdateRichPresenceStatus(scene.name);
	}

	// Token: 0x06000705 RID: 1797 RVA: 0x00022FE4 File Offset: 0x000211E4
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

	// Token: 0x0400067E RID: 1662
	public static SteamManager Instance;

	// Token: 0x0400067F RID: 1663
	private static uint gameAppId = 1625450U;

	// Token: 0x04000682 RID: 1666
	private string playerSteamIdString;

	// Token: 0x04000683 RID: 1667
	private bool connectedToSteam;

	// Token: 0x04000684 RID: 1668
	private Friend lobbyPartner;

	// Token: 0x04000687 RID: 1671
	public List<Lobby> activeUnrankedLobbies;

	// Token: 0x04000688 RID: 1672
	public List<Lobby> activeRankedLobbies;

	// Token: 0x04000689 RID: 1673
	public Lobby currentLobby;

	// Token: 0x0400068A RID: 1674
	private Lobby hostedMultiplayerLobby;

	// Token: 0x0400068B RID: 1675
	private SteamId originalLobbyOwnerId;

	// Token: 0x0400068C RID: 1676
	private bool applicationHasQuit;

	// Token: 0x0400068D RID: 1677
	private bool daRealOne;
}
