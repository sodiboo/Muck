
using UnityEngine;

// Token: 0x020000C1 RID: 193
public class MobZone : SpawnZone
{
	// Token: 0x06000617 RID: 1559 RVA: 0x0001EE14 File Offset: 0x0001D014
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
		this.LocalSpawnEntity(vector, id, nextId, this.id).GetComponent<MobServerNeutral>().mobZoneId = this.id;
		ServerSend.MobZoneSpawn(vector, id, nextId, this.id);
	}

	// Token: 0x06000618 RID: 1560 RVA: 0x0001EEBC File Offset: 0x0001D0BC
	public override GameObject LocalSpawnEntity(Vector3 pos, int mobType, int mobId, int zoneId)
	{
		Mob component =Instantiate(MobSpawner.Instance.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
		MobManager.Instance.AddMob(component, mobId);
		this.entities.Add(component.gameObject);
		return component.gameObject;
	}

	// Token: 0x0400058D RID: 1421
	public MobType mobType;
}
