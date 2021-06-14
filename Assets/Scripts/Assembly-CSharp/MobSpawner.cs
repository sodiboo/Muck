using System;
using UnityEngine;

// Token: 0x0200005A RID: 90
public class MobSpawner : MonoBehaviour
{
	// Token: 0x060001D9 RID: 473 RVA: 0x0000361B File Offset: 0x0000181B
	private void Awake()
	{
		MobSpawner.Instance = this;
		this.FillList();
	}

	// Token: 0x060001DA RID: 474 RVA: 0x0000F000 File Offset: 0x0000D200
	private void FillList()
	{
		this.allMobs = new MobType[this.mobsInspector.Length];
		for (int i = 0; i < this.mobsInspector.Length; i++)
		{
			this.allMobs[i] = this.mobsInspector[i];
			this.allMobs[i].id = i;
		}
	}

	// Token: 0x060001DB RID: 475 RVA: 0x00003629 File Offset: 0x00001829
	public void ServerSpawnNewMob(int mobId, int mobType, Vector3 pos, float multiplier, float bossMultiplier, Mob.BossType bossType = Mob.BossType.None)
	{
		this.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, bossType);
		ServerSend.MobSpawn(pos, mobType, mobId, multiplier, bossMultiplier);
	}

	// Token: 0x060001DC RID: 476 RVA: 0x0000F054 File Offset: 0x0000D254
	public void SpawnMob(Vector3 pos, int mobType, int mobId, float multiplier, float bossMultiplier, Mob.BossType bossType = Mob.BossType.None)
	{
		Mob component =Instantiate<GameObject>(this.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
		MobManager.Instance.AddMob(component, mobId);
		component.multiplier = multiplier;
		component.bossMultiplier = bossMultiplier;
		if (component.bossType != Mob.BossType.BossShrine || bossType != Mob.BossType.None)
		{
			component.bossType = bossType;
		}
		MonoBehaviour.print("spawned new mob with id: " + mobId);
	}

	// Token: 0x040001F1 RID: 497
	public MobType[] mobsInspector;

	// Token: 0x040001F2 RID: 498
	public MobType[] allMobs;

	// Token: 0x040001F3 RID: 499
	public static MobSpawner Instance;
}
