using System;
using UnityEngine;

// Token: 0x020000A5 RID: 165
[CreateAssetMenu]
public class Powerup : ScriptableObject
{
	// Token: 0x06000437 RID: 1079 RVA: 0x00015D1C File Offset: 0x00013F1C
	public Color GetOutlineColor()
	{
		switch (this.tier)
		{
		case Powerup.PowerTier.White:
			return Color.white;
		case Powerup.PowerTier.Blue:
			return Color.cyan;
		case Powerup.PowerTier.Orange:
			return Color.yellow;
		default:
			return Color.white;
		}
	}

	// Token: 0x06000438 RID: 1080 RVA: 0x00015D5C File Offset: 0x00013F5C
	public string GetColorName()
	{
		switch (this.tier)
		{
		case Powerup.PowerTier.White:
			return "white";
		case Powerup.PowerTier.Blue:
			return "#00C0FF";
		case Powerup.PowerTier.Orange:
			return "orange";
		default:
			return "white";
		}
	}

	// Token: 0x04000415 RID: 1045
	public new string name;

	// Token: 0x04000416 RID: 1046
	public string description;

	// Token: 0x04000417 RID: 1047
	public int id;

	// Token: 0x04000418 RID: 1048
	public Powerup.PowerTier tier;

	// Token: 0x04000419 RID: 1049
	public Mesh mesh;

	// Token: 0x0400041A RID: 1050
	public Material material;

	// Token: 0x0400041B RID: 1051
	public Sprite sprite;

	// Token: 0x02000156 RID: 342
	public enum PowerTier
	{
		// Token: 0x040008E8 RID: 2280
		White,
		// Token: 0x040008E9 RID: 2281
		Blue,
		// Token: 0x040008EA RID: 2282
		Orange
	}
}
