
using UnityEngine;

// Token: 0x0200006D RID: 109
public class HitableActor : Hitable
{
	// Token: 0x060002B2 RID: 690 RVA: 0x0000EDBE File Offset: 0x0000CFBE
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

	// Token: 0x060002B3 RID: 691 RVA: 0x0000276E File Offset: 0x0000096E
	private void Update()
	{
	}

	// Token: 0x060002B4 RID: 692 RVA: 0x0000EDE8 File Offset: 0x0000CFE8
	public new virtual int Damage(int damage, int fromClient, int hitEffect, Vector3 pos)
	{
		Vector3 dir = GameManager.players[fromClient].transform.position - pos;
		this.SpawnParticles(pos, dir, hitEffect);
	Instantiate(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir((float)damage, dir, (HitEffect)hitEffect);
		return this.hp;
	}

	// Token: 0x060002B5 RID: 693 RVA: 0x0000276E File Offset: 0x0000096E
	public override void OnKill(Vector3 dir)
	{
	}

	// Token: 0x060002B6 RID: 694 RVA: 0x0000276E File Offset: 0x0000096E
	protected override void ExecuteHit()
	{
	}

	// Token: 0x04000292 RID: 658
	public HitableActor.ActorType actorType;

	// Token: 0x02000115 RID: 277
	public enum ActorType
	{
		// Token: 0x04000756 RID: 1878
		Player,
		// Token: 0x04000757 RID: 1879
		Enemy
	}
}
