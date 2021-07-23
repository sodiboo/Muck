using UnityEngine;

public class Skills : MonoBehaviour
{
    public static int woodcuttingXp;

    public static int miningXp;

    public static int buildingXp;

    public static int craftingXp;

    private static float x = 0.07f;

    private static float y = 1.55f;

    public static int XpToLevel(int xp)
    {
        return Mathf.FloorToInt(NthRoot(xp, y) * x);
    }

    public static int XpForLevel(int level)
    {
        return (int)Mathf.Pow((float)level / x, y);
    }

    public static float LevelProgress(int xp)
    {
        int num = XpToLevel(xp);
        int num2 = xp - XpForLevel(num);
        int num3 = XpForLevel(num + 1) - XpForLevel(num);
        return (float)num2 / (float)num3;
    }

    public static float NthRoot(float A, float N)
    {
        return Mathf.Pow(A, 1f / N);
    }
}
