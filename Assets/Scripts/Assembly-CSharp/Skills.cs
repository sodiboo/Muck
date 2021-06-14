using System;
using UnityEngine;

// Token: 0x0200012B RID: 299
public class Skills : MonoBehaviour
{
	// Token: 0x0600074E RID: 1870 RVA: 0x00006CE6 File Offset: 0x00004EE6
	public static int XpToLevel(int xp)
	{
		return Mathf.FloorToInt(Skills.NthRoot((float)xp, Skills.y) * Skills.x);
	}

	// Token: 0x0600074F RID: 1871 RVA: 0x00006CFF File Offset: 0x00004EFF
	public static int XpForLevel(int level)
	{
		return (int)Mathf.Pow((float)level / Skills.x, Skills.y);
	}

	// Token: 0x06000750 RID: 1872 RVA: 0x00024B30 File Offset: 0x00022D30
	public static float LevelProgress(int xp)
	{
		int num = Skills.XpToLevel(xp);
		float num2 = (float)(xp - Skills.XpForLevel(num));
		int num3 = Skills.XpForLevel(num + 1) - Skills.XpForLevel(num);
		return num2 / (float)num3;
	}

	// Token: 0x06000751 RID: 1873 RVA: 0x00006D14 File Offset: 0x00004F14
	public static float NthRoot(float A, float N)
	{
		return Mathf.Pow(A, 1f / N);
	}

	// Token: 0x0400078F RID: 1935
	public static int woodcuttingXp;

	// Token: 0x04000790 RID: 1936
	public static int miningXp;

	// Token: 0x04000791 RID: 1937
	public static int buildingXp;

	// Token: 0x04000792 RID: 1938
	public static int craftingXp;

	// Token: 0x04000793 RID: 1939
	private static float x = 0.07f;

	// Token: 0x04000794 RID: 1940
	private static float y = 1.55f;
}
