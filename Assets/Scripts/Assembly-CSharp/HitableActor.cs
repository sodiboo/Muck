using System;
using UnityEngine;

public class HitableActor : Hitable
{
	public override void Hit(int damage, float sharpness, int hitEffect, Vector3 pos)
	{
		if (GameManager.gameSettings.friendlyFire == GameSettings.FriendlyFire.Off)
		{
			return;
		}
		if (this.actorType == HitableActor.ActorType.Player)
		{
			ClientSend.PlayerHit(damage, this.id, sharpness, hitEffect, pos);
		}
	}

	private void Update()
	{
	}

	public new virtual int Damage(int damage, int fromClient, int hitEffect, Vector3 pos)
	{
		Vector3 dir = GameManager.players[fromClient].transform.position - pos;
		this.SpawnParticles(pos, dir, hitEffect);
		Instantiate<GameObject>(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir((float)damage, dir, (HitEffect)hitEffect);
		return this.hp;
	}

	public override void OnKill(Vector3 dir)
	{
	}

	protected override void ExecuteHit()
	{
	}

	public HitableActor.ActorType actorType;

	public enum ActorType
	{
		Player,
		Enemy
	}
}
