using System;
using UnityEngine;

// Token: 0x020000F2 RID: 242
public class UpdatableData : ScriptableObject
{
	// Token: 0x14000001 RID: 1
	// (add) Token: 0x0600074F RID: 1871 RVA: 0x000255FC File Offset: 0x000237FC
	// (remove) Token: 0x06000750 RID: 1872 RVA: 0x00025634 File Offset: 0x00023834
	public event Action OnValuesUpdated;

	// Token: 0x040006DB RID: 1755
	public bool autoUpdate;
}
