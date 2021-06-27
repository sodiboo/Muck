using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

public class SteamLobby : MonoBehaviour
{
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

	private void InitLobby(Lobby l)
	{
		this.currentLobby = l;
		this.InitLobbyClients();
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
	}

	public void StartLobby(SteamId hostSteamId, Lobby l)
	{
		this.InitLobby(l);
		LobbySettings.Instance.startButton.SetActive(true);
		this.AddPlayerToLobby(new Friend(hostSteamId));
		this.started = false;
	}

	public void CloseLobby()
	{
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
		this.startButton.SetActive(false);
		this.started = false;
	}

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

	private void InitLobbyClients()
	{
		MonoBehaviour.print("initing lobby");
		Server.clients = new Dictionary<int, Client>();
		for (int i = 0; i < SteamLobby.lobbySize; i++)
		{
			Server.clients[i] = new Client(i);
		}
	}

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

	private Lobby currentLobby;

	public static Dictionary<ulong, int> steamIdToClientId = new Dictionary<ulong, int>();

	public GameObject startButton;

	public static int lobbySize = 10;

	private bool started;

	public static SteamLobby Instance;
}
