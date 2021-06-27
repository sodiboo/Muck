using System;
using UnityEngine;

// Token: 0x020000F3 RID: 243
public class UpdateableData : ScriptableObject
{
	// Token: 0x14000002 RID: 2
	// (add) Token: 0x06000752 RID: 1874 RVA: 0x0002566C File Offset: 0x0002386C
	// (remove) Token: 0x06000753 RID: 1875 RVA: 0x000256A4 File Offset: 0x000238A4
	public event Action OnValuesUpdate;

	// Token: 0x040006DD RID: 1757
	public bool autoUpdate;
}
