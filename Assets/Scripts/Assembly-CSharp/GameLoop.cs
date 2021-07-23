using System;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;

public class GameLoop : MonoBehaviour
{
    [Serializable]
    public class MobSpawn
    {
        public MobType mob;

        public int dayStart;

        public int dayPeak;

        public float maxWeight;

        public float currentWeight;
    }

    public int currentDay = -1;

    private Vector2 maxCheckMobUpdateInterval = new Vector2(3f, 10f);

    private Vector2 checkMobUpdateInterval = new Vector2(3f, 10f);

    public MobSpawn[] mobs;

    private int activeMobs;

    private int maxMobCap = 999;

    private float totalWeight;

    public LayerMask whatIsSpawnable;

    [Header("Boss Stuff")]
    public MobType[] bosses;

    private List<MobType> bossRotation;

    public static GameLoop Instance;

    private bool nightStarted;

    private bool bossNight;

    public static int currentMobCap { get; set; } = 999;


    private void ResetBossRotations()
    {
        bossRotation = new List<MobType>();
        MobType[] array = bosses;
        foreach (MobType item in array)
        {
            bossRotation.Add(item);
        }
    }

    private void Update()
    {
        if (LocalClient.serverOwner && GameManager.state == GameManager.GameState.Playing && GameManager.gameSettings.gameMode != GameSettings.GameMode.Creative)
        {
            DayLoop();
        }
    }

    private void Awake()
    {
        Instance = this;
        ResetBossRotations();
    }

    public void StartLoop()
    {
        if (!LocalClient.serverOwner)
        {
            UnityEngine.Object.Destroy(this);
        }
        foreach (Client value in Server.clients.Values)
        {
            value?.player?.PingPlayer();
        }
        InvokeRepeating("TimeoutPlayers", 2f, 2f);
    }

    private void NewDay(int day)
    {
        if (GameManager.instance.GetPlayersAlive() > 0)
        {
            bossNight = false;
            nightStarted = false;
            currentDay = day;
            CancelInvoke("CheckMobSpawns");
            ServerSend.NewDay(day);
            GameManager.instance.UpdateDay(day);
            totalWeight = CalculateSpawnWeights(currentDay);
            FindMobCap();
            float num = 1f - PowerupInventory.CumulativeDistribution(currentDay, 0.05f, 0.5f);
            checkMobUpdateInterval = maxCheckMobUpdateInterval * num;
            MusicController.Instance.PlaySong(MusicController.SongType.Day);
        }
    }

    private void FindMobCap()
    {
        int num = GameManager.instance.GetPlayersInLobby();
        if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
        {
            num = GameManager.instance.GetPlayersAlive();
        }
        int difficulty = (int)GameManager.gameSettings.difficulty;
        currentMobCap = 3 + difficulty + (int)((float)(num - 1) * 0.2f);
        currentMobCap = (int)((float)currentMobCap + (float)(currentMobCap * currentDay) * 0.4f);
        if (currentMobCap > maxMobCap)
        {
            currentMobCap = maxMobCap;
        }
        if (bossNight)
        {
            currentMobCap /= 3;
        }
        if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
        {
            currentMobCap = (int)((float)num + (float)currentDay * 0.5f);
        }
    }

    private void DayLoop()
    {
        int num = Mathf.FloorToInt(DayCycle.totalTime);
        if (num > currentDay)
        {
            NewDay(num);
        }
        else if (!nightStarted && DayCycle.time > 0.5f && DayCycle.time < 0.95f)
        {
            nightStarted = true;
            StartNight();
        }
    }

    private void StartNight()
    {
        if (currentDay != 0 && currentDay % GameManager.gameSettings.BossDay() == 0 && GameManager.gameSettings.gameMode == GameSettings.GameMode.Survival)
        {
            MobType mobType = bossRotation[UnityEngine.Random.Range(0, bossRotation.Count)];
            bossRotation.Remove(mobType);
            if (bossRotation.Count < 1)
            {
                ResetBossRotations();
            }
            if (currentDay == GameManager.gameSettings.BossDay())
            {
                bossNight = true;
                FindMobCap();
            }
            StartBoss(mobType);
            MusicController.Instance.PlaySong(MusicController.SongType.Boss, chanceToSkip: false);
        }
        else
        {
            MusicController.Instance.PlaySong(MusicController.SongType.Night);
        }
        Invoke("CheckMobSpawns", UnityEngine.Random.Range(checkMobUpdateInterval.x, checkMobUpdateInterval.y));
    }

    public void StartBoss(MobType bossMob)
    {
        float bossMultiplier = 0.85f + 0.15f * (float)GameManager.instance.GetPlayersAlive();
        SpawnMob(bossMob, FindBossPosition(), 1f, bossMultiplier, Mob.BossType.BossNight, bypassCap: true);
    }

