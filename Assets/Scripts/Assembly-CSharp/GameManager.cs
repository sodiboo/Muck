using System;
using System.Collections;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public enum GameState
    {
        Loading,
        Playing,
        GameOver
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

    public static GameState state;

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

    public bool powerupsPickedup;

    public bool damageTaken;

    public bool onlyRock = true;

    public Dictionary<string, int>[] stats;

    public int nStatsPlayers;

    public static GameSettings gameSettings { get; set; }

    public int currentDay { get; set; }

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            UnityEngine.Object.Destroy(this);
        }
        players = new Dictionary<int, PlayerManager>();
        currentDay = 0;
    }

    private void Start()
    {
        if (gameSettings == null && NetworkController.Instance == null)
        {
            Debug.LogError("testing spawn");
            gameSettings = new GameSettings(44430);
            gameSettings.gameMode = GameSettings.GameMode.Survival;
            gameSettings.difficulty = GameSettings.Difficulty.Normal;
            if (gameSettings.gameMode == GameSettings.GameMode.Versus)
            {
                UnityEngine.Object.Instantiate(zone, Vector3.zero, Quaternion.identity);
            }
            Server.InitializeServerPackets();
            LocalClient.InitializeClientData();
            UnityEngine.Object.Instantiate(testGame);
            LocalClient.instance.serverHost = SteamManager.Instance.PlayerSteamId.Value;
            SteamLobby.steamIdToClientId.Add(SteamManager.Instance.PlayerSteamId.Value, 0);
            Server.clients.Add(0, new Client(0));
            Server.clients[0].player = new Player(0, "Dani", Color.black, SteamManager.Instance.PlayerSteamId.Value);
            LocalClient.serverOwner = true;
            ClientSend.PlayerFinishedLoading();
            DayCycle.dayDuration = 10f;
        }
        else if (NetworkController.Instance.networkType == NetworkController.NetworkType.Steam)
        {
            StartCoroutine(GenerateWorldRoutine());
            LoadingScreen.Instance.Show(0f);
            DayCycle.dayDuration = gameSettings.DayLength();
        }
    }

    public static int GetSeed()
    {
        return gameSettings.Seed;
    }

    private IEnumerator GenerateWorldRoutine()
    {
        if (gameSettings.gameMode == GameSettings.GameMode.Versus)
        {
            UnityEngine.Object.Instantiate(zone, Vector3.zero, Quaternion.identity);
            if (LocalClient.serverOwner)
            {
                InvokeRepeating("SlowUpdate", 0.5f, 0.5f);
            }
        }
        yield return 3f;
        LoadingScreen.Instance.SetText("Generating World Mesh", 0.25f);
        mapGenerator.GenerateMap(GetSeed());
        Map.Instance.GenerateMap();
        yield return 30;
        LoadingScreen.Instance.SetText("Generating resources", 0.5f);
        resourceGen.SetActive(value: true);
        yield return 30;
        LoadingScreen.Instance.SetText("Generating resources", 0.5f);
        resourceGen.SetActive(value: true);
        yield return 30;
        LoadingScreen.Instance.SetText("Generating navmesh", 0.75f);
        generateNavmesh.GenerateNavMesh();
        yield return 60;
        LoadingScreen.Instance.SetText("Finished loading", 1f);
        ClientSend.PlayerFinishedLoading();
        LoadingScreen.Instance.FinishLoading();
    }

    public void UpdateDay(int day)
    {
        currentDay = day;
        dayUi.SetDay(day);
        extraUi.UpdateDay(currentDay);
        if (gameSettings.gameMode == GameSettings.GameMode.Versus)
        {
            ZoneController.Instance.NextDay(currentDay);
        }
        AchievementManager.Instance.NewDay(currentDay);
    }

    public void SpawnPlayer(int id, string username, Color color, Vector3 position, float orientationY)
    {
        if (!players.ContainsKey(id))
        {
            MonoBehaviour.print("Spawning player");
            PlayerManager component;
            if (id == LocalClient.instance.myId)
            {
                UnityEngine.Object.Instantiate(localPlayerPrefab, position, Quaternion.Euler(0f, 0f, 0f));
                component = PlayerMovement.Instance.gameObject.GetComponent<PlayerManager>();
            }
            else
            {
                component = UnityEngine.Object.Instantiate(playerPrefab, position, Quaternion.Euler(0f, orientationY, 0f)).GetComponent<PlayerManager>();
                component.SetDesiredPosition(position);
            }
            component.SetDesiredPosition(position);
            component.id = id;
            component.username = username;
            component.color = color;
            players.Add(id, component);
            if ((gameSettings.gameMode == GameSettings.GameMode.Versus && id == LocalClient.instance.myId) || gameSettings.gameMode != GameSettings.GameMode.Versus)
            {
                extraUi.InitPlayerStatus(id, username, component);
            }
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
        float p = 1.55f;
        if (gameSettings.difficulty == GameSettings.Difficulty.Easy)
        {
            num = 0.35f;
            num2 = 0.2f;
            p = 1.33f;
        }
        else if (gameSettings.difficulty == GameSettings.Difficulty.Gamer)
        {
            num = 1.75f;
            num2 = 0.25f;
            p = 2.3f;
        }
        return num + Mathf.Pow(num2 * (float)currentDay, p);
    }

    public float ChestPriceMultiplier()
    {
        if (gameSettings.difficulty != GameSettings.Difficulty.Gamer)
        {
            _ = gameSettings.difficulty;
        }
        float chestPriceMultiplier = gameSettings.GetChestPriceMultiplier();
        float min = 1f;
        return Mathf.Clamp(1f * (1f + (float)(currentDay - 3) / chestPriceMultiplier), min, 100f);
    }

    public float MobHpMultiplier()
    {
        float num = 1.05f;
        float num2 = 0.24f;
        float p = 1.5f;
        if (gameSettings.difficulty == GameSettings.Difficulty.Easy)
        {
            num = 0.9f;
            num2 = 0.2f;
            p = 1.32f;
        }
        else if (gameSettings.difficulty == GameSettings.Difficulty.Gamer)
        {
            num = 1.3f;
            num2 = 0.3f;
            p = 1.8f;
        }
        return num + Mathf.Pow(num2 * (float)currentDay, p);
    }

    private void SlowUpdate()
    {
        if (winnerSent || gameSettings.gameMode != GameSettings.GameMode.Versus || GetPlayersAlive() > 1)
        {
            return;
        }
        int num = -1;
        foreach (PlayerManager value in players.Values)
        {
            if (value != null && !value.dead)
            {
                num = value.id;
                string text = "Nobody";
                if (players.ContainsKey(num))
                {
                    text = players[num].username;
                }
                Debug.Log("Winner is: " + num + " | with name: " + text);
                ServerSend.GameOver(num);
                GameOver(num);
                winnerSent = true;
                break;
            }
        }
    }

    public void KillPlayer(int id, Vector3 pos)
    {
        PlayerManager playerManager = players[id];
        playerManager.dead = true;
        playerManager.gameObject.SetActive(value: false);
        pos = playerManager.transform.position;
        UnityEngine.Object.Instantiate(playerRagdoll, pos, playerManager.transform.rotation).GetComponent<PlayerRagdoll>().SetRagdoll(id, -playerManager.transform.forward);
    }

    public Vector3 GetGravePosition(int playerId)
    {
        try
        {
            Vector3 vector = players[playerId].transform.position;
            if (vector.y < -100f)
            {
                vector = Vector3.zero;
            }
            if (Physics.Raycast(vector + Vector3.up * 3000f, Vector3.down, out var hitInfo, 8000f, whatIsGround))
            {
                return hitInfo.point;
            }
        }
        catch (Exception)
        {
            return Vector3.zero;
        }
        return Vector3.zero;
    }

    public void SpawnGrave(Vector3 gravePos, int playerId, int graveObjectId)
    {
        PlayerManager playerManager = players[playerId];
        playerManager.deaths++;
        GraveInteract componentInChildren = UnityEngine.Object.Instantiate(gravePrefab, gravePos, Quaternion.identity).GetComponentInChildren<GraveInteract>();
        componentInChildren.username = playerManager.username.Substring(0, Mathf.Clamp(15, 0, playerManager.username.Length));
        componentInChildren.playerId = playerManager.id;
        componentInChildren.SetId(graveObjectId);
        ResourceManager.Instance.AddObject(graveObjectId, componentInChildren.transform.parent.gameObject);
        playerManager.graveId = graveObjectId;
        float value = componentInChildren.timeLeft * (float)(players[playerId].deaths - 1) * 2f;
        value = Mathf.Clamp(value, 30f, 300f);
        componentInChildren.SetTime(value);
        componentInChildren.transform.root.GetComponentInChildren<GravePing>().SetPing(playerManager.username);
    }

    public void RespawnPlayer(int id, Vector3 zero)
    {
        if (players.ContainsKey(id))
        {
            players[id].dead = false;
            Vector3 position = ResourceManager.Instance.list[players[id].graveId].transform.position;
            if (players[id].graveId != -1)
            {
                players[id].RemoveGrave();
            }
            if (LocalClient.instance.myId == id)
            {
                PlayerMovement.Instance.transform.position = position + Vector3.up * 3f;
                PlayerMovement.Instance.gameObject.SetActive(value: true);
                PlayerStatus.Instance.Respawn();
            }
            else
            {
                players[id].gameObject.SetActive(value: true);
            }
        }
    }

    public void StartGame()
    {
        LoadingScreen.Instance.Hide();
        lobbyCamera.SetActive(value: false);
        state = GameState.Playing;
        if (LocalClient.serverOwner)
        {
            GameLoop.Instance.StartLoop();
        }
        Hotbar.Instance.UpdateHotbar();
        AchievementManager.Instance.StartGame(gameSettings.difficulty);
    }

    public void DisconnectPlayer(int id)
    {
        if (players[id] != null && players[id].gameObject != null)
        {
            UnityEngine.Object.Destroy(players[id].gameObject);
            players[id].dead = true;
            players[id].disconnected = true;
        }
        players?.Remove(id);
    }

    public int GetPlayersAlive()
    {
        int num = 0;
        foreach (PlayerManager value in players.Values)
        {
            if ((bool)value && !value.dead)
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
        foreach (PlayerManager value in players.Values)
        {
            if ((bool)value && !value.disconnected)
            {
                num++;
            }
        }
        return num;
    }

    public void CheckIfGameOver()
    {
        if (GetPlayersAlive() <= 0)
        {
            GameOver(-2);
            ServerSend.GameOver();
        }
    }

    public void GameOver()
    {
        MusicController.Instance.StopSong();
        Invoke("ShowEndScreen", 4f);
    }

    public void GameOver(int winnerId, float time = 4f)
    {
        Debug.LogError("game over");
        this.winnerId = winnerId;
        Invoke("ShowEndScreen", time);
        MusicController.Instance.StopSong();
        AchievementManager.Instance.CheckGameOverAchievements(winnerId);
    }

    public void LeaveGame()
    {
        if (LocalClient.serverOwner)
        {
            Debug.LogError("Host left game");
            HostLeftGame();
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
        foreach (Client value in Server.clients.Values)
        {
            if (value != null && value.player != null && value.player.id != LocalClient.instance.myId)
            {
                ServerSend.DisconnectPlayer(value.player.id);
                MonoBehaviour.print("sending disconnect to all players");
            }
        }
    }

    private void ShowEndScreen()
    {
        state = GameState.GameOver;
        gameoverUi.SetActive(value: true);
        Cursor.visible = true;
        Cursor.lockState = CursorLockMode.None;
    }

    public void ReturnToMenu()
    {
        SceneManager.LoadScene("TestSteamLobby");
    }

    public List<Vector3> FindSurvivalSpawnPositions(int nPlayers)
    {
        Vector3 vector = Vector3.zero;
        List<Vector3> list = new List<Vector3>();
        for (int i = 0; i < 100; i++)
        {
            UnityEngine.Random.InitState(GetSeed());
            Vector2 vector2 = UnityEngine.Random.insideUnitCircle * mapRadius;
            if (Physics.Raycast(new Vector3(vector2.x, 200f, vector2.y), Vector3.down, out var hitInfo, 500f, whatIsGround) && WorldUtility.WorldHeightToBiome(hitInfo.point.y) != 0)
            {
                vector = hitInfo.point;
                break;
            }
        }
        for (int j = 0; j < 100; j++)
        {
            Vector2 vector3 = UnityEngine.Random.insideUnitCircle * 50f;
            if (Physics.Raycast(vector + new Vector3(vector3.x, 200f, vector3.y), Vector3.down, out var hitInfo2, 500f, whatIsGround) && WorldUtility.WorldHeightToBiome(hitInfo2.point.y) != 0)
            {
                list.Add(hitInfo2.point + Vector3.up);
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
            Vector2 vector = UnityEngine.Random.insideUnitCircle * mapRadius;
            if (Physics.Raycast(new Vector3(vector.x, 200f, vector.y), Vector3.down, out var hitInfo, 500f, whatIsGround) && WorldUtility.WorldHeightToBiome(hitInfo.point.y) != 0)
            {
                list.Add(hitInfo.point + Vector3.up);
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

    public bool KickPlayer(string username)
    {
        foreach (Client value in Server.clients.Values)
        {
            if (value != null && value.player != null && value.player.id != LocalClient.instance.myId && value.player.username.ToLower() == username.ToLower())
            {
                ServerHandle.KickPlayer(value.player.id);
                SteamNetworking.CloseP2PSessionWithUser(value.player.steamId.Value);
                Debug.Log("Kicking player: " + value.player.username + " with id " + value.player.id);
                return true;
            }
        }
        return false;
    }

    public void SendPlayersIntoGame(List<Vector3> spawnPositions)
    {
        this.spawnPositions = spawnPositions;
        Invoke("SendPlayersIntoGameNow", 2f);
    }

    private void SendPlayersIntoGameNow()
    {
        int num = 0;
        foreach (Client value in Server.clients.Values)
        {
            if (value?.player == null)
            {
                continue;
            }
            foreach (Client value2 in Server.clients.Values)
            {
                if (value2?.player != null)
                {
                    ServerSend.SpawnPlayer(value.id, value2.player, spawnPositions[num] + Vector3.up);
                    num++;
                }
            }
        }
    }

    public void MakeStats(Packet packet)
    {
        stats = new Dictionary<string, int>[NetworkController.maxPlayers];
        int num = (nStatsPlayers = packet.ReadInt());
        for (int i = 0; i < num; i++)
        {
            stats[i] = new Dictionary<string, int>();
            stats[i].Add("Id", packet.ReadInt());
            string[] allStats = Player.allStats;
            foreach (string key in allStats)
            {
                stats[i].Add(key, packet.ReadInt());
            }
        }
    }
}
