public class GameSettings
{
	public enum GameMode
	{
		Survival = 0,
		Versus = 1,
		Creative = 2,
	}

	public enum FriendlyFire
	{
		Off = 0,
		On = 1,
	}

	public enum Difficulty
	{
		Easy = 0,
		Normal = 1,
		Gamer = 2,
	}

	public enum GameLength
	{
		Short = 3,
		Medium = 8,
		Long = 14,
	}

	public enum Multiplayer
	{
		Off = 0,
		On = 1,
	}

	public GameSettings(int seed, GameSettings.GameMode gameMode, GameSettings.FriendlyFire friendlyFire, GameSettings.Difficulty difficulty, GameSettings.GameLength gameLength, GameSettings.Multiplayer multiplayer)
	{
	}

	public int Seed;
}
