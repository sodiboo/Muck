using System;
using UnityEngine;

// Token: 0x02000093 RID: 147
public class HitableActor : Hitable
{
	// Token: 0x0600038B RID: 907 RVA: 0x0001357A File Offset: 0x0001177A
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

	// Token: 0x0600038C RID: 908 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Update()
	{
	}

	// Token: 0x0600038D RID: 909 RVA: 0x000135A4 File Offset: 0x000117A4
	public new virtual int Damage(int damage, int fromClient, int hitEffect, Vector3 pos)
	{
		Vector3 dir = GameManager.players[fromClient].transform.position - pos;
		this.SpawnParticles(pos, dir, hitEffect);
		Instantiate<GameObject>(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir((float)damage, dir, (HitEffect)hitEffect);
		return this.hp;
	}

	// Token: 0x0600038E RID: 910 RVA: 0x000030D7 File Offset: 0x000012D7
	public override void OnKill(Vector3 dir)
	{
	}

	// Token: 0x0600038F RID: 911 RVA: 0x000030D7 File Offset: 0x000012D7
	protected override void ExecuteHit()
	{
	}

	// Token: 0x04000389 RID: 905
	public HitableActor.ActorType actorType;

	// Token: 0x0200014F RID: 335
	public enum ActorType
	{
		// Token: 0x040008C0 RID: 2240
		Player,
		// Token: 0x040008C1 RID: 2241
		Enemy
	}
}
