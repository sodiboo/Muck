using System;
using System.Collections;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;
using UnityEngine.SceneManagement;
using Random = UnityEngine.Random;

// Token: 0x02000091 RID: 145
public class GameManager : MonoBehaviour
{
	// Token: 0x1700002C RID: 44
	// (get) Token: 0x06000434 RID: 1076 RVA: 0x00015564 File Offset: 0x00013764
	// (set) Token: 0x06000435 RID: 1077 RVA: 0x0001556B File Offset: 0x0001376B
	public static GameSettings gameSettings { get; set; }

	// Token: 0x06000436 RID: 1078 RVA: 0x00015573 File Offset: 0x00013773
	private void Awake()
	{
		if (GameManager.instance == null)
		{
			GameManager.instance = this;
		}
		else if (GameManager.instance != this)
		{
			Destroy(this);
		}
		GameManager.players = new Dictionary<int, PlayerManager>();
		this.currentDay = 0;
	}

	// Token: 0x06000437 RID: 1079 RVA: 0x000155B0 File Offset: 0x000137B0
	private void Start()
	{
		if (GameManager.gameSettings == null && NetworkController.Instance == null)
		{
			Debug.LogError("testing spawn");
			GameManager.gameSettings = new GameSettings(44430, GameSettings.GameMode.Survival, GameSettings.FriendlyFire.Off, GameSettings.Difficulty.Normal, GameSettings.GameLength.Short);
			GameManager.gameSettings.gameMode = GameSettings.GameMode.Survival;
			if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
			{
			Instantiate(this.zone, Vector3.zero, Quaternion.identity);
			}
			Server.InitializeServerPackets();
			LocalClient.InitializeClientData();
		Instantiate(this.testGame);
			LocalClient.instance.serverHost = SteamManager.Instance.PlayerSteamId.Value;
			SteamLobby.steamIdToClientId.Add(SteamManager.Instance.PlayerSteamId.Value, 0);
			Server.clients.Add(0, new Client(0));
			Server.clients[0].player = new Player(0, "Dani", Color.black, SteamManager.Instance.PlayerSteamId.Value);
			LocalClient.serverOwner = true;
			ClientSend.PlayerFinishedLoading();
			DayCycle.dayDuration = 10f;
			return;
		}
		if (NetworkController.Instance.networkType == NetworkController.NetworkType.Steam)
		{
			base.StartCoroutine(this.GenerateWorldRoutine());
			LoadingScreen.Instance.Show(0f);
			DayCycle.dayDuration = (float)GameManager.gameSettings.DayLength();
		}
	}

	// Token: 0x06000438 RID: 1080 RVA: 0x00015703 File Offset: 0x00013903
	public static int GetSeed()
	{
		return GameManager.gameSettings.Seed;
	}

