using System;
using UnityEngine;

// Token: 0x020000CB RID: 203
public class UpdateableData : ScriptableObject
{
	// Token: 0x14000002 RID: 2
	// (add) Token: 0x06000638 RID: 1592 RVA: 0x0001F58C File Offset: 0x0001D78C
	// (remove) Token: 0x06000639 RID: 1593 RVA: 0x0001F5C4 File Offset: 0x0001D7C4
	public event Action OnValuesUpdate;

	// Token: 0x040005B7 RID: 1463
	public bool autoUpdate;
}
