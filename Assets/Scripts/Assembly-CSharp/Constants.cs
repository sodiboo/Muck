using System;
using UnityEngine;

// Token: 0x020000CF RID: 207
public class Constants
{
	// Token: 0x040004D6 RID: 1238
	public const int TICKS_PER_SEC = 64;

	// Token: 0x040004D7 RID: 1239
	public const int MAX_PLAYERS = 40;

	// Token: 0x040004D8 RID: 1240
	public const int MAX_SHOOTING_DISTANCE = 1000;

	// Token: 0x040004D9 RID: 1241
	public const int MS_PER_TICK = 15;

	// Token: 0x040004DA RID: 1242
	public static Color RED = new Color(1f, 0f, 0.016f);

	// Token: 0x040004DB RID: 1243
	public static Color GREEN = new Color(0.1314794f, 0.83f, 0.084f);

	// Token: 0x040004DC RID: 1244
	public static Color BLUE = new Color(0.13f, 0.34f, 1f);

	// Token: 0x040004DD RID: 1245
	public static Color YELLOW = new Color(0.87f, 1f, 0f);

	// Token: 0x040004DE RID: 1246
	public static Color CYAN = new Color(0.14f, 0.88f, 0.68f);

	// Token: 0x040004DF RID: 1247
	public static Color BLACK = new Color(0.1f, 0.1f, 0.1f);

	// Token: 0x040004E0 RID: 1248
	public static Color WHITE = new Color(0.9f, 0.9f, 0.9f);

	// Token: 0x040004E1 RID: 1249
	public static Color PINK = new Color(1f, 0.2f, 0.7f);

	// Token: 0x040004E2 RID: 1250
	public static Color ORANGE = new Color(1f, 0.48f, 0.04f);

	// Token: 0x040004E3 RID: 1251
	public static Color BROWN = new Color(0.415f, 0.2f, 0.15f);

	// Token: 0x040004E4 RID: 1252
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
