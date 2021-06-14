using System;
using UnityEngine;

// Token: 0x020000B2 RID: 178
[CreateAssetMenu]
public class MobType : ScriptableObject
{
	// Token: 0x17000031 RID: 49
	// (get) Token: 0x06000434 RID: 1076 RVA: 0x00004F5D File Offset: 0x0000315D
	// (set) Token: 0x06000435 RID: 1077 RVA: 0x00004F65 File Offset: 0x00003165
	public int id { get; set; }

	// Token: 0x04000415 RID: 1045
	public new string name;

	// Token: 0x04000416 RID: 1046
	public GameObject mobPrefab;

	// Token: 0x04000417 RID: 1047
	public MobType.MobBehaviour behaviour;

	// Token: 0x04000418 RID: 1048
	public bool ranged;

	// Token: 0x04000419 RID: 1049
	public float rangedCooldown = 6f;

	// Token: 0x0400041A RID: 1050
	public float startAttackDistance = 1f;

	// Token: 0x0400041B RID: 1051
	public float startRangedAttackDistance = 5f;

	// Token: 0x0400041C RID: 1052
	public float maxAttackDistance = 1f;

	// Token: 0x0400041D RID: 1053
	public float speed;

	// Token: 0x0400041E RID: 1054
	public float spawnTime = 1f;

	// Token: 0x0400041F RID: 1055
	public float minAttackAngle = 20f;

	// Token: 0x04000420 RID: 1056
	public float sharpDefense;

	// Token: 0x04000421 RID: 1057
	public float defense;

	// Token: 0x04000422 RID: 1058
	public float knockbackThreshold = 0.2f;

	// Token: 0x04000423 RID: 1059
	public bool ignoreBuilds;

	// Token: 0x04000424 RID: 1060
	public float followPlayerDistance = 1f;

	// Token: 0x04000425 RID: 1061
	public float followPlayerAccuracy = 0.15f;

	// Token: 0x04000426 RID: 1062
	public bool onlyRangedInRangedPattern;

	// Token: 0x04000427 RID: 1063
	public MobType.Weakness[] weaknesses;

	// Token: 0x04000428 RID: 1064
	public bool boss;

	// Token: 0x020000B3 RID: 179
	public enum MobBehaviour
	{
		// Token: 0x0400042A RID: 1066
		Neutral,
		// Token: 0x0400042B RID: 1067
		Enemy,
		// Token: 0x0400042C RID: 1068
		EnemyMeleeAndRanged
	}

	// Token: 0x020000B4 RID: 180
	[Serializable]
	public enum Weakness
	{
		// Token: 0x0400042E RID: 1070
		Sharp,
		// Token: 0x0400042F RID: 1071
		Blunt,
		// Token: 0x04000430 RID: 1072
		Water,
		// Token: 0x04000431 RID: 1073
		Fire,
		// Token: 0x04000432 RID: 1074
		Lightning
	}
}
