using System.Collections;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;
using UnityEngine.SceneManagement;

// Token: 0x020000B7 RID: 183
public class GameManager : MonoBehaviour
{
	// Token: 0x17000032 RID: 50
	// (get) Token: 0x0600048F RID: 1167 RVA: 0x00004FBB File Offset: 0x000031BB
	// (set) Token: 0x06000490 RID: 1168 RVA: 0x00004FC2 File Offset: 0x000031C2
	public static GameSettings gameSettings { get; set; }

	// Token: 0x06000491 RID: 1169 RVA: 0x00004FCA File Offset: 0x000031CA
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

	// Token: 0x06000492 RID: 1170 RVA: 0x000193A8 File Offset: 0x000175A8
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

	// Token: 0x06000493 RID: 1171 RVA: 0x00005005 File Offset: 0x00003205
	public static int GetSeed()
	{
		return GameManager.gameSettings.Seed;
	}

	// Token: 0x06000494 RID: 1172 RVA: 0x00005011 File Offset: 0x00003211
	private IEnumerator GenerateWorldRoutine()
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
		Instantiate<GameObject>(this.zone, Vector3.zero, Quaternion.identity);
			if (LocalClient.serverOwner)
			{
				base.InvokeRepeating(nameof(SlowUpdate), 0.5f, 0.5f);
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

	// Token: 0x06000495 RID: 1173 RVA: 0x00019508 File Offset: 0x00017708
	private void GenerateWorld()
	{
		MonoBehaviour.print("generating world");
		this.mapGenerator.GenerateMap(GameManager.GetSeed());
		MonoBehaviour.print("generating resources");
		this.resourceGen.SetActive(true);
		MonoBehaviour.print("generating navmesh");
		this.generateNavmesh.GenerateNavMesh();
	}

	// Token: 0x17000033 RID: 51
	// (get) Token: 0x06000496 RID: 1174 RVA: 0x00005020 File Offset: 0x00003220
	// (set) Token: 0x06000497 RID: 1175 RVA: 0x00005028 File Offset: 0x00003228
	public int currentDay { get; set; }

	// Token: 0x06000498 RID: 1176 RVA: 0x0001955C File Offset: 0x0001775C
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

	// Token: 0x06000499 RID: 1177 RVA: 0x000195AC File Offset: 0x000177AC
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
			component =Instantiate<GameObject>(this.playerPrefab, position, Quaternion.Euler(0f, orientationY, 0f)).GetComponent<PlayerManager>();
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

	// Token: 0x0600049A RID: 1178 RVA: 0x00005031 File Offset: 0x00003231
	public int CalculateDamage(float damage, float armor, float sharpness, float hardness)
	{
		armor = (100f - Mathf.Clamp(armor, 0f, 100f)) / 100f;
		if (armor < 0.02f)
		{
			armor = 0.02f;
		}
		return (int)(damage * armor);
	}

	// Token: 0x0600049B RID: 1179 RVA: 0x0001969C File Offset: 0x0001789C
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

	// Token: 0x0600049C RID: 1180 RVA: 0x0001970C File Offset: 0x0001790C
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

	// Token: 0x0600049D RID: 1181 RVA: 0x00019760 File Offset: 0x00017960
	public float MobHpMultiplier()
	{
		float num = 1.05f;
		float num2 = 0.23f;
		float p = 1.54f;
		if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Easy)
		{
			num = 0.9f;
			num2 = 0.2f;
			p = 1.3f;
		}
		else if (GameManager.gameSettings.difficulty == GameSettings.Difficulty.Gamer)
		{
			num = 1.3f;
			num2 = 0.28f;
			p = 1.65f;
		}
		return num + Mathf.Pow(num2 * (float)this.currentDay, p);
	}

	// Token: 0x0600049E RID: 1182 RVA: 0x000197D0 File Offset: 0x000179D0
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

	// Token: 0x0600049F RID: 1183 RVA: 0x000198CC File Offset: 0x00017ACC
	public void KillPlayer(int id, Vector3 pos)
	{
		PlayerManager playerManager = GameManager.players[id];
		playerManager.dead = true;
		playerManager.gameObject.SetActive(false);
		pos = playerManager.transform.position;
	Instantiate<GameObject>(this.playerRagdoll, pos, playerManager.transform.rotation).GetComponent<PlayerRagdoll>().SetRagdoll(id, -playerManager.transform.forward);
	}

	// Token: 0x060004A0 RID: 1184 RVA: 0x00019938 File Offset: 0x00017B38
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

