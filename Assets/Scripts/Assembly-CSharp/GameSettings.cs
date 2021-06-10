

// Token: 0x020000A5 RID: 165
public class GameSettings
{
	// Token: 0x17000036 RID: 54
	// (get) Token: 0x06000538 RID: 1336 RVA: 0x0001B213 File Offset: 0x00019413
	// (set) Token: 0x06000539 RID: 1337 RVA: 0x0001B21B File Offset: 0x0001941B
	public GameSettings.GameMode gameMode { get; set; }

	// Token: 0x17000037 RID: 55
	// (get) Token: 0x0600053A RID: 1338 RVA: 0x0001B224 File Offset: 0x00019424
	// (set) Token: 0x0600053B RID: 1339 RVA: 0x0001B22C File Offset: 0x0001942C
	public GameSettings.FriendlyFire friendlyFire { get; set; }

	// Token: 0x17000038 RID: 56
	// (get) Token: 0x0600053C RID: 1340 RVA: 0x0001B235 File Offset: 0x00019435
	// (set) Token: 0x0600053D RID: 1341 RVA: 0x0001B23D File Offset: 0x0001943D
	public GameSettings.Difficulty difficulty { get; set; }

	// Token: 0x17000039 RID: 57
	// (get) Token: 0x0600053E RID: 1342 RVA: 0x0001B246 File Offset: 0x00019446
	// (set) Token: 0x0600053F RID: 1343 RVA: 0x0001B24E File Offset: 0x0001944E
	public GameSettings.Respawn respawn { get; set; }

	// Token: 0x1700003A RID: 58
	// (get) Token: 0x06000540 RID: 1344 RVA: 0x0001B257 File Offset: 0x00019457
	// (set) Token: 0x06000541 RID: 1345 RVA: 0x0001B25F File Offset: 0x0001945F
	public GameSettings.GameLength gameLength { get; set; }

	// Token: 0x06000542 RID: 1346 RVA: 0x0001B268 File Offset: 0x00019468
	public GameSettings(int seed, GameSettings.GameMode gameMode = GameSettings.GameMode.Survival, GameSettings.FriendlyFire friendlyFire = GameSettings.FriendlyFire.Off, GameSettings.Difficulty difficulty = GameSettings.Difficulty.Normal, GameSettings.GameLength gameLength = GameSettings.GameLength.Short)
	{
		this.Seed = seed;
		this.gameMode = gameMode;
		this.friendlyFire = friendlyFire;
		this.difficulty = difficulty;
		this.gameLength = gameLength;
	}

	// Token: 0x06000543 RID: 1347 RVA: 0x0001B268 File Offset: 0x00019468
	public GameSettings(int seed, int gameMode, int friendlyFire, int difficulty, int gameLength)
	{
		this.Seed = seed;
		this.gameMode = (GameSettings.GameMode)gameMode;
		this.friendlyFire = (GameSettings.FriendlyFire)friendlyFire;
		this.difficulty = (GameSettings.Difficulty)difficulty;
		this.gameLength = (GameSettings.GameLength)gameLength;
	}

	// Token: 0x06000544 RID: 1348 RVA: 0x0001B298 File Offset: 0x00019498
	public int BossDay()
	{
		switch (this.difficulty)
		{
		case GameSettings.Difficulty.Easy:
			return 6;
		case GameSettings.Difficulty.Normal:
			return 5;
		case GameSettings.Difficulty.Gamer:
			return 3;
		default:
			return 5;
		}
	}

	// Token: 0x06000545 RID: 1349 RVA: 0x0001B2C8 File Offset: 0x000194C8
	public float GetChestPriceMultiplier()
	{
		switch (this.difficulty)
		{
		case GameSettings.Difficulty.Easy:
			return 9f;
		case GameSettings.Difficulty.Normal:
			return 7f;
		case GameSettings.Difficulty.Gamer:
			return 6f;
		default:
			return 5f;
		}
	}

	// Token: 0x06000546 RID: 1350 RVA: 0x0001B308 File Offset: 0x00019508
	public int DayLength()
	{
		switch (this.difficulty)
		{
		case GameSettings.Difficulty.Easy:
			return 56;
		case GameSettings.Difficulty.Normal:
			return 54;
		case GameSettings.Difficulty.Gamer:
			return 52;
		default:
			return 5;
		}
	}

	// Token: 0x0400043C RID: 1084
	public int Seed;

	// Token: 0x02000129 RID: 297
	public enum GameMode
	{
		// Token: 0x040007A7 RID: 1959
		Survival,
		// Token: 0x040007A8 RID: 1960
		Versus,
		// Token: 0x040007A9 RID: 1961
		Creative
	}

	// Token: 0x0200012A RID: 298
	public enum FriendlyFire
	{
		// Token: 0x040007AB RID: 1963
		Off,
		// Token: 0x040007AC RID: 1964
		On
	}

	// Token: 0x0200012B RID: 299
	public enum Difficulty
	{
		// Token: 0x040007AE RID: 1966
		Easy,
		// Token: 0x040007AF RID: 1967
		Normal,
		// Token: 0x040007B0 RID: 1968
		Gamer
	}

	// Token: 0x0200012C RID: 300
	public enum Respawn
	{
		// Token: 0x040007B2 RID: 1970
		OnNewDay,
		// Token: 0x040007B3 RID: 1971
		Never
	}

	// Token: 0x0200012D RID: 301
	public enum GameLength
	{
		// Token: 0x040007B5 RID: 1973
		Short = 3,
		// Token: 0x040007B6 RID: 1974
		Medium = 8,
		// Token: 0x040007B7 RID: 1975
		Long = 14
	}
}
