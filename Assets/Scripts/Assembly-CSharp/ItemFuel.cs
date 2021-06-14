using System;
using UnityEngine;

// Token: 0x0200009C RID: 156
[CreateAssetMenu]
public class ItemFuel : ScriptableObject
{
	// Token: 0x040003A1 RID: 929
	public int maxUses = 1;

	// Token: 0x040003A2 RID: 930
	public int currentUses;

	// Token: 0x040003A3 RID: 931
	public float speedMultiplier = 1f;
}
