
using UnityEngine;

// Token: 0x020000B6 RID: 182
public class PlayerSave
{
	// Token: 0x17000041 RID: 65
	// (get) Token: 0x060005D7 RID: 1495 RVA: 0x0001E1CA File Offset: 0x0001C3CA
	// (set) Token: 0x060005D8 RID: 1496 RVA: 0x0001E1D2 File Offset: 0x0001C3D2
	public int volume { get; set; } = 4;

	// Token: 0x17000042 RID: 66
	// (get) Token: 0x060005D9 RID: 1497 RVA: 0x0001E1DB File Offset: 0x0001C3DB
	// (set) Token: 0x060005DA RID: 1498 RVA: 0x0001E1E3 File Offset: 0x0001C3E3
	public int music { get; set; } = 2;

	// Token: 0x0400053E RID: 1342
	public bool cameraShake = true;

	// Token: 0x0400053F RID: 1343
	public float sensMultiplier = 1f;

	// Token: 0x04000540 RID: 1344
	public bool invertedMouse;

	// Token: 0x04000541 RID: 1345
	public bool grass = true;

	// Token: 0x04000542 RID: 1346
	public bool tutorial = true;

	// Token: 0x04000543 RID: 1347
	public KeyCode forward = KeyCode.W;

	// Token: 0x04000544 RID: 1348
	public KeyCode backwards = KeyCode.S;

	// Token: 0x04000545 RID: 1349
	public KeyCode left = KeyCode.A;

	// Token: 0x04000546 RID: 1350
	public KeyCode right = KeyCode.D;

	// Token: 0x04000547 RID: 1351
	public KeyCode jump = KeyCode.Space;

	// Token: 0x04000548 RID: 1352
	public KeyCode sprint = KeyCode.LeftShift;

	// Token: 0x04000549 RID: 1353
	public KeyCode interact = KeyCode.E;

	// Token: 0x0400054A RID: 1354
	public KeyCode inventory = KeyCode.Tab;

	// Token: 0x0400054B RID: 1355
	public KeyCode map = KeyCode.M;

	// Token: 0x0400054C RID: 1356
	public KeyCode leftClick = KeyCode.Mouse0;

	// Token: 0x0400054D RID: 1357
	public KeyCode rightClick = KeyCode.Mouse1;

	// Token: 0x0400054E RID: 1358
	public int shadowQuality = 2;

	// Token: 0x0400054F RID: 1359
	public int shadowResolution = 2;

	// Token: 0x04000550 RID: 1360
	public int shadowDistance = 2;

	// Token: 0x04000551 RID: 1361
	public int shadowCascade = 1;

	// Token: 0x04000552 RID: 1362
	public int textureQuality = 2;

	// Token: 0x04000553 RID: 1363
	public int antiAliasing = 1;

	// Token: 0x04000554 RID: 1364
	public bool softParticles = true;

	// Token: 0x04000555 RID: 1365
	public int bloom = 2;

	// Token: 0x04000556 RID: 1366
	public bool motionBlur;

	// Token: 0x04000557 RID: 1367
	public bool ambientOcclusion = true;

	// Token: 0x04000558 RID: 1368
	public Vector2 resolution;

	// Token: 0x04000559 RID: 1369
	public int refreshRate = 144;

	// Token: 0x0400055A RID: 1370
	public bool fullscreen = true;

	// Token: 0x0400055B RID: 1371
	public int vSync;

	// Token: 0x0400055C RID: 1372
	public int fpsLimit = 144;

	// Token: 0x0400055F RID: 1375
	public int xp;

	// Token: 0x04000560 RID: 1376
	public int money;
}
