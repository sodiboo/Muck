using System;
using UnityEngine;

// Token: 0x02000022 RID: 34
[CreateAssetMenu]
public class BowComponent : ScriptableObject
{
	// Token: 0x040000CE RID: 206
	public float projectileSpeed;

	// Token: 0x040000CF RID: 207
	public int nArrows;

	// Token: 0x040000D0 RID: 208
	public int angleDelta;

	// Token: 0x040000D1 RID: 209
	public float timeToImpact = 1.2f;

	// Token: 0x040000D2 RID: 210
	public float attackSize = 10f;
}
