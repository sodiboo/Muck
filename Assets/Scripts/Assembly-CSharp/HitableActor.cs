using System;
using UnityEngine;

// Token: 0x02000084 RID: 132
public class HitableActor : Hitable
{
	// Token: 0x060002EC RID: 748 RVA: 0x000041BB File Offset: 0x000023BB
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

	// Token: 0x060002ED RID: 749 RVA: 0x00002147 File Offset: 0x00000347
	private void Update()
	{
	}

	// Token: 0x060002EE RID: 750 RVA: 0x00012F44 File Offset: 0x00011144
	public new virtual int Damage(int damage, int fromClient, int hitEffect, Vector3 pos)
	{
		Vector3 dir = GameManager.players[fromClient].transform.position - pos;
		this.SpawnParticles(pos, dir, hitEffect);
	Instantiate<GameObject>(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir((float)damage, dir, (HitEffect)hitEffect);
		return this.hp;
	}

	// Token: 0x060002EF RID: 751 RVA: 0x00002147 File Offset: 0x00000347
	public override void OnKill(Vector3 dir)
	{
	}

	// Token: 0x060002F0 RID: 752 RVA: 0x00002147 File Offset: 0x00000347
	protected override void ExecuteHit()
	{
	}

	// Token: 0x040002F3 RID: 755
	public HitableActor.ActorType actorType;

	// Token: 0x02000085 RID: 133
	public enum ActorType
	{
		// Token: 0x040002F5 RID: 757
		Player,
		// Token: 0x040002F6 RID: 758
		Enemy
	}
}
