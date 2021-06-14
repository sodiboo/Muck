using System;
using UnityEngine;

// Token: 0x020000E7 RID: 231
internal static class HitEffectExtension
{
	// Token: 0x06000606 RID: 1542 RVA: 0x0001FB94 File Offset: 0x0001DD94
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

	// Token: 0x06000607 RID: 1543 RVA: 0x0001FBE0 File Offset: 0x0001DDE0
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
