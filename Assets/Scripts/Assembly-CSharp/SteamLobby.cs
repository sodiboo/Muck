using System.Collections.Generic;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

// Token: 0x0200013A RID: 314
public class SteamLobby : MonoBehaviour
{
	// Token: 0x06000785 RID: 1925 RVA: 0x00006FB7 File Offset: 0x000051B7
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

	// Token: 0x06000786 RID: 1926 RVA: 0x00006FE2 File Offset: 0x000051E2
	private void InitLobby(Lobby l)
	{
		this.currentLobby = l;
		this.InitLobbyClients();
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
	}

	// Token: 0x06000787 RID: 1927 RVA: 0x00006FFB File Offset: 0x000051FB
	public void StartLobby(SteamId hostSteamId, Lobby l)
	{
		this.InitLobby(l);
		LobbySettings.Instance.startButton.SetActive(true);
		this.AddPlayerToLobby(new Friend(hostSteamId));
		this.started = false;
	}

	// Token: 0x06000788 RID: 1928 RVA: 0x00007027 File Offset: 0x00005227
	public void CloseLobby()
	{
		SteamLobby.steamIdToClientId = new Dictionary<ulong, int>();
		this.startButton.SetActive(false);
		this.started = false;
	}

	// Token: 0x06000789 RID: 1929 RVA: 0x000254DC File Offset: 0x000236DC
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

	// Token: 0x0600078A RID: 1930 RVA: 0x00025580 File Offset: 0x00023780
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

	// Token: 0x0600078B RID: 1931 RVA: 0x000255F0 File Offset: 0x000237F0
	private void InitLobbyClients()
	{
		MonoBehaviour.print("initing lobby");
		Server.clients = new Dictionary<int, Client>();
		for (int i = 0; i < SteamLobby.lobbySize; i++)
		{
			Server.clients[i] = new Client(i);
		}
	}

	// Token: 0x0600078C RID: 1932 RVA: 0x00025634 File Offset: 0x00023834
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

	// Token: 0x0600078D RID: 1933 RVA: 0x00025668 File Offset: 0x00023868
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

	// Token: 0x0600078E RID: 1934 RVA: 0x00025794 File Offset: 0x00023994
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

	// Token: 0x0600078F RID: 1935 RVA: 0x000257E8 File Offset: 0x000239E8
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

	// Token: 0x040007CA RID: 1994
	private Lobby currentLobby;

	// Token: 0x040007CB RID: 1995
	public static Dictionary<ulong, int> steamIdToClientId = new Dictionary<ulong, int>();

	// Token: 0x040007CC RID: 1996
	public GameObject startButton;

	// Token: 0x040007CD RID: 1997
	public static int lobbySize = 10;

	// Token: 0x040007CE RID: 1998
	private bool started;

	// Token: 0x040007CF RID: 1999
	public static SteamLobby Instance;
}
