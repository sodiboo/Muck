using System;
using UnityEngine;

// Token: 0x020000B5 RID: 181
[CreateAssetMenu]
public class MobType : ScriptableObject
{
	// Token: 0x17000037 RID: 55
	// (get) Token: 0x060004D3 RID: 1235 RVA: 0x00018D9D File Offset: 0x00016F9D
	// (set) Token: 0x060004D4 RID: 1236 RVA: 0x00018DA5 File Offset: 0x00016FA5
	public int id { get; set; }

	// Token: 0x04000471 RID: 1137
	public new string name;

	// Token: 0x04000472 RID: 1138
	public GameObject mobPrefab;

	// Token: 0x04000473 RID: 1139
	public MobType.MobBehaviour behaviour;

	// Token: 0x04000474 RID: 1140
	public bool ranged;

	// Token: 0x04000475 RID: 1141
	public float rangedCooldown = 6f;

	// Token: 0x04000476 RID: 1142
	public float startAttackDistance = 1f;

	// Token: 0x04000477 RID: 1143
	public float startRangedAttackDistance = 5f;

	// Token: 0x04000478 RID: 1144
	public float maxAttackDistance = 1f;

	// Token: 0x04000479 RID: 1145
	public float speed;

	// Token: 0x0400047A RID: 1146
	public float spawnTime = 1f;

	// Token: 0x0400047B RID: 1147
	public float minAttackAngle = 20f;

	// Token: 0x0400047C RID: 1148
	public float sharpDefense;

	// Token: 0x0400047D RID: 1149
	public float defense;

	// Token: 0x0400047E RID: 1150
	public float knockbackThreshold = 0.2f;

	// Token: 0x0400047F RID: 1151
	public bool ignoreBuilds;

	// Token: 0x04000480 RID: 1152
	public float followPlayerDistance = 1f;

	// Token: 0x04000481 RID: 1153
	public float followPlayerAccuracy = 0.15f;

	// Token: 0x04000482 RID: 1154
	public bool onlyRangedInRangedPattern;

	// Token: 0x04000483 RID: 1155
	public MobType.Weakness[] weaknesses;

	// Token: 0x04000484 RID: 1156
	public bool boss;

	// Token: 0x0200015B RID: 347
	public enum MobBehaviour
	{
		// Token: 0x040008FD RID: 2301
		Neutral,
		// Token: 0x040008FE RID: 2302
		Enemy,
		// Token: 0x040008FF RID: 2303
		EnemyMeleeAndRanged,
		// Token: 0x04000900 RID: 2304
		Dragon
	}

	// Token: 0x0200015C RID: 348
	[Serializable]
	public enum Weakness
	{
		// Token: 0x04000902 RID: 2306
		Sharp,
		// Token: 0x04000903 RID: 2307
		Blunt,
		// Token: 0x04000904 RID: 2308
		Water,
		// Token: 0x04000905 RID: 2309
		Fire,
		// Token: 0x04000906 RID: 2310
		Lightning
	}
}
