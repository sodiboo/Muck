using System.Collections;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
	public static GameSettings gameSettings { get; set; }

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

	public static int GetSeed()
	{
		return GameManager.gameSettings?.Seed ?? 44430;
	}

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
		yield return 0f;
		LoadingScreen.Instance.SetText("Generating World Mesh", 0.25f);
		this.mapGenerator.GenerateMap(GameManager.GetSeed());
		Map.Instance.GenerateMap();
		yield return 0;
		LoadingScreen.Instance.SetText("Generating resources", 0.5f);
		this.resourceGen.SetActive(true);
		// yield return 0;
		// LoadingScreen.Instance.SetText("Generating resources", 0.5f);
		// this.resourceGen.SetActive(true);
		yield return 0;
		LoadingScreen.Instance.SetText("Generating navmesh", 0.75f);
		this.generateNavmesh.GenerateNavMesh();
		yield return 0;
		LoadingScreen.Instance.SetText("Finished loading", 1f);
		ClientSend.PlayerFinishedLoading();
		LoadingScreen.Instance.FinishLoading();
		yield break;
	}

	private void GenerateWorld()
	{
		MonoBehaviour.print("generating world");
		this.mapGenerator.GenerateMap(GameManager.GetSeed());
		MonoBehaviour.print("generating resources");
		this.resourceGen.SetActive(true);
		MonoBehaviour.print("generating navmesh");
		this.generateNavmesh.GenerateNavMesh();
	}

	public int currentDay { get; set; }

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

	public int CalculateDamage(float damage, float armor, float sharpness, float hardness)
	{
		armor = (100f - Mathf.Clamp(armor, 0f, 100f)) / 100f;
		if (armor < 0.02f)
		{
			armor = 0.02f;
		}
		return (int)(damage * armor);
	}

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

	public void KillPlayer(int id, Vector3 pos)
	{
		PlayerManager playerManager = GameManager.players[id];
		playerManager.dead = true;
		playerManager.gameObject.SetActive(false);
		pos = playerManager.transform.position;
		Instantiate<GameObject>(this.playerRagdoll, pos, playerManager.transform.rotation).GetComponent<PlayerRagdoll>().SetRagdoll(id, -playerManager.transform.forward);
	}

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

	public void StartGame()
	{
		LoadingScreen.Instance.Hide(0f);
		this.lobbyCamera.SetActive(false);
		GameManager.state = GameManager.GameState.Playing;
		if (LocalClient.serverOwner)
		{
			GameLoop.Instance.StartLoop();
		}
		Hotbar.Instance.UpdateHotbar();
	}

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

	public void CheckIfGameOver()
	{
		if (this.GetPlayersAlive() > 0)
		{
			return;
		}
		this.GameOver(-2, 4f);
		ServerSend.GameOver(-2);
	}

	public void GameOver()
	{
		MusicController.Instance.StopSong(-1f);
		Invoke(nameof(ShowEndScreen), 4f);
	}

	public void GameOver(int winnerId, float time = 4f)
	{
		this.winnerId = winnerId;
		Invoke(nameof(ShowEndScreen), time);
		MusicController.Instance.StopSong(-1f);
	}

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

	private void ShowEndScreen()
	{
		GameManager.state = GameManager.GameState.GameOver;
		this.gameoverUi.SetActive(true);
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
	}

	public void ReturnToMenu()
	{
		SceneManager.LoadScene("TestSteamLobby");
	}

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

	private void OnApplicationQuit()
	{
		ClientSend.PlayerDisconnect();
	}

	public void SendPlayersIntoGame(List<Vector3> spawnPositions)
	{
		this.spawnPositions = spawnPositions;
		SendPlayersIntoGameNow();
	}

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

	public static GameManager instance;

	public static bool connected;

	public static bool started;

	public static Dictionary<int, PlayerManager> players = new Dictionary<int, PlayerManager>();

	public GameObject localPlayerPrefab;

	public GameObject playerPrefab;

	public GameObject playerRagdoll;

	public MapGenerator mapGenerator;

	public GenerateNavmesh generateNavmesh;

	public GameObject resourceGen;

	private bool gameOver;

	public DayUi dayUi;

	public GameObject gameoverUi;

	public ExtraUI extraUi;

	public static GameManager.GameState state;

	public bool boatLeft;

	public GameObject lobbyCamera;

	public GameObject testGame;

	public GameObject zone;

	private bool winnerSent;

	public GameObject gravePrefab;

	public int winnerId;

	private float mapRadius = 1100f;

	public LayerMask whatIsGround;

	public LayerMask whatIsGroundAndObject;

	private List<Vector3> spawnPositions;

	public enum GameState
	{
		Loading,
		Playing,
		GameOver
	}
}
