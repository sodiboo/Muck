using System;
using UnityEngine;

// Token: 0x0200009D RID: 157
[CreateAssetMenu]
public class Powerup : ScriptableObject
{
	// Token: 0x06000396 RID: 918 RVA: 0x00014CFC File Offset: 0x00012EFC
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

	// Token: 0x06000397 RID: 919 RVA: 0x00014D3C File Offset: 0x00012F3C
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

	// Token: 0x040003A4 RID: 932
	public new string name;

	// Token: 0x040003A5 RID: 933
	public string description;

	// Token: 0x040003A6 RID: 934
	public int id;

	// Token: 0x040003A7 RID: 935
	public Powerup.PowerTier tier;

	// Token: 0x040003A8 RID: 936
	public Mesh mesh;

	// Token: 0x040003A9 RID: 937
	public Material material;

	// Token: 0x040003AA RID: 938
	public Sprite sprite;

	// Token: 0x0200009E RID: 158
	public enum PowerTier
	{
		// Token: 0x040003AC RID: 940
		White,
		// Token: 0x040003AD RID: 941
		Blue,
		// Token: 0x040003AE RID: 942
		Orange
	}
}
