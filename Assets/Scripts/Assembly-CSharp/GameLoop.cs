using System.Collections.Generic;
using Steamworks;
using UnityEngine;

public class GameLoop : MonoBehaviour
{
	public static int currentMobCap { get; set; } = 999;

	private void ResetBossRotations()
	{
		this.bossRotation = new List<MobType>();
		foreach (MobType item in this.bosses)
		{
			this.bossRotation.Add(item);
		}
	}

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

	private void Awake()
	{
		GameLoop.Instance = this;
		this.ResetBossRotations();
	}

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

	public void StartBoss(MobType bossMob)
	{
		float bossMultiplier = 0.85f + 0.15f * (float)GameManager.instance.GetPlayersAlive();
		this.SpawnMob(bossMob, this.FindBossPosition(), 1f, bossMultiplier, Mob.BossType.BossNight, true);
	}

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

	private Vector3 FindBossPosition()
	{
		return this.FindPositionAroundPlayer(this.FindRandomAlivePlayer());
	}

	private int SpawnMob(MobType mob, Vector3 pos, float multiplier = 1f, float bossMultiplier = 1f, Mob.BossType bossType = Mob.BossType.None, bool bypassCap = false)
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) return -1;
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

	public int currentDay = -1;

	private Vector2 maxCheckMobUpdateInterval = new Vector2(3f, 10f);

	private Vector2 checkMobUpdateInterval = new Vector2(3f, 10f);

	public GameLoop.MobSpawn[] mobs;

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

	[System.Serializable]
	public class MobSpawn
	{
		public MobType mob;

		public int dayStart;

		public int dayPeak;

		public float maxWeight;

		public float currentWeight;
	}
}
