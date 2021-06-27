using System;
using UnityEngine;

// Token: 0x020000E7 RID: 231
public class PooledObject
{
	// Token: 0x040006A7 RID: 1703
	public int id;

	// Token: 0x040006A8 RID: 1704
	public int hp;

	// Token: 0x040006A9 RID: 1705
	public Vector3 position;

	// Token: 0x040006AA RID: 1706
	public Vector3 scale;

	// Token: 0x040006AB RID: 1707
	public Quaternion rotation;

	// Token: 0x040006AC RID: 1708
	public int prefabType;

	// Token: 0x040006AD RID: 1709
	public int idInPool;

	// Token: 0x040006AE RID: 1710
	public int poolId;

	// Token: 0x040006AF RID: 1711
	public bool activeInPool;
}
