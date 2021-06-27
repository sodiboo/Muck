using System;
using UnityEngine;

public class Skills : MonoBehaviour
{
	public static int XpToLevel(int xp)
	{
		return Mathf.FloorToInt(Skills.NthRoot((float)xp, Skills.y) * Skills.x);
	}

	public static int XpForLevel(int level)
	{
		return (int)Mathf.Pow((float)level / Skills.x, Skills.y);
	}

	public static float LevelProgress(int xp)
	{
		int num = Skills.XpToLevel(xp);
		float num2 = (float)(xp - Skills.XpForLevel(num));
		int num3 = Skills.XpForLevel(num + 1) - Skills.XpForLevel(num);
		return num2 / (float)num3;
	}

	public static float NthRoot(float A, float N)
	{
		return Mathf.Pow(A, 1f / N);
	}

	public static int woodcuttingXp;

	public static int miningXp;

	public static int buildingXp;

	public static int craftingXp;

	private static float x = 0.07f;

	private static float y = 1.55f;
}
