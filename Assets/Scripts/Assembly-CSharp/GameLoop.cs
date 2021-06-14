using System.Collections.Generic;
using Steamworks;
using UnityEngine;

// Token: 0x0200002E RID: 46
public class GameLoop : MonoBehaviour
{
	// Token: 0x17000009 RID: 9
	// (get) Token: 0x060000F3 RID: 243 RVA: 0x00002D00 File Offset: 0x00000F00
	// (set) Token: 0x060000F4 RID: 244 RVA: 0x00002D07 File Offset: 0x00000F07
	public static int currentMobCap { get; set; } = 999;

	// Token: 0x060000F5 RID: 245 RVA: 0x0000AF6C File Offset: 0x0000916C
	private void ResetBossRotations()
	{
		this.bossRotation = new List<MobType>();
		foreach (MobType item in this.bosses)
		{
			this.bossRotation.Add(item);
		}
	}

	// Token: 0x060000F6 RID: 246 RVA: 0x00002D0F File Offset: 0x00000F0F
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

	// Token: 0x060000F7 RID: 247 RVA: 0x00002D36 File Offset: 0x00000F36
	private void Awake()
	{
		GameLoop.Instance = this;
		this.ResetBossRotations();
	}

	// Token: 0x060000F8 RID: 248 RVA: 0x0000AFAC File Offset: 0x000091AC
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

	// Token: 0x060000F9 RID: 249 RVA: 0x0000B034 File Offset: 0x00009234
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

	// Token: 0x060000FA RID: 250 RVA: 0x0000B0D4 File Offset: 0x000092D4
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

	// Token: 0x060000FB RID: 251 RVA: 0x0000B194 File Offset: 0x00009394
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

	// Token: 0x060000FC RID: 252 RVA: 0x0000B1EC File Offset: 0x000093EC
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
		base.Invoke("CheckMobSpawns", Random.Range(this.checkMobUpdateInterval.x, this.checkMobUpdateInterval.y));
	}

	// Token: 0x060000FD RID: 253 RVA: 0x0000B2C8 File Offset: 0x000094C8
	public void StartBoss(MobType bossMob)
	{
		float bossMultiplier = 0.85f + 0.15f * (float)GameManager.instance.GetPlayersAlive();
		this.SpawnMob(bossMob, this.FindBossPosition(), 1f, bossMultiplier, Mob.BossType.BossNight, true);
	}

	// Token: 0x060000FE RID: 254 RVA: 0x0000B304 File Offset: 0x00009504
	private void CheckMobSpawns()
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative)
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
			this.SpawnMob(mob, this.FindPositionAroundPlayer(num2), 1f, 1f, Mob.BossType.None, false);
		}
	}

	// Token: 0x060000FF RID: 255 RVA: 0x0000B3F8 File Offset: 0x000095F8
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

	// Token: 0x06000100 RID: 256 RVA: 0x0000B488 File Offset: 0x00009688
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

	// Token: 0x06000101 RID: 257 RVA: 0x0000B528 File Offset: 0x00009728
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

	// Token: 0x06000102 RID: 258 RVA: 0x00002D44 File Offset: 0x00000F44
	private Vector3 FindBossPosition()
	{
		return this.FindPositionAroundPlayer(this.FindRandomAlivePlayer());
	}

	// Token: 0x06000103 RID: 259 RVA: 0x0000B600 File Offset: 0x00009800
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
		MobSpawner.Instance.ServerSpawnNewMob(nextId, mob.id, pos, multiplier, bossMultiplier, bossType);
		return nextId;
	}

	// Token: 0x06000104 RID: 260 RVA: 0x0000B690 File Offset: 0x00009890
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

	// Token: 0x06000105 RID: 261 RVA: 0x0000B71C File Offset: 0x0000991C
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

	// Token: 0x040000FC RID: 252
	public int currentDay = -1;

	// Token: 0x040000FD RID: 253
	private Vector2 maxCheckMobUpdateInterval = new Vector2(3f, 10f);

	// Token: 0x040000FE RID: 254
	private Vector2 checkMobUpdateInterval = new Vector2(3f, 10f);

	// Token: 0x040000FF RID: 255
	public GameLoop.MobSpawn[] mobs;

	// Token: 0x04000100 RID: 256
	private int activeMobs;

	// Token: 0x04000101 RID: 257
	private int maxMobCap = 999;

	// Token: 0x04000103 RID: 259
	private float totalWeight;

	// Token: 0x04000104 RID: 260
	public LayerMask whatIsSpawnable;

	// Token: 0x04000105 RID: 261
	[Header("Boss Stuff")]
	public MobType[] bosses;

	// Token: 0x04000106 RID: 262
	private List<MobType> bossRotation;

	// Token: 0x04000107 RID: 263
	public static GameLoop Instance;

	// Token: 0x04000108 RID: 264
	private bool nightStarted;

	// Token: 0x04000109 RID: 265
	private bool bossNight;

	// Token: 0x0200002F RID: 47
	[System.Serializable]
	public class MobSpawn
	{
		// Token: 0x0400010A RID: 266
		public MobType mob;

		// Token: 0x0400010B RID: 267
		public int dayStart;

		// Token: 0x0400010C RID: 268
		public int dayPeak;

		// Token: 0x0400010D RID: 269
		public float maxWeight;

		// Token: 0x0400010E RID: 270
		public float currentWeight;
	}
}
