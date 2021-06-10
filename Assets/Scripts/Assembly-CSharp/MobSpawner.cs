
using UnityEngine;

// Token: 0x0200004C RID: 76
public class MobSpawner : MonoBehaviour
{
	// Token: 0x060001B0 RID: 432 RVA: 0x0000A6D6 File Offset: 0x000088D6
	private void Awake()
	{
		MobSpawner.Instance = this;
		this.FillList();
	}

	// Token: 0x060001B1 RID: 433 RVA: 0x0000A6E4 File Offset: 0x000088E4
	private void FillList()
	{
		this.allMobs = new MobType[this.mobsInspector.Length];
		for (int i = 0; i < this.mobsInspector.Length; i++)
		{
			this.allMobs[i] = this.mobsInspector[i];
			this.allMobs[i].id = i;
		}
	}

	// Token: 0x060001B2 RID: 434 RVA: 0x0000A735 File Offset: 0x00008935
	public void ServerSpawnNewMob(int mobId, int mobType, Vector3 pos, float multiplier, float bossMultiplier)
	{
		this.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier);
		ServerSend.MobSpawn(pos, mobType, mobId, multiplier, bossMultiplier);
	}

	// Token: 0x060001B3 RID: 435 RVA: 0x0000A750 File Offset: 0x00008950
	public void SpawnMob(Vector3 pos, int mobType, int mobId, float multiplier, float bossMultiplier)
	{
		Mob component =Instantiate(this.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
		MobManager.Instance.AddMob(component, mobId);
		component.multiplier = multiplier;
		component.bossMultiplier = bossMultiplier;
		MonoBehaviour.print("spawned new mob with id: " + mobId);
	}

	// Token: 0x040001B5 RID: 437
	public MobType[] mobsInspector;

	// Token: 0x040001B6 RID: 438
	public MobType[] allMobs;

	// Token: 0x040001B7 RID: 439
	public static MobSpawner Instance;
}
