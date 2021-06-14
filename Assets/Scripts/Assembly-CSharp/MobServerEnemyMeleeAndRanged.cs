using UnityEngine;

// Token: 0x020000B0 RID: 176
public class MobServerEnemyMeleeAndRanged : MobServerEnemy
{
	// Token: 0x06000427 RID: 1063 RVA: 0x00004E8C File Offset: 0x0000308C
	private new void Start()
	{
		base.Start();
		base.Invoke("GetReadyForRangedAttack", Random.Range(this.rangedCooldown * 0.5f, this.rangedCooldown * 1.5f));
	}

	// Token: 0x06000428 RID: 1064 RVA: 0x00017518 File Offset: 0x00015718
	protected override void AttackBehaviour()
	{
		this.rangedCooldown = this.mob.mobType.rangedCooldown;
		float num = Vector3.Distance(this.mob.target.position, base.transform.position);
		bool flag = true;
		if (num <= this.mob.mobType.startAttackDistance && num >= this.mob.mobType.startRangedAttackDistance)
		{
			flag = (Random.Range(0f, 1f) < 0.5f);
		}
		if (num > this.mob.mobType.startAttackDistance || !flag)
		{
			if (num <= this.mob.mobType.maxAttackDistance && this.readyForRangedAttack)
			{
				int num2 = Random.Range(0, this.mob.nRangedAttacks);
				int num3 = this.mob.attackAnimations.Length - 1 - num2;
				this.mob.Attack(this.mob.targetPlayerId, num3);
				ServerSend.MobAttack(this.mob.GetId(), this.mob.targetPlayerId, num3);
				this.serverReadyToAttack = false;
				base.Invoke("GetReady", this.mob.attackTimes[num3] + Random.Range(0f, this.mob.attackCooldown));
				this.readyForRangedAttack = false;
				base.Invoke("GetReadyForRangedAttack", Random.Range(this.rangedCooldown * 0.5f, this.rangedCooldown * 1.5f));
			}
			return;
		}
		if (Mathf.Abs(Vector3.SignedAngle(base.transform.forward, VectorExtensions.XZVector(this.mob.target.position) - VectorExtensions.XZVector(base.transform.position), Vector3.up)) > this.mob.mobType.minAttackAngle)
		{
			return;
		}
		int num4 = 0;
		if (this.mob.mobType.onlyRangedInRangedPattern)
		{
			num4 = this.mob.nRangedAttacks;
		}
		int num5 = Random.Range(0, this.mob.attackAnimations.Length - num4);
		this.mob.Attack(this.mob.targetPlayerId, num5);
		ServerSend.MobAttack(this.mob.GetId(), this.mob.targetPlayerId, num5);
		this.serverReadyToAttack = false;
		base.Invoke("GetReady", this.mob.attackTimes[num5] + Random.Range(0f, this.mob.attackCooldown));
	}

	// Token: 0x06000429 RID: 1065 RVA: 0x00004EBC File Offset: 0x000030BC
	private void GetReadyForRangedAttack()
	{
		this.readyForRangedAttack = true;
	}

	// Token: 0x04000411 RID: 1041
	public float rangedCooldown = 6f;

	// Token: 0x04000412 RID: 1042
	public bool readyForRangedAttack;
}
