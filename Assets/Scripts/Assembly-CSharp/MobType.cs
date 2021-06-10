
using UnityEngine;

// Token: 0x0200008E RID: 142
[CreateAssetMenu]
public class MobType : ScriptableObject
{
	// Token: 0x1700002B RID: 43
	// (get) Token: 0x060003DD RID: 989 RVA: 0x000139F7 File Offset: 0x00011BF7
	// (set) Token: 0x060003DE RID: 990 RVA: 0x000139FF File Offset: 0x00011BFF
	public int id { get; set; }

	// Token: 0x04000367 RID: 871
	public new string name;

	// Token: 0x04000368 RID: 872
	public GameObject mobPrefab;

	// Token: 0x04000369 RID: 873
	public MobType.MobBehaviour behaviour;

	// Token: 0x0400036A RID: 874
	public bool ranged;

	// Token: 0x0400036B RID: 875
	public float rangedCooldown = 6f;

	// Token: 0x0400036C RID: 876
	public float startAttackDistance = 1f;

	// Token: 0x0400036D RID: 877
	public float maxAttackDistance = 1f;

	// Token: 0x0400036E RID: 878
	public float speed;

	// Token: 0x0400036F RID: 879
	public float spawnTime = 1f;

	// Token: 0x04000370 RID: 880
	public float minAttackAngle = 20f;

	// Token: 0x04000371 RID: 881
	public float sharpDefense;

	// Token: 0x04000372 RID: 882
	public float defense;

	// Token: 0x04000373 RID: 883
	public float knockbackThreshold = 0.2f;

	// Token: 0x04000374 RID: 884
	public bool ignoreBuilds;

	// Token: 0x04000375 RID: 885
	public float followPlayerDistance = 1f;

	// Token: 0x04000376 RID: 886
	public float followPlayerAccuracy = 0.15f;

	// Token: 0x04000377 RID: 887
	public bool onlyRangedInRangedPattern;

	// Token: 0x0200011F RID: 287
	public enum MobBehaviour
	{
		// Token: 0x0400078B RID: 1931
		Neutral,
		// Token: 0x0400078C RID: 1932
		Enemy,
		// Token: 0x0400078D RID: 1933
		EnemyMeleeAndRanged
	}
}
