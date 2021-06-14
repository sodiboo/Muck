using System;
using UnityEngine;

// Token: 0x0200010A RID: 266
public class UpdatableData : ScriptableObject
{
	// Token: 0x14000001 RID: 1
	// (add) Token: 0x060006D1 RID: 1745 RVA: 0x00022EB8 File Offset: 0x000210B8
	// (remove) Token: 0x060006D2 RID: 1746 RVA: 0x00022EF0 File Offset: 0x000210F0
	public event Action OnValuesUpdated;

	// Token: 0x040006CE RID: 1742
	public bool autoUpdate;
}
