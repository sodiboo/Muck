using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

// Token: 0x0200011A RID: 282
public class SteamLobby : MonoBehaviour
{
	// Token: 0x06000814 RID: 2068 RVA: 0x00028BEC File Offset: 0x00026DEC
	private void Awake()
	{
		if (SteamLobby.Instance)
		{
			Destroy(base.gameObject);
			return;
		}
		SteamLobby.Instance = this;
		DontDestroyOnLoad(base.gameObject);
	}

	// Token: 0x06000815 RID: 2069 RVA: 0x00028C17 File Offset: 0x00026E17
	private void InitLobby(Lobby l)
	{
		this.currentLobby = l;
		this.InitLobbyClients();
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
	}

	// Token: 0x06000816 RID: 2070 RVA: 0x00028C30 File Offset: 0x00026E30
	public void StartLobby(SteamId hostSteamId, Lobby l)
	{
		this.InitLobby(l);
		LobbySettings.Instance.startButton.SetActive(true);
		this.AddPlayerToLobby(new Friend(hostSteamId));
		this.started = false;
	}

	// Token: 0x06000817 RID: 2071 RVA: 0x00028C5C File Offset: 0x00026E5C
	public void CloseLobby()
	{
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
		this.startButton.SetActive(false);
		this.started = false;
	}

	// Token: 0x06000818 RID: 2072 RVA: 0x00028C7C File Offset: 0x00026E7C
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

	// Token: 0x06000819 RID: 2073 RVA: 0x00028D20 File Offset: 0x00026F20
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

	// Token: 0x0600081A RID: 2074 RVA: 0x00028D90 File Offset: 0x00026F90
	private void InitLobbyClients()
	{
		MonoBehaviour.print("initing lobby");
		Server.clients = new Dictionary<int, Client>();
		for (int i = 0; i < SteamLobby.lobbySize; i++)
		{
			Server.clients[i] = new Client(i);
		}
	}

	// Token: 0x0600081B RID: 2075 RVA: 0x00028DD4 File Offset: 0x00026FD4
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

	// Token: 0x0600081C RID: 2076 RVA: 0x00028E08 File Offset: 0x00027008
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

	// Token: 0x0600081D RID: 2077 RVA: 0x00028F34 File Offset: 0x00027134
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

	// Token: 0x0600081E RID: 2078 RVA: 0x00028F88 File Offset: 0x00027188
	private GameSettings MakeSettings()
	{
		GameSettings gameSettings = new GameSettings(this.FindSeed(), GameSettings.GameMode.Survival, GameSettings.FriendlyFire.Off, GameSettings.Difficulty.Normal, GameSettings.GameLength.Short, GameSettings.Multiplayer.On);
		gameSettings.difficulty = (GameSettings.Difficulty)LobbySettings.Instance.difficultySetting.setting;
		gameSettings.friendlyFire = (GameSettings.FriendlyFire)LobbySettings.Instance.friendlyFireSetting.setting;
		gameSettings.gameMode = (GameSettings.GameMode)LobbySettings.Instance.gamemodeSetting.setting;
		gameSettings.multiplayer = (GameSettings.Multiplayer)Mathf.Clamp(this.currentLobby.MemberCount - 1, 0, 1);
		if (gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			gameSettings.friendlyFire = GameSettings.FriendlyFire.On;
		}
		return gameSettings;
	}

	// Token: 0x040007BD RID: 1981
	private Lobby currentLobby;

	// Token: 0x040007BE RID: 1982
	public static Dictionary<ulong, int> steamIdToClientId = new Dictionary<ulong, int>();

	// Token: 0x040007BF RID: 1983
	public GameObject startButton;

	// Token: 0x040007C0 RID: 1984
	public static int lobbySize = 10;

	// Token: 0x040007C1 RID: 1985
	private bool started;

	// Token: 0x040007C2 RID: 1986
	public static SteamLobby Instance;
}
