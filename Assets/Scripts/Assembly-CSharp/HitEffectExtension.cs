
using UnityEngine;

// Token: 0x020000AD RID: 173
internal static class HitEffectExtension
{
	// Token: 0x06000574 RID: 1396 RVA: 0x0001BB2C File Offset: 0x00019D2C
	public static Color GetColor(HitEffect effect)
	{
		switch (effect)
		{
		case HitEffect.Normal:
			return Color.white;
		case HitEffect.Crit:
			return Color.yellow;
		case HitEffect.Big:
			return Color.red;
		case HitEffect.Electro:
			return Color.yellow;
		case HitEffect.Falling:
			return Color.cyan;
		default:
			return Color.white;
		}
	}

	// Token: 0x06000575 RID: 1397 RVA: 0x0001BB78 File Offset: 0x00019D78
	public static string GetColorName(HitEffect effect)
	{
		switch (effect)
		{
		case HitEffect.Normal:
			return "white";
		case HitEffect.Crit:
			return "yellow";
		case HitEffect.Big:
			return "red";
		case HitEffect.Electro:
			return "#" + ColorUtility.ToHtmlStringRGB(Color.yellow);
		case HitEffect.Falling:
			return "#" + ColorUtility.ToHtmlStringRGB(Color.cyan);
		default:
			return "white";
		}
	}
}
