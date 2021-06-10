using System;
using System.Collections.Generic;
using Steamworks;
using UnityEngine;
using Random = UnityEngine.Random;

// Token: 0x02000027 RID: 39
public class GameLoop : MonoBehaviour
{
	// Token: 0x17000008 RID: 8
	// (get) Token: 0x060000E2 RID: 226 RVA: 0x000066D7 File Offset: 0x000048D7
	// (set) Token: 0x060000E3 RID: 227 RVA: 0x000066DE File Offset: 0x000048DE
	public static int currentMobCap { get; set; } = 999;

	// Token: 0x060000E4 RID: 228 RVA: 0x000066E6 File Offset: 0x000048E6
	private void Update()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		if (GameManager.state != GameManager.GameState.Playing)
		{
			return;
		}
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative)
		{
			return;
		}
		this.DayLoop();
	}

	// Token: 0x060000E5 RID: 229 RVA: 0x0000670D File Offset: 0x0000490D
	private void Awake()
	{
		GameLoop.Instance = this;
	}

	// Token: 0x060000E6 RID: 230 RVA: 0x00006718 File Offset: 0x00004918
	public void StartLoop()
	{
		if (!LocalClient.serverOwner)
		{
			Destroy(this);
		}
		foreach (Client client in Server.clients.Values)
		{
			if (client != null)
			{
				Player player = client.player;
				if (player != null)
				{
					player.PingPlayer();
				}
			}
		}
		base.InvokeRepeating("TimeoutPlayers", 2f, 2f);
	}

	// Token: 0x060000E7 RID: 231 RVA: 0x000067A0 File Offset: 0x000049A0
	private void NewDay(int day)
	{
		if (GameManager.instance.GetPlayersAlive() <= 0)
		{
			return;
		}
		this.bossNight = false;
		this.nightStarted = false;
		this.currentDay = day;
		base.CancelInvoke("CheckMobSpawns");
		ServerSend.NewDay(day);
		GameManager.instance.UpdateDay(day);
		this.totalWeight = this.CalculateSpawnWeights(this.currentDay);
		int num = GameManager.instance.GetPlayersInLobby();
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			num = GameManager.instance.GetPlayersAlive();
		}
		int difficulty = (int)GameManager.gameSettings.difficulty;
		GameLoop.currentMobCap = 3 + difficulty + (int)((float)(num - 1) * 0.2f);
		GameLoop.currentMobCap = (int)((float)GameLoop.currentMobCap + (float)(GameLoop.currentMobCap * this.currentDay) * 0.5f);
		if (GameLoop.currentMobCap > this.maxMobCap)
		{
			GameLoop.currentMobCap = this.maxMobCap;
		}
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			GameLoop.currentMobCap = (int)((float)num + (float)this.currentDay * 0.5f);
		}
		float d = 1f - PowerupInventory.CumulativeDistribution(this.currentDay, 0.05f, 0.5f);
		this.checkMobUpdateInterval = this.maxCheckMobUpdateInterval * d;
		MusicController.Instance.PlaySong(MusicController.SongType.Day, true);
	}

	// Token: 0x060000E8 RID: 232 RVA: 0x000068D8 File Offset: 0x00004AD8
	private void DayLoop()
	{
		int num = Mathf.FloorToInt(DayCycle.totalTime);
		if (num > this.currentDay)
		{
			this.NewDay(num);
			return;
		}
		if (!this.nightStarted && DayCycle.time > 0.5f && DayCycle.time < 0.95f)
		{
			this.nightStarted = true;
			this.StartNight();
		}
	}

	// Token: 0x060000E9 RID: 233 RVA: 0x00006930 File Offset: 0x00004B30
	private void StartNight()
	{
		if (this.currentDay != 0 && this.currentDay % GameManager.gameSettings.BossDay() == 0 && GameManager.gameSettings.gameMode == GameSettings.GameMode.Survival)
		{
			MobType bossMob = this.bosses[0];
			this.StartBoss(bossMob);
			MusicController.Instance.PlaySong(MusicController.SongType.Boss, false);
		}
		else
		{
			MusicController.Instance.PlaySong(MusicController.SongType.Night, true);
		}
		base.Invoke("CheckMobSpawns", Random.Range(this.checkMobUpdateInterval.x, this.checkMobUpdateInterval.y));
	}

	// Token: 0x060000EA RID: 234 RVA: 0x000069B4 File Offset: 0x00004BB4
	public void StartBoss(MobType bossMob)
	{
		float bossMultiplier = 0.9f + 0.1f * (float)GameManager.instance.GetPlayersAlive();
		this.SpawnMob(bossMob, this.FindBossPosition(), 1f, bossMultiplier);
	}

	// Token: 0x060000EB RID: 235 RVA: 0x000069F0 File Offset: 0x00004BF0
	private void CheckMobSpawns()
	{
		if (this.bossNight || GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative)
		{
			return;
		}
		float num = (float)GameManager.instance.GetPlayersAlive() / 2f;
		base.Invoke("CheckMobSpawns", Random.Range(this.checkMobUpdateInterval.x / num, this.checkMobUpdateInterval.y / num));
		this.activeMobs = MobManager.Instance.GetActiveEnemies();
		if (GameManager.state != GameManager.GameState.Playing)
		{
			return;
		}
		if (DayCycle.time < 0.5f)
		{
			return;
		}
		if (this.activeMobs > this.maxMobCap || this.activeMobs > GameLoop.currentMobCap)
		{
			return;
		}
		int num2 = this.FindRandomAlivePlayer();
		if (num2 == -1)
		{
			return;
		}
		MobType mob = this.SelectMobToSpawn(false);
		int num3 = Random.Range(1, 3);
		num3 = Mathf.Clamp(num3, 1, GameLoop.currentMobCap - this.activeMobs);
		for (int i = 0; i < num3; i++)
		{
			this.SpawnMob(mob, this.FindPositionAroundPlayer(num2), 1f, 1f);
		}
	}

	// Token: 0x060000EC RID: 236 RVA: 0x00006AEC File Offset: 0x00004CEC
	private int FindRandomAlivePlayer()
	{
		List<int> list = new List<int>();
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (playerManager && !playerManager.dead)
			{
				list.Add(playerManager.id);
			}
		}
		if (list.Count < 1)
		{
			return -1;
		}
		return list[Random.Range(0, list.Count)];
	}

	// Token: 0x060000ED RID: 237 RVA: 0x00006B7C File Offset: 0x00004D7C
	public MobType SelectMobToSpawn(bool shrine = false)
	{
		float num = Random.Range(0f, 1f);
		float num2 = 0f;
		float num3 = this.totalWeight;
		if (shrine)
		{
			num3 = this.CalculateSpawnWeights(this.currentDay + 2);
		}
		MonoBehaviour.print("total weight: " + num3);
		for (int i = 0; i < this.mobs.Length; i++)
		{
			num2 += this.mobs[i].currentWeight;
			if (num < num2 / num3)
			{
				return this.mobs[i].mob;
			}
		}
		MonoBehaviour.print("fouind nothing");
		return this.mobs[0].mob;
	}

	// Token: 0x060000EE RID: 238 RVA: 0x00006C1C File Offset: 0x00004E1C
	private Vector3 FindPositionAroundPlayer(int selectedPlayerId)
	{
		if (!GameManager.players[selectedPlayerId])
		{
			return Vector3.zero;
		}
		Vector3 position = GameManager.players[selectedPlayerId].transform.position;
		Vector2 vector = Random.insideUnitCircle * 60f;
		Vector3 vector2 = new Vector3(vector.x, 0f, vector.y);
		MonoBehaviour.print("offset: " + vector2);
		RaycastHit raycastHit;
		if (Physics.Raycast(position + Vector3.up * 20f + vector2, Vector3.down, out raycastHit, 5000f, this.whatIsSpawnable))
		{
			return raycastHit.point;
		}
		Debug.LogError("Failed to spawn");
		return Vector3.zero;
	}

	// Token: 0x060000EF RID: 239 RVA: 0x00006CE2 File Offset: 0x00004EE2
	private Vector3 FindBossPosition()
	{
		return this.FindPositionAroundPlayer(this.FindRandomAlivePlayer());
	}

	// Token: 0x060000F0 RID: 240 RVA: 0x00006CF0 File Offset: 0x00004EF0
	private int SpawnMob(MobType mob, Vector3 pos, float multiplier = 1f, float bossMultiplier = 1f)
	{
		float num = 0.01f + Mathf.Clamp((float)this.currentDay * 0.01f, 0.05f, 0.3f);
		if (Random.Range(0f, 1f) < num)
		{
			multiplier = 1.5f;
		}
		if (this.activeMobs > this.maxMobCap || this.activeMobs > GameLoop.currentMobCap)
		{
			return -1;
		}
		int nextId = MobManager.Instance.GetNextId();
		MobSpawner.Instance.ServerSpawnNewMob(nextId, mob.id, pos, multiplier, bossMultiplier);
		return nextId;
	}

	// Token: 0x060000F1 RID: 241 RVA: 0x00006D7C File Offset: 0x00004F7C
	private float CalculateSpawnWeights(int day)
	{
		float num = 0f;
		foreach (GameLoop.MobSpawn mobSpawn in this.mobs)
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

	// Token: 0x060000F2 RID: 242 RVA: 0x00006E08 File Offset: 0x00005008
	public void TimeoutPlayers()
	{
		foreach (Client client in Server.clients.Values)
		{
			if (client != null && client.player != null)
			{
				int num = 60;
				if (Time.time - client.player.lastPingTime > (float)num)
				{
					Debug.Log(string.Concat(new object[]
					{
						"Kicking player: ",
						client.player.username,
						" with id ",
						client.player.id
					}));
					SteamNetworking.CloseP2PSessionWithUser(client.player.steamId.Value);
					ServerHandle.DisconnectPlayer(client.player.id);
					break;
				}
			}
		}
	}

	// Token: 0x040000DF RID: 223
	public int currentDay = -1;

	// Token: 0x040000E0 RID: 224
	private Vector2 maxCheckMobUpdateInterval = new Vector2(3f, 10f);

	// Token: 0x040000E1 RID: 225
	private Vector2 checkMobUpdateInterval = new Vector2(3f, 10f);

	// Token: 0x040000E2 RID: 226
	public GameLoop.MobSpawn[] mobs;

	// Token: 0x040000E3 RID: 227
	private int activeMobs;

	// Token: 0x040000E4 RID: 228
	private int maxMobCap = 999;

	// Token: 0x040000E6 RID: 230
	private float totalWeight;

	// Token: 0x040000E7 RID: 231
	public LayerMask whatIsSpawnable;

	// Token: 0x040000E8 RID: 232
	[Header("Boss Stuff")]
	public MobType[] bosses;

	// Token: 0x040000E9 RID: 233
	public static GameLoop Instance;

	// Token: 0x040000EA RID: 234
	private bool nightStarted;

	// Token: 0x040000EB RID: 235
	private bool bossNight;

	// Token: 0x0200010A RID: 266
	[Serializable]
	public class MobSpawn
	{
		// Token: 0x0400072A RID: 1834
		public MobType mob;

		// Token: 0x0400072B RID: 1835
		public int dayStart;

		// Token: 0x0400072C RID: 1836
		public int dayPeak;

		// Token: 0x0400072D RID: 1837
		public float maxWeight;

		// Token: 0x0400072E RID: 1838
		public float currentWeight;
	}
}
