
using UnityEngine;

// Token: 0x020000DF RID: 223
public class Skills : MonoBehaviour
{
	// Token: 0x060006A1 RID: 1697 RVA: 0x00021745 File Offset: 0x0001F945
	public static int XpToLevel(int xp)
	{
		return Mathf.FloorToInt(Skills.NthRoot((float)xp, Skills.y) * Skills.x);
	}

	// Token: 0x060006A2 RID: 1698 RVA: 0x0002175E File Offset: 0x0001F95E
	public static int XpForLevel(int level)
	{
		return (int)Mathf.Pow((float)level / Skills.x, Skills.y);
	}

	// Token: 0x060006A3 RID: 1699 RVA: 0x00021774 File Offset: 0x0001F974
	public static float LevelProgress(int xp)
	{
		int num = Skills.XpToLevel(xp);
		float num2 = (float)(xp - Skills.XpForLevel(num));
		int num3 = Skills.XpForLevel(num + 1) - Skills.XpForLevel(num);
		return num2 / (float)num3;
	}

	// Token: 0x060006A4 RID: 1700 RVA: 0x000217A4 File Offset: 0x0001F9A4
	public static float NthRoot(float A, float N)
	{
		return Mathf.Pow(A, 1f / N);
	}

	// Token: 0x04000644 RID: 1604
	public static int woodcuttingXp;

	// Token: 0x04000645 RID: 1605
	public static int miningXp;

	// Token: 0x04000646 RID: 1606
	public static int buildingXp;

	// Token: 0x04000647 RID: 1607
	public static int craftingXp;

	// Token: 0x04000648 RID: 1608
	private static float x = 0.07f;

	// Token: 0x04000649 RID: 1609
	private static float y = 1.55f;
}
