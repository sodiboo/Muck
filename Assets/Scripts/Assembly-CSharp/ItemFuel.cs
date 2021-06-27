using System;
using UnityEngine;

// Token: 0x020000A4 RID: 164
[CreateAssetMenu]
public class ItemFuel : ScriptableObject
{
	// Token: 0x04000412 RID: 1042
	public int maxUses = 1;

	// Token: 0x04000413 RID: 1043
	public int currentUses;

	// Token: 0x04000414 RID: 1044
	public float speedMultiplier = 1f;
}
