using System;
using UnityEngine;

// Token: 0x020000E9 RID: 233
public class MobZone : SpawnZone
{
	// Token: 0x06000731 RID: 1841 RVA: 0x00024EB8 File Offset: 0x000230B8
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

	// Token: 0x06000732 RID: 1842 RVA: 0x00024F90 File Offset: 0x00023190
	public override GameObject LocalSpawnEntity(Vector3 pos, int mobType, int mobId, int zoneId)
	{
		Mob component = Instantiate<GameObject>(MobSpawner.Instance.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
		component.tag = "DontCount";
		MobManager.Instance.AddMob(component, mobId);
		this.entities.Add(component.gameObject);
		return component.gameObject;
	}

	// Token: 0x040006B3 RID: 1715
	public MobType mobType;
}
