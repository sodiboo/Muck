using System;
using UnityEngine;

// Token: 0x020000CA RID: 202
public class UpdatableData : ScriptableObject
{
	// Token: 0x14000001 RID: 1
	// (add) Token: 0x06000635 RID: 1589 RVA: 0x0001F51C File Offset: 0x0001D71C
	// (remove) Token: 0x06000636 RID: 1590 RVA: 0x0001F554 File Offset: 0x0001D754
	public event Action OnValuesUpdated;

	// Token: 0x040005B5 RID: 1461
	public bool autoUpdate;
}
