using System;
using UnityEngine;

// Token: 0x0200010B RID: 267
public class Skills : MonoBehaviour
{
	// Token: 0x060007DC RID: 2012 RVA: 0x00027D87 File Offset: 0x00025F87
	public static int XpToLevel(int xp)
	{
		return Mathf.FloorToInt(Skills.NthRoot((float)xp, Skills.y) * Skills.x);
	}

	// Token: 0x060007DD RID: 2013 RVA: 0x00027DA0 File Offset: 0x00025FA0
	public static int XpForLevel(int level)
	{
		return (int)Mathf.Pow((float)level / Skills.x, Skills.y);
	}

	// Token: 0x060007DE RID: 2014 RVA: 0x00027DB8 File Offset: 0x00025FB8
	public static float LevelProgress(int xp)
	{
		int num = Skills.XpToLevel(xp);
		float num2 = (float)(xp - Skills.XpForLevel(num));
		int num3 = Skills.XpForLevel(num + 1) - Skills.XpForLevel(num);
		return num2 / (float)num3;
	}

	// Token: 0x060007DF RID: 2015 RVA: 0x00027DE8 File Offset: 0x00025FE8
	public static float NthRoot(float A, float N)
	{
		return Mathf.Pow(A, 1f / N);
	}

	// Token: 0x0400077F RID: 1919
	public static int woodcuttingXp;

	// Token: 0x04000780 RID: 1920
	public static int miningXp;

	// Token: 0x04000781 RID: 1921
	public static int buildingXp;

	// Token: 0x04000782 RID: 1922
	public static int craftingXp;

	// Token: 0x04000783 RID: 1923
	private static float x = 0.07f;

	// Token: 0x04000784 RID: 1924
	private static float y = 1.55f;
}
