using System;
using UnityEngine;

public class MobSpawner : MonoBehaviour
{
	private void Awake()
	{
		MobSpawner.Instance = this;
		this.FillList();
	}

	private void FillList()
	{
		this.allMobs = new MobType[this.mobsInspector.Length];
		for (int i = 0; i < this.mobsInspector.Length; i++)
		{
			this.allMobs[i] = this.mobsInspector[i];
			this.allMobs[i].id = i;
		}
	}

	public void ServerSpawnNewMob(int mobId, int mobType, Vector3 pos, float multiplier, float bossMultiplier, Mob.BossType bossType = Mob.BossType.None, int guardianType = -1)
	{
		this.SpawnMob(pos, mobType, mobId, multiplier, bossMultiplier, bossType, guardianType);
		ServerSend.MobSpawn(pos, mobType, mobId, multiplier, bossMultiplier, guardianType);
	}

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

	public MobType[] mobsInspector;

	public MobType[] allMobs;

	public static MobSpawner Instance;
}
