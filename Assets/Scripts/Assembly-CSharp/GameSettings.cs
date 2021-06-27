using System;

// Token: 0x020000CC RID: 204
public class GameSettings
{
	// Token: 0x17000042 RID: 66
	// (get) Token: 0x0600063E RID: 1598 RVA: 0x00020D2B File Offset: 0x0001EF2B
	// (set) Token: 0x0600063F RID: 1599 RVA: 0x00020D33 File Offset: 0x0001EF33
	public GameSettings.GameMode gameMode { get; set; }

	// Token: 0x17000043 RID: 67
	// (get) Token: 0x06000640 RID: 1600 RVA: 0x00020D3C File Offset: 0x0001EF3C
	// (set) Token: 0x06000641 RID: 1601 RVA: 0x00020D44 File Offset: 0x0001EF44
	public GameSettings.FriendlyFire friendlyFire { get; set; }

	// Token: 0x17000044 RID: 68
	// (get) Token: 0x06000642 RID: 1602 RVA: 0x00020D4D File Offset: 0x0001EF4D
	// (set) Token: 0x06000643 RID: 1603 RVA: 0x00020D55 File Offset: 0x0001EF55
	public GameSettings.Difficulty difficulty { get; set; }

	// Token: 0x17000045 RID: 69
	// (get) Token: 0x06000644 RID: 1604 RVA: 0x00020D5E File Offset: 0x0001EF5E
	// (set) Token: 0x06000645 RID: 1605 RVA: 0x00020D66 File Offset: 0x0001EF66
	public GameSettings.Respawn respawn { get; set; }

	// Token: 0x17000046 RID: 70
	// (get) Token: 0x06000646 RID: 1606 RVA: 0x00020D6F File Offset: 0x0001EF6F
	// (set) Token: 0x06000647 RID: 1607 RVA: 0x00020D77 File Offset: 0x0001EF77
	public GameSettings.GameLength gameLength { get; set; }

	// Token: 0x17000047 RID: 71
	// (get) Token: 0x06000648 RID: 1608 RVA: 0x00020D80 File Offset: 0x0001EF80
	// (set) Token: 0x06000649 RID: 1609 RVA: 0x00020D88 File Offset: 0x0001EF88
	public GameSettings.Multiplayer multiplayer { get; set; }

	// Token: 0x0600064A RID: 1610 RVA: 0x00020D91 File Offset: 0x0001EF91
	public GameSettings(int seed, GameSettings.GameMode gameMode = GameSettings.GameMode.Survival, GameSettings.FriendlyFire friendlyFire = GameSettings.FriendlyFire.Off, GameSettings.Difficulty difficulty = GameSettings.Difficulty.Normal, GameSettings.GameLength gameLength = GameSettings.GameLength.Short, GameSettings.Multiplayer multiplayer = GameSettings.Multiplayer.On)
	{
		this.Seed = seed;
		this.gameMode = gameMode;
		this.friendlyFire = friendlyFire;
		this.difficulty = difficulty;
		this.gameLength = gameLength;
		this.multiplayer = multiplayer;
	}

	// Token: 0x0600064B RID: 1611 RVA: 0x00020D91 File Offset: 0x0001EF91
	public GameSettings(int seed, int gameMode, int friendlyFire, int difficulty, int gameLength, int multiplayer)
	{
		this.Seed = seed;
		this.gameMode = (GameSettings.GameMode)gameMode;
		this.friendlyFire = (GameSettings.FriendlyFire)friendlyFire;
		this.difficulty = (GameSettings.Difficulty)difficulty;
		this.gameLength = (GameSettings.GameLength)gameLength;
		this.multiplayer = (GameSettings.Multiplayer)multiplayer;
	}

	// Token: 0x0600064C RID: 1612 RVA: 0x00020DC8 File Offset: 0x0001EFC8
	public int BossDay()
	{
		switch (this.difficulty)
		{
		case GameSettings.Difficulty.Easy:
			return 6;
		case GameSettings.Difficulty.Normal:
			return 4;
		case GameSettings.Difficulty.Gamer:
			return 3;
		default:
			return 5;
		}
	}

	// Token: 0x0600064D RID: 1613 RVA: 0x00020DF8 File Offset: 0x0001EFF8
	public float GetChestPriceMultiplier()
	{
		switch (this.difficulty)
		{
		case GameSettings.Difficulty.Easy:
			return 8f;
		case GameSettings.Difficulty.Normal:
			return 6f;
		case GameSettings.Difficulty.Gamer:
			return 5f;
		default:
			return 5f;
		}
	}

	// Token: 0x0600064E RID: 1614 RVA: 0x00020E38 File Offset: 0x0001F038
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

	// Token: 0x0400054C RID: 1356
	public int Seed;

	// Token: 0x02000166 RID: 358
	public enum GameMode
	{
		// Token: 0x04000920 RID: 2336
		Survival,
		// Token: 0x04000921 RID: 2337
		Versus,
		// Token: 0x04000922 RID: 2338
		Creative
	}

	// Token: 0x02000167 RID: 359
	public enum FriendlyFire
	{
		// Token: 0x04000924 RID: 2340
		Off,
		// Token: 0x04000925 RID: 2341
		On
	}

	// Token: 0x02000168 RID: 360
	public enum Difficulty
	{
		// Token: 0x04000927 RID: 2343
		Easy,
		// Token: 0x04000928 RID: 2344
		Normal,
		// Token: 0x04000929 RID: 2345
		Gamer
	}

	// Token: 0x02000169 RID: 361
	public enum Respawn
	{
		// Token: 0x0400092B RID: 2347
		OnNewDay,
		// Token: 0x0400092C RID: 2348
		Never
	}

	// Token: 0x0200016A RID: 362
	public enum GameLength
	{
		// Token: 0x0400092E RID: 2350
		Short = 3,
		// Token: 0x0400092F RID: 2351
		Medium = 8,
		// Token: 0x04000930 RID: 2352
		Long = 14
	}

	// Token: 0x0200016B RID: 363
	public enum Multiplayer
	{
		// Token: 0x04000932 RID: 2354
		Off,
		// Token: 0x04000933 RID: 2355
		On
	}
}
