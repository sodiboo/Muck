
using UnityEngine;

// Token: 0x0200007F RID: 127
[CreateAssetMenu]
public class Powerup : ScriptableObject
{
	// Token: 0x0600034C RID: 844 RVA: 0x000111BC File Offset: 0x0000F3BC
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

	// Token: 0x0600034D RID: 845 RVA: 0x000111FC File Offset: 0x0000F3FC
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

	// Token: 0x04000319 RID: 793
	public new string name;

	// Token: 0x0400031A RID: 794
	public string description;

	// Token: 0x0400031B RID: 795
	public int id;

	// Token: 0x0400031C RID: 796
	public Powerup.PowerTier tier;

	// Token: 0x0400031D RID: 797
	public Mesh mesh;

	// Token: 0x0400031E RID: 798
	public Material material;

	// Token: 0x0400031F RID: 799
	public Sprite sprite;

	// Token: 0x0200011C RID: 284
	public enum PowerTier
	{
		// Token: 0x0400077D RID: 1917
		White,
		// Token: 0x0400077E RID: 1918
		Blue,
		// Token: 0x0400077F RID: 1919
		Orange
	}
}
