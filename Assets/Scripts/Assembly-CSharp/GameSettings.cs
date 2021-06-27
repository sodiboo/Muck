using System;

public class GameSettings
{
	public GameSettings.GameMode gameMode { get; set; }

	public GameSettings.FriendlyFire friendlyFire { get; set; }

	public GameSettings.Difficulty difficulty { get; set; }

	public GameSettings.Respawn respawn { get; set; }

	public GameSettings.GameLength gameLength { get; set; }

	public GameSettings.Multiplayer multiplayer { get; set; }

	public GameSettings(int seed, GameSettings.GameMode gameMode = GameSettings.GameMode.Survival, GameSettings.FriendlyFire friendlyFire = GameSettings.FriendlyFire.Off, GameSettings.Difficulty difficulty = GameSettings.Difficulty.Normal, GameSettings.GameLength gameLength = GameSettings.GameLength.Short, GameSettings.Multiplayer multiplayer = GameSettings.Multiplayer.On)
	{
		this.Seed = seed;
		this.gameMode = gameMode;
		this.friendlyFire = friendlyFire;
		this.difficulty = difficulty;
		this.gameLength = gameLength;
		this.multiplayer = multiplayer;
	}

	public GameSettings(int seed, int gameMode, int friendlyFire, int difficulty, int gameLength, int multiplayer)
	{
		this.Seed = seed;
		this.gameMode = (GameSettings.GameMode)gameMode;
		this.friendlyFire = (GameSettings.FriendlyFire)friendlyFire;
		this.difficulty = (GameSettings.Difficulty)difficulty;
		this.gameLength = (GameSettings.GameLength)gameLength;
		this.multiplayer = (GameSettings.Multiplayer)multiplayer;
	}

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

	public int Seed;

	public enum GameMode
	{
		Survival,
		Versus,
		Creative
	}

	public enum FriendlyFire
	{
		Off,
		On
	}

	public enum Difficulty
	{
		Easy,
		Normal,
		Gamer
	}

	public enum Respawn
	{
		OnNewDay,
		Never
	}

	public enum GameLength
	{
		Short = 3,
		Medium = 8,
		Long = 14
	}

	public enum Multiplayer
	{
		Off,
		On
	}
}
