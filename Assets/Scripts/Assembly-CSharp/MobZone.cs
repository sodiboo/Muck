using System;
using UnityEngine;

// Token: 0x020000FE RID: 254
public class MobZone : SpawnZone
{
	// Token: 0x060006AA RID: 1706 RVA: 0x000228F8 File Offset: 0x00020AF8
	public override void ServerSpawnEntity()
	{
		MonoBehaviour.print("spawning mob from id: " + this.id);
		MonoBehaviour.print("queue: " + this.entityQueue);
		Vector3 vector = base.FindRandomPos();
		if (vector == Vector3.zero)
		{
			return;
		}
		this.entityBuffer--;
		int nextId = MobManager.Instance.GetNextId();
		int id = this.mobType.id;
		GameObject gameObject = this.LocalSpawnEntity(vector, id, nextId, this.id);
		MobServerNeutral component = gameObject.GetComponent<MobServerNeutral>();
		if (component)
		{
			component.mobZoneId = this.id;
		}
		ServerSend.MobZoneSpawn(vector, id, nextId, this.id);
		if (this.mobType.behaviour != MobType.MobBehaviour.Neutral)
		{
			gameObject.AddComponent<DontAttackUntilPlayerSpotted>().mobZoneId = this.id;
		}
	}

	// Token: 0x060006AB RID: 1707 RVA: 0x000229D0 File Offset: 0x00020BD0
	public override GameObject LocalSpawnEntity(Vector3 pos, int mobType, int mobId, int zoneId)
	{
		Mob component =Instantiate<GameObject>(MobSpawner.Instance.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
		component.tag = "DontCount";
		MobManager.Instance.AddMob(component, mobId);
		this.entities.Add(component.gameObject);
		return component.gameObject;
	}

	// Token: 0x04000694 RID: 1684
	public MobType mobType;
}
