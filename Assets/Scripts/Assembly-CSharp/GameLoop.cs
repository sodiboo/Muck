using System.Collections.Generic;
using Steamworks;
using UnityEngine;

// Token: 0x02000039 RID: 57
public class GameLoop : MonoBehaviour
{
	// Token: 0x1700000E RID: 14
	// (get) Token: 0x06000149 RID: 329 RVA: 0x0000801F File Offset: 0x0000621F
	// (set) Token: 0x0600014A RID: 330 RVA: 0x00008026 File Offset: 0x00006226
	public static int currentMobCap { get; set; } = 999;

	// Token: 0x0600014B RID: 331 RVA: 0x00008030 File Offset: 0x00006230
	private void ResetBossRotations()
	{
		this.bossRotation = new List<MobType>();
		foreach (MobType item in this.bosses)
		{
			this.bossRotation.Add(item);
		}
	}

	// Token: 0x0600014C RID: 332 RVA: 0x0000806D File Offset: 0x0000626D
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

	// Token: 0x0600014D RID: 333 RVA: 0x00008094 File Offset: 0x00006294
	private void Awake()
	{
		GameLoop.Instance = this;
		this.ResetBossRotations();
	}

	// Token: 0x0600014E RID: 334 RVA: 0x000080A4 File Offset: 0x000062A4
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
		InvokeRepeating(nameof(TimeoutPlayers), 2f, 2f);
	}

	// Token: 0x0600014F RID: 335 RVA: 0x0000812C File Offset: 0x0000632C
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
		this.FindMobCap();
		float d = 1f - PowerupInventory.CumulativeDistribution(this.currentDay, 0.05f, 0.5f);
		this.checkMobUpdateInterval = this.maxCheckMobUpdateInterval * d;
		MusicController.Instance.PlaySong(MusicController.SongType.Day, true);
	}

	// Token: 0x06000150 RID: 336 RVA: 0x000081CC File Offset: 0x000063CC
	private void FindMobCap()
	{
		int num = GameManager.instance.GetPlayersInLobby();
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			num = GameManager.instance.GetPlayersAlive();
		}
		int difficulty = (int)GameManager.gameSettings.difficulty;
		GameLoop.currentMobCap = 3 + difficulty + (int)((float)(num - 1) * 0.2f);
		GameLoop.currentMobCap = (int)((float)GameLoop.currentMobCap + (float)(GameLoop.currentMobCap * this.currentDay) * 0.4f);
		if (GameLoop.currentMobCap > this.maxMobCap)
		{
			GameLoop.currentMobCap = this.maxMobCap;
		}
		if (this.bossNight)
		{
			GameLoop.currentMobCap /= 3;
		}
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Versus)
		{
			GameLoop.currentMobCap = (int)((float)num + (float)this.currentDay * 0.5f);
		}
	}

	// Token: 0x06000151 RID: 337 RVA: 0x0000828C File Offset: 0x0000648C
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

	// Token: 0x06000152 RID: 338 RVA: 0x000082E4 File Offset: 0x000064E4
	private void StartNight()
	{
		if (this.currentDay != 0 && this.currentDay % GameManager.gameSettings.BossDay() == 0 && GameManager.gameSettings.gameMode == GameSettings.GameMode.Survival)
		{
			MobType mobType = this.bossRotation[Random.Range(0, this.bossRotation.Count)];
			this.bossRotation.Remove(mobType);
			if (this.bossRotation.Count < 1)
			{
				this.ResetBossRotations();
			}
			if (this.currentDay == GameManager.gameSettings.BossDay())
			{
				this.bossNight = true;
				this.FindMobCap();
			}
			this.StartBoss(mobType);
			MusicController.Instance.PlaySong(MusicController.SongType.Boss, false);
		}
		else
		{
			MusicController.Instance.PlaySong(MusicController.SongType.Night, true);
		}
		Invoke(nameof(CheckMobSpawns), Random.Range(this.checkMobUpdateInterval.x, this.checkMobUpdateInterval.y));
	}

	// Token: 0x06000153 RID: 339 RVA: 0x000083C0 File Offset: 0x000065C0
	public void StartBoss(MobType bossMob)
	{
		float bossMultiplier = 0.85f + 0.15f * (float)GameManager.instance.GetPlayersAlive();
		this.SpawnMob(bossMob, this.FindBossPosition(), 1f, bossMultiplier, Mob.BossType.BossNight, true);
	}

	// Token: 0x06000154 RID: 340 RVA: 0x000083FC File Offset: 0x000065FC
	private void CheckMobSpawns()
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative)
		{
			return;
		}
		if (GameManager.instance.boatLeft)
		{
			return;
		}
		float num = (float)GameManager.instance.GetPlayersAlive() / 2f;
		Invoke(nameof(CheckMobSpawns), Random.Range(this.checkMobUpdateInterval.x / num, this.checkMobUpdateInterval.y / num));
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
		MobType mobType = this.SelectMobToSpawn(false);
		int num3 = Random.Range(1, 3);
		if (mobType.boss)
		{
			num3 = Random.Range(1, 2);
		}
		num3 = Mathf.Clamp(num3, 1, GameLoop.currentMobCap - this.activeMobs);
		for (int i = 0; i < num3; i++)
		{
			this.SpawnMob(mobType, this.FindPositionAroundPlayer(num2), 1f, 1f, Mob.BossType.None, false);
		}
	}

	// Token: 0x06000155 RID: 341 RVA: 0x00008510 File Offset: 0x00006710
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

	// Token: 0x06000156 RID: 342 RVA: 0x000085A0 File Offset: 0x000067A0
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

	// Token: 0x06000157 RID: 343 RVA: 0x00008640 File Offset: 0x00006840
	private Vector3 FindPositionAroundPlayer(int selectedPlayerId)
	{
		Vector3 a;
		if (!GameManager.players[selectedPlayerId])
		{
			Debug.LogError("COuldnt find selected player");
			a = Vector3.zero;
			return Vector3.zero;
		}
		a = GameManager.players[selectedPlayerId].transform.position;
		Vector2 vector = Random.insideUnitCircle * 60f;
		Vector3 vector2 = new Vector3(vector.x, 0f, vector.y);
		MonoBehaviour.print("offset: " + vector2);
		RaycastHit raycastHit;
		if (Physics.Raycast(a + Vector3.up * 20f + vector2, Vector3.down, out raycastHit, 5000f, this.whatIsSpawnable))
		{
			return raycastHit.point;
		}
		Debug.LogError("Failed to spawn");
		return Vector3.zero;
	}

	// Token: 0x06000158 RID: 344 RVA: 0x00008718 File Offset: 0x00006918
	private Vector3 FindBossPosition()
	{
		return this.FindPositionAroundPlayer(this.FindRandomAlivePlayer());
	}

	// Token: 0x06000159 RID: 345 RVA: 0x00008728 File Offset: 0x00006928
	private int SpawnMob(MobType mob, Vector3 pos, float multiplier = 1f, float bossMultiplier = 1f, Mob.BossType bossType = Mob.BossType.None, bool bypassCap = false)
	{
		float num = 0.01f + Mathf.Clamp((float)this.currentDay * 0.01f, 0.05f, 0.3f);
		if (Random.Range(0f, 1f) < num)
		{
			multiplier = 1.5f;
		}
		if (!bypassCap && (this.activeMobs > this.maxMobCap || this.activeMobs > GameLoop.currentMobCap))
		{
			return -1;
		}
		int nextId = MobManager.Instance.GetNextId();
		MobSpawner.Instance.ServerSpawnNewMob(nextId, mob.id, pos, multiplier, bossMultiplier, bossType, -1);
		return nextId;
	}

	// Token: 0x0600015A RID: 346 RVA: 0x000087B8 File Offset: 0x000069B8
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

	// Token: 0x0600015B RID: 347 RVA: 0x00008844 File Offset: 0x00006A44
	public void TimeoutPlayers()
	{
		foreach (Client client in Server.clients.Values)
		{
			if (client != null && client.player != null && client.player.id != LocalClient.instance.myId)
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

	// Token: 0x04000147 RID: 327
	public int currentDay = -1;

	// Token: 0x04000148 RID: 328
	private Vector2 maxCheckMobUpdateInterval = new Vector2(3f, 10f);

	// Token: 0x04000149 RID: 329
	private Vector2 checkMobUpdateInterval = new Vector2(3f, 10f);

	// Token: 0x0400014A RID: 330
	public GameLoop.MobSpawn[] mobs;

	// Token: 0x0400014B RID: 331
	private int activeMobs;

	// Token: 0x0400014C RID: 332
	private int maxMobCap = 999;

	// Token: 0x0400014E RID: 334
	private float totalWeight;

	// Token: 0x0400014F RID: 335
	public LayerMask whatIsSpawnable;

	// Token: 0x04000150 RID: 336
	[Header("Boss Stuff")]
	public MobType[] bosses;

	// Token: 0x04000151 RID: 337
	private List<MobType> bossRotation;

	// Token: 0x04000152 RID: 338
	public static GameLoop Instance;

	// Token: 0x04000153 RID: 339
	private bool nightStarted;

	// Token: 0x04000154 RID: 340
	private bool bossNight;

	// Token: 0x02000141 RID: 321
	[System.Serializable]
	public class MobSpawn
	{
		// Token: 0x04000888 RID: 2184
		public MobType mob;

		// Token: 0x04000889 RID: 2185
		public int dayStart;

		// Token: 0x0400088A RID: 2186
		public int dayPeak;

		// Token: 0x0400088B RID: 2187
		public float maxWeight;

		// Token: 0x0400088C RID: 2188
		public float currentWeight;
	}
}
