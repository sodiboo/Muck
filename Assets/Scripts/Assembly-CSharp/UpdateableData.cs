using System;
using UnityEngine;

// Token: 0x0200010B RID: 267
public class UpdateableData : ScriptableObject
{
	// Token: 0x14000002 RID: 2
	// (add) Token: 0x060006D4 RID: 1748 RVA: 0x00022F28 File Offset: 0x00021128
	// (remove) Token: 0x060006D5 RID: 1749 RVA: 0x00022F60 File Offset: 0x00021160
	public event Action OnValuesUpdate;

	// Token: 0x040006D0 RID: 1744
	public bool autoUpdate;
}
