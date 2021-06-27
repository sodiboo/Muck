using System;
using UnityEngine;

// Token: 0x020000D5 RID: 213
internal static class HitEffectExtension
{
	// Token: 0x0600067E RID: 1662 RVA: 0x000216BC File Offset: 0x0001F8BC
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

	// Token: 0x0600067F RID: 1663 RVA: 0x00021708 File Offset: 0x0001F908
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
