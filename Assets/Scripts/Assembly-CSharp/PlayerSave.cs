using System;
using UnityEngine;

// Token: 0x020000DE RID: 222
public class PlayerSave
{
	// Token: 0x17000051 RID: 81
	// (get) Token: 0x060006EC RID: 1772 RVA: 0x00024012 File Offset: 0x00022212
	// (set) Token: 0x060006ED RID: 1773 RVA: 0x0002401A File Offset: 0x0002221A
	public int volume { get; set; } = 4;

	// Token: 0x17000052 RID: 82
	// (get) Token: 0x060006EE RID: 1774 RVA: 0x00024023 File Offset: 0x00022223
	// (set) Token: 0x060006EF RID: 1775 RVA: 0x0002402B File Offset: 0x0002222B
	public int music { get; set; } = 2;

	// Token: 0x04000659 RID: 1625
	public bool cameraShake = true;

	// Token: 0x0400065A RID: 1626
	public int fov = 85;

	// Token: 0x0400065B RID: 1627
	public float sensMultiplier = 1f;

	// Token: 0x0400065C RID: 1628
	public bool invertedMouseHor;

	// Token: 0x0400065D RID: 1629
	public bool invertedMouseVert;

	// Token: 0x0400065E RID: 1630
	public bool grass = true;

	// Token: 0x0400065F RID: 1631
	public bool tutorial = true;

	// Token: 0x04000660 RID: 1632
	public KeyCode forward = KeyCode.W;

	// Token: 0x04000661 RID: 1633
	public KeyCode backwards = KeyCode.S;

	// Token: 0x04000662 RID: 1634
	public KeyCode left = KeyCode.A;

	// Token: 0x04000663 RID: 1635
	public KeyCode right = KeyCode.D;

	// Token: 0x04000664 RID: 1636
	public KeyCode jump = KeyCode.Space;

	// Token: 0x04000665 RID: 1637
	public KeyCode sprint = KeyCode.LeftShift;

	// Token: 0x04000666 RID: 1638
	public KeyCode interact = KeyCode.E;

	// Token: 0x04000667 RID: 1639
	public KeyCode inventory = KeyCode.Tab;

	// Token: 0x04000668 RID: 1640
	public KeyCode map = KeyCode.M;

	// Token: 0x04000669 RID: 1641
	public KeyCode leftClick = KeyCode.Mouse0;

	// Token: 0x0400066A RID: 1642
	public KeyCode rightClick = KeyCode.Mouse1;

	// Token: 0x0400066B RID: 1643
	public int shadowQuality = 2;

	// Token: 0x0400066C RID: 1644
	public int shadowResolution = 2;

	// Token: 0x0400066D RID: 1645
	public int shadowDistance = 2;

	// Token: 0x0400066E RID: 1646
	public int shadowCascade = 1;

	// Token: 0x0400066F RID: 1647
	public int textureQuality = 2;

	// Token: 0x04000670 RID: 1648
	public int antiAliasing = 1;

	// Token: 0x04000671 RID: 1649
	public bool softParticles = true;

	// Token: 0x04000672 RID: 1650
	public int bloom = 2;

	// Token: 0x04000673 RID: 1651
	public bool motionBlur;

	// Token: 0x04000674 RID: 1652
	public bool ambientOcclusion = true;

	// Token: 0x04000675 RID: 1653
	public Vector2 resolution;

	// Token: 0x04000676 RID: 1654
	public int refreshRate = 144;

	// Token: 0x04000677 RID: 1655
	public bool fullscreen = true;

	// Token: 0x04000678 RID: 1656
	public int fullscreenMode;

	// Token: 0x04000679 RID: 1657
	public int vSync;

	// Token: 0x0400067A RID: 1658
	public int fpsLimit = 144;

	// Token: 0x0400067D RID: 1661
	public int xp;

	// Token: 0x0400067E RID: 1662
	public int money;

	// Token: 0x0400067F RID: 1663
	private bool[] bossesBeatEasy = new bool[20];

	// Token: 0x04000680 RID: 1664
	private bool[] bossesBeatNormal = new bool[20];

	// Token: 0x04000681 RID: 1665
	private bool[] bossesBeatHard = new bool[20];

	// Token: 0x0200016D RID: 365
	public enum Bosses
	{
		// Token: 0x04000939 RID: 2361
		BigChonk,
		// Token: 0x0400093A RID: 2362
		Gronk
	}
}
