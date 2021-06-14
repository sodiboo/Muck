using System;

// Token: 0x020000D9 RID: 217
public class GameSettings
{
	// Token: 0x1700003E RID: 62
	// (get) Token: 0x060005C8 RID: 1480 RVA: 0x00005987 File Offset: 0x00003B87
	// (set) Token: 0x060005C9 RID: 1481 RVA: 0x0000598F File Offset: 0x00003B8F
	public GameSettings.GameMode gameMode { get; set; }

	// Token: 0x1700003F RID: 63
	// (get) Token: 0x060005CA RID: 1482 RVA: 0x00005998 File Offset: 0x00003B98
	// (set) Token: 0x060005CB RID: 1483 RVA: 0x000059A0 File Offset: 0x00003BA0
	public GameSettings.FriendlyFire friendlyFire { get; set; }

	// Token: 0x17000040 RID: 64
	// (get) Token: 0x060005CC RID: 1484 RVA: 0x000059A9 File Offset: 0x00003BA9
	// (set) Token: 0x060005CD RID: 1485 RVA: 0x000059B1 File Offset: 0x00003BB1
	public GameSettings.Difficulty difficulty { get; set; }

	// Token: 0x17000041 RID: 65
	// (get) Token: 0x060005CE RID: 1486 RVA: 0x000059BA File Offset: 0x00003BBA
	// (set) Token: 0x060005CF RID: 1487 RVA: 0x000059C2 File Offset: 0x00003BC2
	public GameSettings.Respawn respawn { get; set; }

	// Token: 0x17000042 RID: 66
	// (get) Token: 0x060005D0 RID: 1488 RVA: 0x000059CB File Offset: 0x00003BCB
	// (set) Token: 0x060005D1 RID: 1489 RVA: 0x000059D3 File Offset: 0x00003BD3
	public GameSettings.GameLength gameLength { get; set; }

	// Token: 0x17000043 RID: 67
	// (get) Token: 0x060005D2 RID: 1490 RVA: 0x000059DC File Offset: 0x00003BDC
	// (set) Token: 0x060005D3 RID: 1491 RVA: 0x000059E4 File Offset: 0x00003BE4
	public GameSettings.Multiplayer multiplayer { get; set; }

	// Token: 0x060005D4 RID: 1492 RVA: 0x000059ED File Offset: 0x00003BED
	public GameSettings(int seed, GameSettings.GameMode gameMode = GameSettings.GameMode.Survival, GameSettings.FriendlyFire friendlyFire = GameSettings.FriendlyFire.Off, GameSettings.Difficulty difficulty = GameSettings.Difficulty.Normal, GameSettings.GameLength gameLength = GameSettings.GameLength.Short, GameSettings.Multiplayer multiplayer = GameSettings.Multiplayer.On)
	{
		this.Seed = seed;
		this.gameMode = gameMode;
		this.friendlyFire = friendlyFire;
		this.difficulty = difficulty;
		this.gameLength = gameLength;
		this.multiplayer = multiplayer;
	}

	// Token: 0x060005D5 RID: 1493 RVA: 0x000059ED File Offset: 0x00003BED
	public GameSettings(int seed, int gameMode, int friendlyFire, int difficulty, int gameLength, int multiplayer)
	{
		this.Seed = seed;
		this.gameMode = (GameSettings.GameMode)gameMode;
		this.friendlyFire = (GameSettings.FriendlyFire)friendlyFire;
		this.difficulty = (GameSettings.Difficulty)difficulty;
		this.gameLength = (GameSettings.GameLength)gameLength;
		this.multiplayer = (GameSettings.Multiplayer)multiplayer;
	}

	// Token: 0x060005D6 RID: 1494 RVA: 0x0001F5E8 File Offset: 0x0001D7E8
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

	// Token: 0x060005D7 RID: 1495 RVA: 0x0001F618 File Offset: 0x0001D818
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

	// Token: 0x060005D8 RID: 1496 RVA: 0x0001F658 File Offset: 0x0001D858
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

	// Token: 0x04000519 RID: 1305
	public int Seed;

	// Token: 0x020000DA RID: 218
	public enum GameMode
	{
		// Token: 0x04000521 RID: 1313
		Survival,
		// Token: 0x04000522 RID: 1314
		Versus,
		// Token: 0x04000523 RID: 1315
		Creative
	}

	// Token: 0x020000DB RID: 219
	public enum FriendlyFire
	{
		// Token: 0x04000525 RID: 1317
		Off,
		// Token: 0x04000526 RID: 1318
		On
	}

	// Token: 0x020000DC RID: 220
	public enum Difficulty
	{
		// Token: 0x04000528 RID: 1320
		Easy,
		// Token: 0x04000529 RID: 1321
		Normal,
		// Token: 0x0400052A RID: 1322
		Gamer
	}

	// Token: 0x020000DD RID: 221
	public enum Respawn
	{
		// Token: 0x0400052C RID: 1324
		OnNewDay,
		// Token: 0x0400052D RID: 1325
		Never
	}

	// Token: 0x020000DE RID: 222
	public enum GameLength
	{
		// Token: 0x0400052F RID: 1327
		Short = 3,
		// Token: 0x04000530 RID: 1328
		Medium = 8,
		// Token: 0x04000531 RID: 1329
		Long = 14
	}

	// Token: 0x020000DF RID: 223
	public enum Multiplayer
	{
		// Token: 0x04000533 RID: 1331
		Off,
		// Token: 0x04000534 RID: 1332
		On
	}
}