    private void CheckMobSpawns()
    {
        if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative || GameManager.instance.boatLeft)
        {
            return;
        }
        float num = (float)GameManager.instance.GetPlayersAlive() / 2f;
        Invoke("CheckMobSpawns", UnityEngine.Random.Range(checkMobUpdateInterval.x / num, checkMobUpdateInterval.y / num));
        activeMobs = MobManager.Instance.GetActiveEnemies();
        if (GameManager.state != GameManager.GameState.Playing || DayCycle.time < 0.5f || activeMobs > maxMobCap || activeMobs > currentMobCap)
        {
            return;
        }
        int num2 = FindRandomAlivePlayer();
        if (num2 != -1)
        {
            MobType mobType = SelectMobToSpawn();
            int value = UnityEngine.Random.Range(1, 3);
            if (mobType.boss)
            {
                value = UnityEngine.Random.Range(1, 2);
            }
            value = Mathf.Clamp(value, 1, currentMobCap - activeMobs);
            for (int i = 0; i < value; i++)
            {
                SpawnMob(mobType, FindPositionAroundPlayer(num2));
            }
        }
    }

    private int FindRandomAlivePlayer()
    {
        List<int> list = new List<int>();
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if ((bool)value && !value.dead)
            {
                list.Add(value.id);
            }
        }
        if (list.Count < 1)
        {
            return -1;
        }
        return list[UnityEngine.Random.Range(0, list.Count)];
    }

    public MobType SelectMobToSpawn(bool shrine = false)
    {
        float num = UnityEngine.Random.Range(0f, 1f);
        float num2 = 0f;
        float num3 = totalWeight;
        if (shrine)
        {
            num3 = CalculateSpawnWeights(currentDay + 2);
        }
        MonoBehaviour.print("total weight: " + num3);
        for (int i = 0; i < mobs.Length; i++)
        {
            num2 += mobs[i].currentWeight;
            if (num < num2 / num3)
            {
                return mobs[i].mob;
            }
        }
        MonoBehaviour.print("fouind nothing");
        return mobs[0].mob;
    }

    private Vector3 FindPositionAroundPlayer(int selectedPlayerId)
    {
        Vector3 zero;
        if (!GameManager.players[selectedPlayerId])
        {
            Debug.LogError("COuldnt find selected player");
            zero = Vector3.zero;
            return Vector3.zero;
        }
        zero = GameManager.players[selectedPlayerId].transform.position;
        Vector2 vector = UnityEngine.Random.insideUnitCircle * 60f;
        Vector3 vector2 = new Vector3(vector.x, 0f, vector.y);
        MonoBehaviour.print("offset: " + vector2);
        if (Physics.Raycast(zero + Vector3.up * 20f + vector2, Vector3.down, out var hitInfo, 5000f, whatIsSpawnable))
        {
            return hitInfo.point;
        }
        Debug.LogError("Failed to spawn");
        return Vector3.zero;
    }

    private Vector3 FindBossPosition()
    {
        return FindPositionAroundPlayer(FindRandomAlivePlayer());
    }

    private int SpawnMob(MobType mob, Vector3 pos, float multiplier = 1f, float bossMultiplier = 1f, Mob.BossType bossType = Mob.BossType.None, bool bypassCap = false)
    {
        float num = 0.01f + Mathf.Clamp((float)currentDay * 0.01f, 0.05f, 0.3f);
        if (UnityEngine.Random.Range(0f, 1f) < num)
        {
            multiplier = 1.5f;
        }
        if (!bypassCap && (activeMobs > maxMobCap || activeMobs > currentMobCap))
        {
            return -1;
        }
        int nextId = MobManager.Instance.GetNextId();
        MobSpawner.Instance.ServerSpawnNewMob(nextId, mob.id, pos, multiplier, bossMultiplier, bossType);
        return nextId;
    }

    private float CalculateSpawnWeights(int day)
    {
        float num = 0f;
        MobSpawn[] array = mobs;
        foreach (MobSpawn mobSpawn in array)
        {
            if (day >= mobSpawn.dayStart)
            {
                int num2 = Mathf.Clamp(day, mobSpawn.dayStart, mobSpawn.dayPeak);
                int num3 = mobSpawn.dayPeak - mobSpawn.dayStart + 1;
                int num4 = num2 - mobSpawn.dayStart + 1;
                if (num3 == 0)
                {
                    mobSpawn.currentWeight = mobSpawn.maxWeight;
                }
                else
                {
                    mobSpawn.currentWeight = (float)num4 / (float)num3;
                }
                num += mobSpawn.currentWeight;
            }
        }
        return num;
    }

    public void TimeoutPlayers()
    {
        foreach (Client value in Server.clients.Values)
        {
            if (value != null && value.player != null && value.player.id != LocalClient.instance.myId)
            {
                int num = 60;
                if (Time.time - value.player.lastPingTime > (float)num)
                {
                    Debug.Log("Kicking player: " + value.player.username + " with id " + value.player.id);
                    SteamNetworking.CloseP2PSessionWithUser(value.player.steamId.Value);
                    ServerHandle.DisconnectPlayer(value.player.id);
                    break;
                }
            }
        }
    }
}
