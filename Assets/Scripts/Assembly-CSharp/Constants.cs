using System;
using UnityEngine;

public class Constants
{
	public const int TICKS_PER_SEC = 64;

	public const int MAX_PLAYERS = 40;

	public const int MAX_SHOOTING_DISTANCE = 1000;

	public const int MS_PER_TICK = 15;

	public static Color RED = new Color(1f, 0f, 0.016f);

	public static Color GREEN = new Color(0.1314794f, 0.83f, 0.084f);

	public static Color BLUE = new Color(0.13f, 0.34f, 1f);

	public static Color YELLOW = new Color(0.87f, 1f, 0f);

	public static Color CYAN = new Color(0.14f, 0.88f, 0.68f);

	public static Color BLACK = new Color(0.1f, 0.1f, 0.1f);

	public static Color WHITE = new Color(0.9f, 0.9f, 0.9f);

	public static Color PINK = new Color(1f, 0.2f, 0.7f);

	public static Color ORANGE = new Color(1f, 0.48f, 0.04f);

	public static Color BROWN = new Color(0.415f, 0.2f, 0.15f);

	public static Color[] colors = new Color[]
	{
		Constants.RED,
		Constants.GREEN,
		Constants.BLUE,
		Constants.YELLOW,
		Constants.CYAN,
		Constants.BLACK,
		Constants.WHITE,
		Constants.PINK,
		Constants.ORANGE,
		Constants.BROWN
	};
}
