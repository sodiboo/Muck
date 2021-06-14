using System;
using UnityEngine;

// Token: 0x020000F1 RID: 241
public class PlayerSave
{
	// Token: 0x1700004A RID: 74
	// (get) Token: 0x0600066A RID: 1642 RVA: 0x000061B3 File Offset: 0x000043B3
	// (set) Token: 0x0600066B RID: 1643 RVA: 0x000061BB File Offset: 0x000043BB
	public int volume { get; set; } = 4;

	// Token: 0x1700004B RID: 75
	// (get) Token: 0x0600066C RID: 1644 RVA: 0x000061C4 File Offset: 0x000043C4
	// (set) Token: 0x0600066D RID: 1645 RVA: 0x000061CC File Offset: 0x000043CC
	public int music { get; set; } = 2;

	// Token: 0x0400063A RID: 1594
	public bool cameraShake = true;

	// Token: 0x0400063B RID: 1595
	public int fov = 85;

	// Token: 0x0400063C RID: 1596
	public float sensMultiplier = 1f;

	// Token: 0x0400063D RID: 1597
	public bool invertedMouse;

	// Token: 0x0400063E RID: 1598
	public bool grass = true;

	// Token: 0x0400063F RID: 1599
	public bool tutorial = true;

	// Token: 0x04000640 RID: 1600
	public KeyCode forward = KeyCode.W;

	// Token: 0x04000641 RID: 1601
	public KeyCode backwards = KeyCode.S;

	// Token: 0x04000642 RID: 1602
	public KeyCode left = KeyCode.A;

	// Token: 0x04000643 RID: 1603
	public KeyCode right = KeyCode.D;

	// Token: 0x04000644 RID: 1604
	public KeyCode jump = KeyCode.Space;

	// Token: 0x04000645 RID: 1605
	public KeyCode sprint = KeyCode.LeftShift;

	// Token: 0x04000646 RID: 1606
	public KeyCode interact = KeyCode.E;

	// Token: 0x04000647 RID: 1607
	public KeyCode inventory = KeyCode.Tab;

	// Token: 0x04000648 RID: 1608
	public KeyCode map = KeyCode.M;

	// Token: 0x04000649 RID: 1609
	public KeyCode leftClick = KeyCode.Mouse0;

	// Token: 0x0400064A RID: 1610
	public KeyCode rightClick = KeyCode.Mouse1;

	// Token: 0x0400064B RID: 1611
	public int shadowQuality = 2;

	// Token: 0x0400064C RID: 1612
	public int shadowResolution = 2;

	// Token: 0x0400064D RID: 1613
	public int shadowDistance = 2;

	// Token: 0x0400064E RID: 1614
	public int shadowCascade = 1;

	// Token: 0x0400064F RID: 1615
	public int textureQuality = 2;

	// Token: 0x04000650 RID: 1616
	public int antiAliasing = 1;

	// Token: 0x04000651 RID: 1617
	public bool softParticles = true;

	// Token: 0x04000652 RID: 1618
	public int bloom = 2;

	// Token: 0x04000653 RID: 1619
	public bool motionBlur;

	// Token: 0x04000654 RID: 1620
	public bool ambientOcclusion = true;

	// Token: 0x04000655 RID: 1621
	public Vector2 resolution;

	// Token: 0x04000656 RID: 1622
	public int refreshRate = 144;

	// Token: 0x04000657 RID: 1623
	public bool fullscreen = true;

	// Token: 0x04000658 RID: 1624
	public int fullscreenMode;

	// Token: 0x04000659 RID: 1625
	public int vSync;

	// Token: 0x0400065A RID: 1626
	public int fpsLimit = 144;

	// Token: 0x0400065D RID: 1629
	public int xp;

	// Token: 0x0400065E RID: 1630
	public int money;

	// Token: 0x0400065F RID: 1631
	private bool[] bossesBeatEasy = new bool[20];

	// Token: 0x04000660 RID: 1632
	private bool[] bossesBeatNormal = new bool[20];

	// Token: 0x04000661 RID: 1633
	private bool[] bossesBeatHard = new bool[20];

	// Token: 0x020000F2 RID: 242
	public enum Bosses
	{
		// Token: 0x04000663 RID: 1635
		BigChonk,
		// Token: 0x04000664 RID: 1636
		Gronk
	}
}
