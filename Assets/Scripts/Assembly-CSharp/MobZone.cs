using System;
using UnityEngine;

public class MobZone : SpawnZone
{
	public override void ServerSpawnEntity()
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) return;
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

	public override GameObject LocalSpawnEntity(Vector3 pos, int mobType, int mobId, int zoneId)
	{
		Mob component = Instantiate<GameObject>(MobSpawner.Instance.allMobs[mobType].mobPrefab, pos, Quaternion.identity).GetComponent<Mob>();
		component.tag = "DontCount";
		MobManager.Instance.AddMob(component, mobId);
		this.entities.Add(component.gameObject);
		return component.gameObject;
	}

	public MobType mobType;
}
