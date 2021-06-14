using System;
using UnityEngine;

// Token: 0x020000FC RID: 252
public class PooledObject
{
	// Token: 0x04000688 RID: 1672
	public int id;

	// Token: 0x04000689 RID: 1673
	public int hp;

	// Token: 0x0400068A RID: 1674
	public Vector3 position;

	// Token: 0x0400068B RID: 1675
	public Vector3 scale;

	// Token: 0x0400068C RID: 1676
	public Quaternion rotation;

	// Token: 0x0400068D RID: 1677
	public int prefabType;

	// Token: 0x0400068E RID: 1678
	public int idInPool;

	// Token: 0x0400068F RID: 1679
	public int poolId;

	// Token: 0x04000690 RID: 1680
	public bool activeInPool;
}