	// Token: 0x060004A1 RID: 1185 RVA: 0x000199D0 File Offset: 0x00017BD0
	public void SpawnGrave(Vector3 gravePos, int playerId, int graveObjectId)
	{
		PlayerManager playerManager = GameManager.players[playerId];
		playerManager.deaths++;
		GraveInteract componentInChildren =Instantiate<GameObject>(this.gravePrefab, gravePos, Quaternion.identity).GetComponentInChildren<GraveInteract>();
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

	// Token: 0x060004A2 RID: 1186 RVA: 0x00019ABC File Offset: 0x00017CBC
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

	// Token: 0x060004A3 RID: 1187 RVA: 0x00005064 File Offset: 0x00003264
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

	// Token: 0x060004A4 RID: 1188 RVA: 0x00019B98 File Offset: 0x00017D98
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

	// Token: 0x060004A5 RID: 1189 RVA: 0x00019C18 File Offset: 0x00017E18
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

	// Token: 0x060004A6 RID: 1190 RVA: 0x00019C94 File Offset: 0x00017E94
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

	// Token: 0x060004A7 RID: 1191 RVA: 0x000050A2 File Offset: 0x000032A2
	public void CheckIfGameOver()
	{
		if (this.GetPlayersAlive() > 0)
		{
			return;
		}
		this.GameOver(-2);
		ServerSend.GameOver(-2);
	}

	// Token: 0x060004A8 RID: 1192 RVA: 0x000050BD File Offset: 0x000032BD
	public void GameOver()
	{
		MusicController.Instance.StopSong();
		base.Invoke(nameof(ShowEndScreen), 4f);
	}

	// Token: 0x060004A9 RID: 1193 RVA: 0x000050D9 File Offset: 0x000032D9
	public void GameOver(int winnerId)
	{
		this.winnerId = winnerId;
		base.Invoke(nameof(ShowEndScreen), 4f);
		MusicController.Instance.StopSong();
	}

	// Token: 0x060004AA RID: 1194 RVA: 0x00019CF4 File Offset: 0x00017EF4
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

	// Token: 0x060004AB RID: 1195 RVA: 0x00019D4C File Offset: 0x00017F4C
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

	// Token: 0x060004AC RID: 1196 RVA: 0x000050FC File Offset: 0x000032FC
	private void ShowEndScreen()
	{
		GameManager.state = GameManager.GameState.GameOver;
		this.gameoverUi.SetActive(true);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
	}

	// Token: 0x060004AD RID: 1197 RVA: 0x0000511C File Offset: 0x0000331C
	public void ReturnToMenu()
	{
		SceneManager.LoadScene("TestSteamLobby");
	}

	// Token: 0x060004AE RID: 1198 RVA: 0x00019DD8 File Offset: 0x00017FD8
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

	// Token: 0x060004AF RID: 1199 RVA: 0x00019F24 File Offset: 0x00018124
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

	// Token: 0x060004B0 RID: 1200 RVA: 0x00005128 File Offset: 0x00003328
	private void OnApplicationQuit()
	{
		ClientSend.PlayerDisconnect();
	}

	// Token: 0x060004B1 RID: 1201 RVA: 0x0000512F File Offset: 0x0000332F
	public void SendPlayersIntoGame(List<Vector3> spawnPositions)
	{
		this.spawnPositions = spawnPositions;
		base.Invoke(nameof(SendPlayersIntoGameNow), 2f);
	}

	// Token: 0x060004B2 RID: 1202 RVA: 0x00019FE4 File Offset: 0x000181E4
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

	// Token: 0x04000435 RID: 1077
	public static GameManager instance;

	// Token: 0x04000436 RID: 1078
	public static bool connected;

	// Token: 0x04000437 RID: 1079
	public static bool started;

	// Token: 0x04000438 RID: 1080
	public static Dictionary<int, PlayerManager> players = new Dictionary<int, PlayerManager>();

	// Token: 0x04000439 RID: 1081
	public GameObject localPlayerPrefab;

	// Token: 0x0400043A RID: 1082
	public GameObject playerPrefab;

	// Token: 0x0400043B RID: 1083
	public GameObject playerRagdoll;

	// Token: 0x0400043C RID: 1084
	public MapGenerator mapGenerator;

	// Token: 0x0400043D RID: 1085
	public GenerateNavmesh generateNavmesh;

	// Token: 0x0400043E RID: 1086
	public GameObject resourceGen;

	// Token: 0x0400043F RID: 1087
	private bool gameOver;

	// Token: 0x04000441 RID: 1089
	public DayUi dayUi;

	// Token: 0x04000442 RID: 1090
	public GameObject gameoverUi;

	// Token: 0x04000443 RID: 1091
	public ExtraUI extraUi;

	// Token: 0x04000444 RID: 1092
	public static GameManager.GameState state;

	// Token: 0x04000445 RID: 1093
	public GameObject lobbyCamera;

	// Token: 0x04000446 RID: 1094
	public GameObject testGame;

	// Token: 0x04000447 RID: 1095
	public GameObject zone;

	// Token: 0x04000449 RID: 1097
	private bool winnerSent;

	// Token: 0x0400044A RID: 1098
	public GameObject gravePrefab;

	// Token: 0x0400044B RID: 1099
	public int winnerId;

	// Token: 0x0400044C RID: 1100
	private float mapRadius = 1100f;

	// Token: 0x0400044D RID: 1101
	public LayerMask whatIsGround;

	// Token: 0x0400044E RID: 1102
	public LayerMask whatIsGroundAndObject;

	// Token: 0x0400044F RID: 1103
	private List<Vector3> spawnPositions;

	// Token: 0x020000B8 RID: 184
	public enum GameState
	{
		// Token: 0x04000451 RID: 1105
		Loading,
		// Token: 0x04000452 RID: 1106
		Playing,
		// Token: 0x04000453 RID: 1107
		GameOver
	}
}
