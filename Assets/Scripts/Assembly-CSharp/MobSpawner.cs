using System;
using UnityEngine;

// Token: 0x02000069 RID: 105
public class MobSpawner : MonoBehaviour
{
	// Token: 0x0600025C RID: 604 RVA: 0x0000DF3D File Offset: 0x0000C13D
	private void Awake()
	{
		MobSpawner.Instance = this;
		this.FillList();
	}

	// Token: 0x0600025D RID: 605 RVA: 0x0000DF4C File Offset: 0x0000C14C
	private void FillList()
	{
		this.allMobs = new MobType[this.mobsInspector.Length];
		for (int i = 0; i < this.mobsInspector.Length; i++)
		{
			this.allMobs[i] = this.mobsInspector[i];
			this.allMobs[i].id = i;
		}
	}

	// Token: 0x0600025E RID: 606 RVA: 0x0000DF9D File Offset: 0x0000C19D
	public void ServerSpawnNewMob(int mobId, int mobType, Vector3 pos, float multiplier, float bossMultiplier, Mob.BossType bossType = Mob.BossType.None, int guardianType = -1)
	{
		this.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, bossType, guardianType);
		ServerSend.MobSpawn(pos, mobType, mobId, multiplier, bossMultiplier, guardianType);
	}

	// Token: 0x0600025F RID: 607 RVA: 0x0000DFC0 File Offset: 0x0000C1C0
	public void SpawnMob(Vector3 pos, int mobType, int mobId, float multiplier, float bossMultiplier, Mob.BossType bossType = Mob.BossType.None, int guardianType = -1)
	{
		Mob component = Instantiate<GameObject>(this.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
		MobManager.Instance.AddMob(component, mobId);
		component.multiplier = multiplier;
		component.bossMultiplier = bossMultiplier;
		if (component.bossType != Mob.BossType.BossShrine || bossType != Mob.BossType.None)
		{
			component.bossType = bossType;
		}
		if (guardianType != -1)
		{
			component.GetComponent<Guardian>().type = (Guardian.GuardianType)guardianType;
		}
		MonoBehaviour.print("spawned new mob with id: " + mobId);
	}

	// Token: 0x0400027A RID: 634
	public MobType[] mobsInspector;

	// Token: 0x0400027B RID: 635
	public MobType[] allMobs;

	// Token: 0x0400027C RID: 636
	public static MobSpawner Instance;
}
