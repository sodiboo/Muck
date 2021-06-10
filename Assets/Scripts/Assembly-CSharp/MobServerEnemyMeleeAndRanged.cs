
using UnityEngine;

// Token: 0x0200008C RID: 140
public class MobServerEnemyMeleeAndRanged : MobServerEnemy
{
	// Token: 0x060003D0 RID: 976 RVA: 0x00013727 File Offset: 0x00011927
	private new void Start()
	{
		base.Start();
		base.Invoke("GetReadyForRangedAttack", Random.Range(this.rangedCooldown * 0.5f, this.rangedCooldown * 1.5f));
	}

	// Token: 0x060003D1 RID: 977 RVA: 0x00013758 File Offset: 0x00011958
	protected override void AttackBehaviour()
	{
		this.rangedCooldown = this.mob.mobType.rangedCooldown;
		float num = Vector3.Distance(this.mob.target.position, base.transform.position);
		if (num > this.mob.mobType.startAttackDistance)
		{
			if (num <= this.mob.mobType.maxAttackDistance && this.readyForRangedAttack)
			{
				int num2 = this.mob.attackAnimations.Length - 1;
				this.mob.Attack(this.mob.targetPlayerId, num2);
				ServerSend.MobAttack(this.mob.GetId(), this.mob.targetPlayerId, num2);
				this.serverReadyToAttack = false;
				base.Invoke("GetReady", this.mob.attackTimes[num2] + Random.Range(0f, this.mob.attackCooldown));
				this.readyForRangedAttack = false;
				base.Invoke("GetReadyForRangedAttack", Random.Range(this.rangedCooldown * 0.5f, this.rangedCooldown * 1.5f));
			}
			return;
		}
		if (Mathf.Abs(Vector3.SignedAngle(base.transform.forward, VectorExtensions.XZVector(this.mob.target.position) - VectorExtensions.XZVector(base.transform.position), Vector3.up)) > this.mob.mobType.minAttackAngle)
		{
			return;
		}
		int num3 = 0;
		if (this.mob.mobType.onlyRangedInRangedPattern)
		{
			num3 = 1;
		}
		int num4 = Random.Range(0, this.mob.attackAnimations.Length - num3);
		this.mob.Attack(this.mob.targetPlayerId, num4);
		ServerSend.MobAttack(this.mob.GetId(), this.mob.targetPlayerId, num4);
		this.serverReadyToAttack = false;
		base.Invoke("GetReady", this.mob.attackTimes[num4] + Random.Range(0f, this.mob.attackCooldown));
	}

	// Token: 0x060003D2 RID: 978 RVA: 0x00013966 File Offset: 0x00011B66
	private void GetReadyForRangedAttack()
	{
		this.readyForRangedAttack = true;
	}

	// Token: 0x04000363 RID: 867
	public float rangedCooldown = 6f;

	// Token: 0x04000364 RID: 868
	public bool readyForRangedAttack;
}