	// Token: 0x06000439 RID: 1081 RVA: 0x0001570F File Offset: 0x0001390F
	private IEnumerator GenerateWorldRoutine()
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
		Instantiate(this.zone, Vector3.zero, Quaternion.identity);
			if (LocalClient.serverOwner)
			{
				base.InvokeRepeating("SlowUpdate", 0.5f, 0.5f);
			}
		}
		yield return 3f;
		LoadingScreen.Instance.SetText("Generating World Mesh", 0.25f);
		this.mapGenerator.GenerateMap(GameManager.GetSeed());
		Map.Instance.GenerateMap();
		yield return 30;
		LoadingScreen.Instance.SetText("Generating resources", 0.5f);
		this.resourceGen.SetActive(true);
		yield return 30;
		LoadingScreen.Instance.SetText("Generating navmesh", 0.75f);
		this.generateNavmesh.GenerateNavMesh();
		yield return 60;
		LoadingScreen.Instance.SetText("Finished loading", 1f);
		ClientSend.PlayerFinishedLoading();
		LoadingScreen.Instance.FinishLoading();
		yield break;
	}

	// Token: 0x0600043A RID: 1082 RVA: 0x00015720 File Offset: 0x00013920
	private void GenerateWorld()
	{
		MonoBehaviour.print("generating world");
		this.mapGenerator.GenerateMap(GameManager.GetSeed());
		MonoBehaviour.print("generating resources");
		this.resourceGen.SetActive(true);
		MonoBehaviour.print("generating navmesh");
		this.generateNavmesh.GenerateNavMesh();
	}

	// Token: 0x1700002D RID: 45
	// (get) Token: 0x0600043B RID: 1083 RVA: 0x00015772 File Offset: 0x00013972
	// (set) Token: 0x0600043C RID: 1084 RVA: 0x0001577A File Offset: 0x0001397A
	public int currentDay { get; set; }

	// Token: 0x0600043D RID: 1085 RVA: 0x00015784 File Offset: 0x00013984
	public void UpdateDay(int day)
	{
		this.currentDay = day;
		this.dayUi.SetDay(day);
		this.extraUi.UpdateDay(this.currentDay);
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			ZoneController.Instance.NextDay(this.currentDay);
		}
	}

	// Token: 0x0600043E RID: 1086 RVA: 0x000157D4 File Offset: 0x000139D4
	public void SpawnPlayer(int id, string username, Color color, Vector3 position, float orientationY)
	{
		if (GameManager.players.ContainsKey(id))
		{
			return;
		}
		MonoBehaviour.print("Spawning player");
		PlayerManager component;
		if (id == LocalClient.instance.myId)
		{
		Instantiate(this.localPlayerPrefab, position, Quaternion.Euler(0f, 0f, 0f));
			component = PlayerMovement.Instance.gameObject.GetComponent<PlayerManager>();
		}
		else
		{
			component =Instantiate(this.playerPrefab, position, Quaternion.Euler(0f, orientationY, 0f)).GetComponent<PlayerManager>();
			component.SetDesiredPosition(position);
		}
		component.SetDesiredPosition(position);
		component.id = id;
		component.username = username;
		component.color = color;
		GameManager.players.Add(id, component);
		if ((GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus && id == LocalClient.instance.myId) || GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus)
		{
			this.extraUi.InitPlayerStatus(id, username);
		}
	}

	// Token: 0x0600043F RID: 1087 RVA: 0x000158C3 File Offset: 0x00013AC3
	public int CalculateDamage(float damage, float armor, float sharpness, float hardness)
	{
		armor = (100f - Mathf.Clamp(armor, 0f, 100f)) / 100f;
		if (armor < 0.02f)
		{
			armor = 0.02f;
		}
		return (int)(damage * armor);
	}

	// Token: 0x06000440 RID: 1088 RVA: 0x000158F8 File Offset: 0x00013AF8
	public float MobDamageMultiplier()
	{
		float num = 0.8f;
		if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Gamer)
		{
			num = 1.7f;
		}
		else if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Easy)
		{
			num = 0.3f;
		}
		return num + (float)this.currentDay / (5f - (float)GameManager.gameSettings.difficulty);
	}

	// Token: 0x06000441 RID: 1089 RVA: 0x00015950 File Offset: 0x00013B50
	public float ChestPriceMultiplier()
	{
		if (GameManager.gameSettings.difficulty != GameSettings.Difficulty.Gamer)
		{
			GameSettings.Difficulty difficulty = GameManager.gameSettings.difficulty;
		}
		float num = 1f;
		float chestPriceMultiplier = GameManager.gameSettings.GetChestPriceMultiplier();
		float min = num;
		return Mathf.Clamp(num * (1f + (float)(this.currentDay - 3) / chestPriceMultiplier), min, 100f);
	}

	// Token: 0x06000442 RID: 1090 RVA: 0x000159A4 File Offset: 0x00013BA4
	public float MobHpMultiplier()
	{
		return 1f + (float)(GameManager.gameSettings.difficulty - GameSettings.Difficulty.Normal) * 0.3f + (float)this.currentDay / (6f - (float)GameManager.gameSettings.difficulty);
	}

	// Token: 0x06000443 RID: 1091 RVA: 0x000159DC File Offset: 0x00013BDC
	private void SlowUpdate()
	{
		if (this.winnerSent)
		{
			return;
		}
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus && this.GetPlayersAlive() <= 1)
		{
			foreach (PlayerManager playerManager in GameManager.players.Values)
			{
				if (playerManager != null && !playerManager.dead)
				{
					int id = playerManager.id;
					string text = "Nobody";
					if (GameManager.players.ContainsKey(id))
					{
						text = GameManager.players[id].username;
					}
					Debug.Log(string.Concat(new object[]
					{
						"Winner is: ",
						id,
						" | with name: ",
						text
					}));
					ServerSend.GameOver(id);
					this.GameOver(id);
					this.winnerSent = true;
					break;
				}
			}
		}
	}

	// Token: 0x06000444 RID: 1092 RVA: 0x00015AD8 File Offset: 0x00013CD8
	public void KillPlayer(int id, Vector3 pos)
	{
		PlayerManager playerManager = GameManager.players[id];
		playerManager.dead = true;
		playerManager.gameObject.SetActive(false);
		pos = playerManager.transform.position;
	Instantiate(this.playerRagdoll, pos, playerManager.transform.rotation).GetComponent<PlayerRagdoll>().SetRagdoll(id, -playerManager.transform.forward);
	}

	// Token: 0x06000445 RID: 1093 RVA: 0x00015B44 File Offset: 0x00013D44
	public Vector3 GetGravePosition(int playerId)
	{
		try
		{
			RaycastHit raycastHit;
			if (Physics.Raycast(GameManager.players[playerId].transform.position + Vector3.up * 3000f, Vector3.down, out raycastHit, 8000f, this.whatIsGround))
			{
				return raycastHit.point;
			}
		}
		catch (Exception)
		{
			return Vector3.zero;
		}
		return Vector3.zero;
	}

	// Token: 0x06000446 RID: 1094 RVA: 0x00015BC4 File Offset: 0x00013DC4
	public void SpawnGrave(Vector3 gravePos, int playerId, int graveObjectId)
	{
		PlayerManager playerManager = GameManager.players[playerId];
		GraveInteract componentInChildren =Instantiate(this.gravePrefab, gravePos, Quaternion.identity).GetComponentInChildren<GraveInteract>();
		componentInChildren.username = playerManager.username;
		componentInChildren.playerId = playerManager.id;
		componentInChildren.SetId(graveObjectId);
		ResourceManager.Instance.AddObject(graveObjectId, componentInChildren.transform.parent.gameObject);
		playerManager.graveId = graveObjectId;
		componentInChildren.transform.root.GetComponentInChildren<GravePing>().SetPing(playerManager.username);
	}

	// Token: 0x06000447 RID: 1095 RVA: 0x00015C50 File Offset: 0x00013E50
	public void RespawnPlayer(int id, Vector3 zero)
	{
		if (!GameManager.players.ContainsKey(id))
		{
			return;
		}
		GameManager.players[id].dead = false;
		Vector3 position = ResourceManager.Instance.list[GameManager.players[id].graveId].transform.position;
		if (GameManager.players[id].graveId != -1)
		{
			GameManager.players[id].RemoveGrave();
		}
		if (LocalClient.instance.myId == id)
		{
			PlayerMovement.Instance.transform.position = position + Vector3.up * 3f;
			PlayerMovement.Instance.gameObject.SetActive(true);
			PlayerStatus.Instance.Respawn();
			return;
		}
		GameManager.players[id].gameObject.SetActive(true);
	}

	// Token: 0x06000448 RID: 1096 RVA: 0x00015D2B File Offset: 0x00013F2B
	public void StartGame()
	{
		LoadingScreen.Instance.Hide(1f);
		this.lobbyCamera.SetActive(false);
		GameManager.state = GameManager.GameState.Playing;
		if (LocalClient.serverOwner)
		{
			GameLoop.Instance.StartLoop();
		}
		Hotbar.Instance.UpdateHotbar();
	}

	// Token: 0x06000449 RID: 1097 RVA: 0x00015D6C File Offset: 0x00013F6C
	public void DisconnectPlayer(int id)
	{
		if (GameManager.players[id] != null && GameManager.players[id].gameObject != null)
		{
		Destroy(GameManager.players[id].gameObject);
			GameManager.players[id].dead = true;
			GameManager.players[id].disconnected = true;
		}
		Dictionary<int, PlayerManager> dictionary = GameManager.players;
		if (dictionary == null)
		{
			return;
		}
		dictionary.Remove(id);
	}

	// Token: 0x0600044A RID: 1098 RVA: 0x00015DEC File Offset: 0x00013FEC
	public int GetPlayersAlive()
	{
		int num = 0;
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (playerManager && !playerManager.dead)
			{
				num++;
			}
		}
		MonoBehaviour.print("players alive:  " + num);
		return num;
	}

	// Token: 0x0600044B RID: 1099 RVA: 0x00015E68 File Offset: 0x00014068
	public int GetPlayersInLobby()
	{
		int num = 0;
		using (Dictionary<int, PlayerManager>.ValueCollection.Enumerator enumerator = GameManager.players.Values.GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				if (enumerator.Current)
				{
					num++;
				}
			}
		}
		return num;
	}

	// Token: 0x0600044C RID: 1100 RVA: 0x00015EC8 File Offset: 0x000140C8
	public void CheckIfGameOver()
	{
		if (this.GetPlayersAlive() > 0)
		{
			return;
		}
		this.GameOver(-2);
		ServerSend.GameOver(-2);
	}

	// Token: 0x0600044D RID: 1101 RVA: 0x00015EE3 File Offset: 0x000140E3
	public void GameOver()
	{
		MusicController.Instance.StopSong();
		base.Invoke("ShowEndScreen", 4f);
	}

	// Token: 0x0600044E RID: 1102 RVA: 0x00015EFF File Offset: 0x000140FF
	public void GameOver(int winnerId)
	{
		this.winnerId = winnerId;
		base.Invoke("ShowEndScreen", 4f);
		MusicController.Instance.StopSong();
	}

	// Token: 0x0600044F RID: 1103 RVA: 0x00015F24 File Offset: 0x00014124
	public void LeaveGame()
	{
		if (LocalClient.serverOwner)
		{
			Debug.LogError("Host left game");
			this.HostLeftGame();
		}
		else
		{
			ClientSend.PlayerDisconnect();
		}
		SteamManager.Instance.leaveLobby();
		SceneManager.LoadScene("Menu");
		LocalClient.instance.serverHost = default(SteamId);
		LocalClient.serverOwner = false;
	}

	// Token: 0x06000450 RID: 1104 RVA: 0x00015F7C File Offset: 0x0001417C
	private void HostLeftGame()
	{
		foreach (Client client in Server.clients.Values)
		{
			if (client != null && client.player != null && client.player.id != LocalClient.instance.myId)
			{
				ServerSend.DisconnectPlayer(client.player.id);
				MonoBehaviour.print("sending disconnect to all players");
			}
		}
	}

	// Token: 0x06000451 RID: 1105 RVA: 0x00016008 File Offset: 0x00014208
	private void ShowEndScreen()
	{
		GameManager.state = GameManager.GameState.GameOver;
		this.gameoverUi.SetActive(true);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
	}

	// Token: 0x06000452 RID: 1106 RVA: 0x00016028 File Offset: 0x00014228
	public void ReturnToMenu()
	{
		SceneManager.LoadScene("TestSteamLobby");
	}

	// Token: 0x06000453 RID: 1107 RVA: 0x00016034 File Offset: 0x00014234
	public List<Vector3> FindSurvivalSpawnPositions(int nPlayers)
	{
		Vector3 a = Vector3.zero;
		List<Vector3> list = new List<Vector3>();
		for (int i = 0; i < 100; i++)
		{
			Random.InitState(GameManager.GetSeed());
			Vector2 vector = Random.insideUnitCircle * this.mapRadius;
			RaycastHit raycastHit;
			if (Physics.Raycast(new Vector3(vector.x, 200f, vector.y), Vector3.down, out raycastHit, 500f, this.whatIsGround) && WorldUtility.WorldHeightToBiome(raycastHit.point.y) != TextureData.TerrainType.Water)
			{
				a = raycastHit.point;
				break;
			}
		}
		for (int j = 0; j < 100; j++)
		{
			Vector2 vector2 = Random.insideUnitCircle * 50f;
			RaycastHit raycastHit2;
			if (Physics.Raycast(a + new Vector3(vector2.x, 200f, vector2.y), Vector3.down, out raycastHit2, 500f, this.whatIsGround) && WorldUtility.WorldHeightToBiome(raycastHit2.point.y) != TextureData.TerrainType.Water)
			{
				list.Add(raycastHit2.point + Vector3.up);
			}
		}
		while (list.Count < nPlayers)
		{
			list.Add(new Vector3(0f, 50f, 0f));
		}
		return list;
	}

	// Token: 0x06000454 RID: 1108 RVA: 0x00016180 File Offset: 0x00014380
	public List<Vector3> FindVersusSpawnPositions(int nPlayers)
	{
		List<Vector3> list = new List<Vector3>();
		for (int i = 0; i < 100; i++)
		{
			Vector2 vector = Random.insideUnitCircle * this.mapRadius;
			RaycastHit raycastHit;
			if (Physics.Raycast(new Vector3(vector.x, 200f, vector.y), Vector3.down, out raycastHit, 500f, this.whatIsGround) && WorldUtility.WorldHeightToBiome(raycastHit.point.y) != TextureData.TerrainType.Water)
			{
				list.Add(raycastHit.point + Vector3.up);
			}
		}
		while (list.Count <= nPlayers)
		{
			Debug.LogError("Couldnt find spawn positions");
			list.Add(new Vector3(0f, 50f, 0f));
		}
		return list;
	}

	// Token: 0x06000455 RID: 1109 RVA: 0x0001623F File Offset: 0x0001443F
	private void OnApplicationQuit()
	{
		ClientSend.PlayerDisconnect();
	}

	// Token: 0x06000456 RID: 1110 RVA: 0x00016246 File Offset: 0x00014446
	public void SendPlayersIntoGame(List<Vector3> spawnPositions)
	{
		this.spawnPositions = spawnPositions;
		base.Invoke("SendPlayersIntoGameNow", 2f);
	}

	// Token: 0x06000457 RID: 1111 RVA: 0x00016260 File Offset: 0x00014460
	private void SendPlayersIntoGameNow()
	{
		int num = 0;
		foreach (Client client in Server.clients.Values)
		{
			if (((client != null) ? client.player : null) != null)
			{
				foreach (Client client2 in Server.clients.Values)
				{
					if (((client2 != null) ? client2.player : null) != null)
					{
						ServerSend.SpawnPlayer(client.id, client2.player, this.spawnPositions[num] + Vector3.up);
						num++;
					}
				}
			}
		}
	}

	// Token: 0x0400037A RID: 890
	public static GameManager instance;

	// Token: 0x0400037B RID: 891
	public static bool connected;

	// Token: 0x0400037C RID: 892
	public static bool started;

	// Token: 0x0400037D RID: 893
	public static Dictionary<int, PlayerManager> players = new Dictionary<int, PlayerManager>();

	// Token: 0x0400037E RID: 894
	public GameObject localPlayerPrefab;

	// Token: 0x0400037F RID: 895
	public GameObject playerPrefab;

	// Token: 0x04000380 RID: 896
	public GameObject playerRagdoll;

	// Token: 0x04000381 RID: 897
	public MapGenerator mapGenerator;

	// Token: 0x04000382 RID: 898
	public GenerateNavmesh generateNavmesh;

	// Token: 0x04000383 RID: 899
	public GameObject resourceGen;

	// Token: 0x04000384 RID: 900
	private bool gameOver;

	// Token: 0x04000386 RID: 902
	public DayUi dayUi;

	// Token: 0x04000387 RID: 903
	public GameObject gameoverUi;

	// Token: 0x04000388 RID: 904
	public ExtraUI extraUi;

	// Token: 0x04000389 RID: 905
	public static GameManager.GameState state;

	// Token: 0x0400038A RID: 906
	public GameObject lobbyCamera;

	// Token: 0x0400038B RID: 907
	public GameObject testGame;

	// Token: 0x0400038C RID: 908
	public GameObject zone;

	// Token: 0x0400038E RID: 910
	private bool winnerSent;

	// Token: 0x0400038F RID: 911
	public GameObject gravePrefab;

	// Token: 0x04000390 RID: 912
	public int winnerId;

	// Token: 0x04000391 RID: 913
	private float mapRadius = 1100f;

	// Token: 0x04000392 RID: 914
	public LayerMask whatIsGround;

	// Token: 0x04000393 RID: 915
	private List<Vector3> spawnPositions;

	// Token: 0x02000120 RID: 288
	public enum GameState
	{
		// Token: 0x0400078F RID: 1935
		Loading,
		// Token: 0x04000790 RID: 1936
		Playing,
		// Token: 0x04000791 RID: 1937
		GameOver
	}
}
