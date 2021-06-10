
using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

// Token: 0x020000EB RID: 235
public class SteamLobby : MonoBehaviour
{
	// Token: 0x060006D2 RID: 1746 RVA: 0x0002234C File Offset: 0x0002054C
	private void Awake()
	{
		if (SteamLobby.Instance)
		{
		Destroy(base.gameObject);
			return;
		}
		SteamLobby.Instance = this;
		Object.DontDestroyOnLoad(base.gameObject);
	}

	// Token: 0x060006D3 RID: 1747 RVA: 0x00022377 File Offset: 0x00020577
	private void InitLobby(Lobby l)
	{
		this.currentLobby = l;
		this.InitLobbyClients();
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
	}

	// Token: 0x060006D4 RID: 1748 RVA: 0x00022390 File Offset: 0x00020590
	public void StartLobby(SteamId hostSteamId, Lobby l)
	{
		this.InitLobby(l);
		LobbySettings.Instance.startButton.SetActive(true);
		this.AddPlayerToLobby(new Friend(hostSteamId));
		this.started = false;
	}

	// Token: 0x060006D5 RID: 1749 RVA: 0x000223BC File Offset: 0x000205BC
	public void CloseLobby()
	{
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
		this.startButton.SetActive(false);
		this.started = false;
	}

	// Token: 0x060006D6 RID: 1750 RVA: 0x000223DC File Offset: 0x000205DC
	public void AddPlayerToLobby(Friend friend)
	{
		SteamId steamId = friend.Id.Value;
		int num = this.FindAvailableLobbyId();
		if (num == -1)
		{
			return;
		}
		Debug.Log(string.Concat(new object[]
		{
			"Found available id in steam as: ",
			num,
			", steam name: ",
			friend.Name
		}));
		SteamLobby.steamIdToClientId[steamId] = num;
		Client client = Server.clients[num];
		client.inLobby = true;
		Player player = new Player(num, friend.Name, UnityEngine.Color.black, steamId);
		client.player = player;
		MonoBehaviour.print("finished adding player");
	}

	// Token: 0x060006D7 RID: 1751 RVA: 0x00022480 File Offset: 0x00020680
	public void RemovePlayerFromLobby(Friend friend)
	{
		SteamId steamId = friend.Id.Value;
		int num = SteamLobby.steamIdToClientId[steamId.Value];
		Server.clients[num] = new Client(num);
		SteamLobby.steamIdToClientId.Remove(friend.Id.Value);
		if (this.started && GameManager.instance)
		{
			ServerSend.DisconnectPlayer(num);
		}
	}

	// Token: 0x060006D8 RID: 1752 RVA: 0x000224F0 File Offset: 0x000206F0
	private void InitLobbyClients()
	{
		MonoBehaviour.print("initing lobby");
		Server.clients = new Dictionary<int, Client>();
		for (int i = 0; i < SteamLobby.lobbySize; i++)
		{
			Server.clients[i] = new Client(i);
		}
	}

	// Token: 0x060006D9 RID: 1753 RVA: 0x00022534 File Offset: 0x00020734
	private int FindAvailableLobbyId()
	{
		for (int i = 0; i < SteamLobby.lobbySize; i++)
		{
			if (!Server.clients[i].inLobby)
			{
				return i;
			}
		}
		return -1;
	}

	// Token: 0x060006DA RID: 1754 RVA: 0x00022568 File Offset: 0x00020768
	public void StartGame()
	{
		if (SteamClient.SteamId.Value != this.currentLobby.Owner.Id.Value)
		{
			Debug.LogError("not owner, so cant start lobby");
			return;
		}
		MonoBehaviour.print("starting lobby");
		GameSettings gameSettings = this.MakeSettings();
		if (gameSettings.gameMode == GameSettings.GameMode.Versus && this.currentLobby.MemberCount < 2)
		{
			StatusMessage.Instance.DisplayMessage("Need at least 2 players to play versus.");
			return;
		}
		foreach (Client client in Server.clients.Values)
		{
			MonoBehaviour.print(client);
			if (client != null)
			{
				MonoBehaviour.print(client.player);
			}
			if (((client != null) ? client.player : null) != null)
			{
				MonoBehaviour.print("sending start game");
				ServerSend.StartGame(client.player.id, gameSettings);
			}
		}
		this.currentLobby.SetJoinable(false);
		this.started = true;
		MonoBehaviour.print("Starting game done");
		LocalClient.serverOwner = true;
		LocalClient.instance.serverHost = SteamManager.Instance.PlayerSteamId;
	}

	// Token: 0x060006DB RID: 1755 RVA: 0x00022694 File Offset: 0x00020894
	private int FindSeed()
	{
		string text = LobbySettings.Instance.seed.text;
		int result;
		int num;
		if (text == "")
		{
			result = Random.Range(int.MinValue, int.MaxValue);
		}
		else if (int.TryParse(text, out num))
		{
			result = num;
		}
		else
		{
			result = text.GetHashCode();
		}
		return result;
	}

	// Token: 0x060006DC RID: 1756 RVA: 0x000226E8 File Offset: 0x000208E8
	private GameSettings MakeSettings()
	{
		GameSettings gameSettings = new GameSettings(this.FindSeed(), GameSettings.GameMode.Survival, GameSettings.FriendlyFire.Off, GameSettings.Difficulty.Normal, GameSettings.GameLength.Short);
		gameSettings.difficulty = (GameSettings.Difficulty)LobbySettings.Instance.difficultySetting.setting;
		gameSettings.friendlyFire = (GameSettings.FriendlyFire)LobbySettings.Instance.friendlyFireSetting.setting;
		gameSettings.gameMode = (GameSettings.GameMode)LobbySettings.Instance.gamemodeSetting.setting;
		if (gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			gameSettings.friendlyFire = GameSettings.FriendlyFire.On;
		}
		return gameSettings;
	}

	// Token: 0x04000678 RID: 1656
	private Lobby currentLobby;

	// Token: 0x04000679 RID: 1657
	public static Dictionary<ulong, int> steamIdToClientId = new Dictionary<ulong, int>();

	// Token: 0x0400067A RID: 1658
	public GameObject startButton;

	// Token: 0x0400067B RID: 1659
	public static int lobbySize = 10;

	// Token: 0x0400067C RID: 1660
	private bool started;

	// Token: 0x0400067D RID: 1661
	public static SteamLobby Instance;
}
