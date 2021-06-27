using System.Collections;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x020000B8 RID: 184
public class GameManager : MonoBehaviour
{
	// Token: 0x17000038 RID: 56
	// (get) Token: 0x06000531 RID: 1329 RVA: 0x0001AB34 File Offset: 0x00018D34
	// (set) Token: 0x06000532 RID: 1330 RVA: 0x0001AB3B File Offset: 0x00018D3B
	public static GameSettings gameSettings { get; set; }

	// Token: 0x06000533 RID: 1331 RVA: 0x0001AB43 File Offset: 0x00018D43
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

	// Token: 0x06000534 RID: 1332 RVA: 0x0001AB80 File Offset: 0x00018D80
	private void Start()
	{
		if (GameManager.gameSettings == null && NetworkController.Instance == null)
		{
			Debug.LogError("testing spawn");
			GameManager.gameSettings = new GameSettings(44430, GameSettings.GameMode.Survival, GameSettings.FriendlyFire.Off, GameSettings.Difficulty.Normal, GameSettings.GameLength.Short, GameSettings.Multiplayer.On);
			GameManager.gameSettings.gameMode = GameSettings.GameMode.Survival;
			GameManager.gameSettings.difficulty = GameSettings.Difficulty.Normal;
			if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
			{
				Instantiate<GameObject>(this.zone, Vector3.zero, Quaternion.identity);
			}
			Server.InitializeServerPackets();
			LocalClient.InitializeClientData();
			Instantiate<GameObject>(this.testGame);
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

	// Token: 0x06000535 RID: 1333 RVA: 0x0001ACDF File Offset: 0x00018EDF
	public static int GetSeed()
	{
		return GameManager.gameSettings.Seed;
	}

	// Token: 0x06000536 RID: 1334 RVA: 0x0001ACEB File Offset: 0x00018EEB
	private IEnumerator GenerateWorldRoutine()
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			Instantiate<GameObject>(this.zone, Vector3.zero, Quaternion.identity);
			if (LocalClient.serverOwner)
			{
				InvokeRepeating(nameof(SlowUpdate), 0.5f, 0.5f);
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

	// Token: 0x06000537 RID: 1335 RVA: 0x0001ACFC File Offset: 0x00018EFC
	private void GenerateWorld()
	{
		MonoBehaviour.print("generating world");
		this.mapGenerator.GenerateMap(GameManager.GetSeed());
		MonoBehaviour.print("generating resources");
		this.resourceGen.SetActive(true);
		MonoBehaviour.print("generating navmesh");
		this.generateNavmesh.GenerateNavMesh();
	}

	// Token: 0x17000039 RID: 57
	// (get) Token: 0x06000538 RID: 1336 RVA: 0x0001AD4E File Offset: 0x00018F4E
	// (set) Token: 0x06000539 RID: 1337 RVA: 0x0001AD56 File Offset: 0x00018F56
	public int currentDay { get; set; }

	// Token: 0x0600053A RID: 1338 RVA: 0x0001AD60 File Offset: 0x00018F60
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

	// Token: 0x0600053B RID: 1339 RVA: 0x0001ADB0 File Offset: 0x00018FB0
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
			Instantiate<GameObject>(this.localPlayerPrefab, position, Quaternion.Euler(0f, 0f, 0f));
			component = PlayerMovement.Instance.gameObject.GetComponent<PlayerManager>();
		}
		else
		{
			component = Instantiate<GameObject>(this.playerPrefab, position, Quaternion.Euler(0f, orientationY, 0f)).GetComponent<PlayerManager>();
			component.SetDesiredPosition(position);
		}
		component.SetDesiredPosition(position);
		component.id = id;
		component.username = username;
		component.color = color;
		GameManager.players.Add(id, component);
		if ((GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus && id == LocalClient.instance.myId) || GameManager.gameSettings.gameMode != GameSettings.GameMode.Versus)
		{
			this.extraUi.InitPlayerStatus(id, username, component);
		}
	}

	// Token: 0x0600053C RID: 1340 RVA: 0x0001AEA0 File Offset: 0x000190A0
	public int CalculateDamage(float damage, float armor, float sharpness, float hardness)
	{
		armor = (100f - Mathf.Clamp(armor, 0f, 100f)) / 100f;
		if (armor < 0.02f)
		{
			armor = 0.02f;
		}
		return (int)(damage * armor);
	}

	// Token: 0x0600053D RID: 1341 RVA: 0x0001AED4 File Offset: 0x000190D4
	public float MobDamageMultiplier()
	{
		float num = 0.9f;
		float num2 = 0.26f;
		float p = 1.6f;
		if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Easy)
		{
			num = 0.35f;
			num2 = 0.2f;
			p = 1.4f;
		}
		else if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Gamer)
		{
			num = 1.75f;
			num2 = 0.25f;
			p = 2.3f;
		}
		return num + Mathf.Pow(num2 * (float)this.currentDay, p);
	}

	// Token: 0x0600053E RID: 1342 RVA: 0x0001AF44 File Offset: 0x00019144
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

	// Token: 0x0600053F RID: 1343 RVA: 0x0001AF98 File Offset: 0x00019198
	public float MobHpMultiplier()
	{
		float num = 1.05f;
		float num2 = 0.24f;
		float p = 1.55f;
		if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Easy)
		{
			num = 0.9f;
			num2 = 0.2f;
			p = 1.4f;
		}
		else if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Gamer)
		{
			num = 1.3f;
			num2 = 0.3f;
			p = 1.8f;
		}
		return num + Mathf.Pow(num2 * (float)this.currentDay, p);
	}

	// Token: 0x06000540 RID: 1344 RVA: 0x0001B008 File Offset: 0x00019208
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
					this.GameOver(id, 4f);
					this.winnerSent = true;
					break;
				}
			}
		}
	}

	// Token: 0x06000541 RID: 1345 RVA: 0x0001B10C File Offset: 0x0001930C
	public void KillPlayer(int id, Vector3 pos)
	{
		PlayerManager playerManager = GameManager.players[id];
		playerManager.dead = true;
		playerManager.gameObject.SetActive(false);
		pos = playerManager.transform.position;
		Instantiate<GameObject>(this.playerRagdoll, pos, playerManager.transform.rotation).GetComponent<PlayerRagdoll>().SetRagdoll(id, -playerManager.transform.forward);
	}

	// Token: 0x06000542 RID: 1346 RVA: 0x0001B178 File Offset: 0x00019378
	public Vector3 GetGravePosition(int playerId)
	{
		try
		{
			Vector3 vector = GameManager.players[playerId].transform.position;
			if (vector.y < -100f)
			{
				vector = Vector3.zero;
			}
			RaycastHit raycastHit;
			if (Physics.Raycast(vector + Vector3.up * 3000f, Vector3.down, out raycastHit, 8000f, this.whatIsGround))
			{
				return raycastHit.point;
			}
		}
		catch
		{
			return Vector3.zero;
		}
		return Vector3.zero;
	}

	// Token: 0x06000543 RID: 1347 RVA: 0x0001B210 File Offset: 0x00019410
	public void SpawnGrave(Vector3 gravePos, int playerId, int graveObjectId)
	{
		PlayerManager playerManager = GameManager.players[playerId];
		playerManager.deaths++;
		GraveInteract componentInChildren = Instantiate<GameObject>(this.gravePrefab, gravePos, Quaternion.identity).GetComponentInChildren<GraveInteract>();
		componentInChildren.username = playerManager.username.Substring(0, Mathf.Clamp(15, 0, playerManager.username.Length));
		componentInChildren.playerId = playerManager.id;
		componentInChildren.SetId(graveObjectId);
		ResourceManager.Instance.AddObject(graveObjectId, componentInChildren.transform.parent.gameObject);
		playerManager.graveId = graveObjectId;
		float num = componentInChildren.timeLeft * (float)(GameManager.players[playerId].deaths - 1) * 2f;
		num = Mathf.Clamp(num, 30f, 300f);
		componentInChildren.SetTime(num);
		componentInChildren.transform.root.GetComponentInChildren<GravePing>().SetPing(playerManager.username);
	}

	// Token: 0x06000544 RID: 1348 RVA: 0x0001B2FC File Offset: 0x000194FC
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

	// Token: 0x06000545 RID: 1349 RVA: 0x0001B3D7 File Offset: 0x000195D7
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

	// Token: 0x06000546 RID: 1350 RVA: 0x0001B418 File Offset: 0x00019618
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

	// Token: 0x06000547 RID: 1351 RVA: 0x0001B498 File Offset: 0x00019698
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

	// Token: 0x06000548 RID: 1352 RVA: 0x0001B514 File Offset: 0x00019714
	public int GetPlayersInLobby()
	{
		int num = 0;
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (playerManager && !playerManager.disconnected)
			{
				num++;
			}
		}
		return num;
	}

	// Token: 0x06000549 RID: 1353 RVA: 0x0001B57C File Offset: 0x0001977C
	public void CheckIfGameOver()
	{
		if (this.GetPlayersAlive() > 0)
		{
			return;
		}
		this.GameOver(-2, 4f);
		ServerSend.GameOver(-2);
	}

	// Token: 0x0600054A RID: 1354 RVA: 0x0001B59C File Offset: 0x0001979C
	public void GameOver()
	{
		MusicController.Instance.StopSong(-1f);
		Invoke(nameof(ShowEndScreen), 4f);
	}

	// Token: 0x0600054B RID: 1355 RVA: 0x0001B5BD File Offset: 0x000197BD
	public void GameOver(int winnerId, float time = 4f)
	{
		this.winnerId = winnerId;
		Invoke(nameof(ShowEndScreen), time);
		MusicController.Instance.StopSong(-1f);
	}

	// Token: 0x0600054C RID: 1356 RVA: 0x0001B5E4 File Offset: 0x000197E4
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

	// Token: 0x0600054D RID: 1357 RVA: 0x0001B63C File Offset: 0x0001983C
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

	// Token: 0x0600054E RID: 1358 RVA: 0x0001B6C8 File Offset: 0x000198C8
	private void ShowEndScreen()
	{
		GameManager.state = GameManager.GameState.GameOver;
		this.gameoverUi.SetActive(true);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
	}

	// Token: 0x0600054F RID: 1359 RVA: 0x0001B6E8 File Offset: 0x000198E8
	public void ReturnToMenu()
	{
		SceneManager.LoadScene("TestSteamLobby");
	}

	// Token: 0x06000550 RID: 1360 RVA: 0x0001B6F4 File Offset: 0x000198F4
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

	// Token: 0x06000551 RID: 1361 RVA: 0x0001B840 File Offset: 0x00019A40
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

	// Token: 0x06000552 RID: 1362 RVA: 0x0001B8FF File Offset: 0x00019AFF
	private void OnApplicationQuit()
	{
		ClientSend.PlayerDisconnect();
	}

	// Token: 0x06000553 RID: 1363 RVA: 0x0001B906 File Offset: 0x00019B06
	public void SendPlayersIntoGame(List<Vector3> spawnPositions)
	{
		this.spawnPositions = spawnPositions;
		Invoke(nameof(SendPlayersIntoGameNow), 2f);
	}

	// Token: 0x06000554 RID: 1364 RVA: 0x0001B920 File Offset: 0x00019B20
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

	// Token: 0x04000487 RID: 1159
	public static GameManager instance;

	// Token: 0x04000488 RID: 1160
	public static bool connected;

	// Token: 0x04000489 RID: 1161
	public static bool started;

	// Token: 0x0400048A RID: 1162
	public static Dictionary<int, PlayerManager> players = new Dictionary<int, PlayerManager>();

	// Token: 0x0400048B RID: 1163
	public GameObject localPlayerPrefab;

	// Token: 0x0400048C RID: 1164
	public GameObject playerPrefab;

	// Token: 0x0400048D RID: 1165
	public GameObject playerRagdoll;

	// Token: 0x0400048E RID: 1166
	public MapGenerator mapGenerator;

	// Token: 0x0400048F RID: 1167
	public GenerateNavmesh generateNavmesh;

	// Token: 0x04000490 RID: 1168
	public GameObject resourceGen;

	// Token: 0x04000491 RID: 1169
	private bool gameOver;

	// Token: 0x04000493 RID: 1171
	public DayUi dayUi;

	// Token: 0x04000494 RID: 1172
	public GameObject gameoverUi;

	// Token: 0x04000495 RID: 1173
	public ExtraUI extraUi;

	// Token: 0x04000496 RID: 1174
	public static GameManager.GameState state;

	// Token: 0x04000497 RID: 1175
	public bool boatLeft;

	// Token: 0x04000498 RID: 1176
	public GameObject lobbyCamera;

	// Token: 0x04000499 RID: 1177
	public GameObject testGame;

	// Token: 0x0400049A RID: 1178
	public GameObject zone;

	// Token: 0x0400049C RID: 1180
	private bool winnerSent;

	// Token: 0x0400049D RID: 1181
	public GameObject gravePrefab;

	// Token: 0x0400049E RID: 1182
	public int winnerId;

	// Token: 0x0400049F RID: 1183
	private float mapRadius = 1100f;

	// Token: 0x040004A0 RID: 1184
	public LayerMask whatIsGround;

	// Token: 0x040004A1 RID: 1185
	public LayerMask whatIsGroundAndObject;

	// Token: 0x040004A2 RID: 1186
	private List<Vector3> spawnPositions;

	// Token: 0x0200015D RID: 349
	public enum GameState
	{
		// Token: 0x04000908 RID: 2312
		Loading,
		// Token: 0x04000909 RID: 2313
		Playing,
		// Token: 0x0400090A RID: 2314
		GameOver
	}
}
