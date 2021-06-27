using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000068 RID: 104
public class MobServerDragon : MobServer
{
	// Token: 0x0600024E RID: 590 RVA: 0x0000D842 File Offset: 0x0000BA42
	private void Start()
	{
		base.StartRoutines();
		this.nodes = new List<Vector3>();
		this.serverReadyToAttack = false;
		Invoke(nameof(GetReady), 4f);
	}

	// Token: 0x0600024F RID: 591 RVA: 0x0000D86C File Offset: 0x0000BA6C
	protected override void Behaviour()
	{
		this.TryAttack();
	}

	// Token: 0x06000250 RID: 592 RVA: 0x0000D874 File Offset: 0x0000BA74
	private void TryAttack()
	{
		if (!this.serverReadyToAttack)
		{
			return;
		}
		switch (((BobMob)this.mob).state)
		{
		case BobMob.DragonState.Flying:
			this.FlyingBehaviour();
			break;
		case BobMob.DragonState.Grounded:
			this.GroundedBehaviour();
			break;
		}
		this.previousState = ((BobMob)this.mob).state;
		if (!this.mob.target)
		{
			return;
		}
		if (this.mob.IsAttacking())
		{
			return;
		}
		if (!this.serverReadyToAttack)
		{
			return;
		}
		if (this.mob.targetPlayerId != -1 && GameManager.players[this.mob.targetPlayerId].dead)
		{
			this.mob.target = null;
			return;
		}
	}

	// Token: 0x06000251 RID: 593 RVA: 0x0000D934 File Offset: 0x0000BB34
	private void FlyingBehaviour()
	{
		if (Vector3.Angle((VectorExtensions.XZVector(Boat.Instance.transform.position) - VectorExtensions.XZVector(base.transform.position)).normalized, this.mob.transform.forward) > 70f)
		{
			return;
		}
		PlayerManager randomAlivePlayer = this.GetRandomAlivePlayer();
		if (randomAlivePlayer == null)
		{
			return;
		}
		this.mob.target = randomAlivePlayer.transform;
		float num = this.fireballCooldown;
		float num2 = (float)this.mob.hitable.hp / (float)this.mob.hitable.maxHp;
		num -= 1f - num2;
		this.serverReadyToAttack = false;
		Invoke(nameof(GetReady), num);
		((BobMob)this.mob).projectileController.SpawnProjectilePredictNextPosition();
	}

	// Token: 0x06000252 RID: 594 RVA: 0x0000DA10 File Offset: 0x0000BC10
	private PlayerManager GetRandomAlivePlayer()
	{
		List<PlayerManager> list = new List<PlayerManager>();
		foreach (PlayerManager playerManager in GameManager.players.Values)
		{
			if (playerManager && !playerManager.dead && !playerManager.disconnected)
			{
				list.Add(playerManager);
			}
		}
		if (list.Count == 0)
		{
			return null;
		}
		return list[Random.Range(0, list.Count)];
	}

	// Token: 0x06000253 RID: 595 RVA: 0x0000DAA4 File Offset: 0x0000BCA4
	private void GroundedToFlight()
	{
		((BobMob)this.mob).GroundedToFlight();
		this.currentNodes = 0;
		this.serverReadyToAttack = false;
		Invoke(nameof(GetReady), 4f);
		base.SyncFindNextPosition();
		ServerSend.DragonUpdate(0);
	}

	// Token: 0x06000254 RID: 596 RVA: 0x0000DAE0 File Offset: 0x0000BCE0
	private Vector3 FlyingToGrounded()
	{
		this.hpOnLanding = this.mob.hitable.hp;
		int num = (int)((float)this.mob.hitable.maxHp * 0.33f);
		this.startFlightHp = this.hpOnLanding - num;
		Debug.LogError("flight hp: " + this.startFlightHp);
		this.currentAttacks = 0;
		this.nAttacksBeforeFlight = Random.Range(6, 12);
		((BobMob)this.mob).StartLanding();
		ServerSend.DragonUpdate(1);
		return Boat.Instance.dragonLandingPosition.position;
	}

	// Token: 0x06000255 RID: 597 RVA: 0x0000DB80 File Offset: 0x0000BD80
	private void GroundedBehaviour()
	{
		if (this.mob.hitable.hp < this.startFlightHp)
		{
			this.GroundedToFlight();
			Debug.LogError("Forcing flight since 30% taken");
			return;
		}
		if (this.currentAttacks >= this.nAttacksBeforeFlight)
		{
			this.GroundedToFlight();
			return;
		}
		if (this.previousState != BobMob.DragonState.Grounded)
		{
			this.serverReadyToAttack = false;
			Invoke(nameof(GetReady), Random.Range(3.5f, 4.5f));
			this.currentAttacks = 0;
			return;
		}
		int id = this.GetRandomAlivePlayer().id;
		this.mob.SetTarget(id);
		int num = Random.Range(0, this.mob.attackAnimations.Length);
		this.mob.Attack(this.mob.targetPlayerId, num);
		ServerSend.MobAttack(this.mob.GetId(), this.mob.targetPlayerId, num);
		this.serverReadyToAttack = false;
		Invoke(nameof(GetReady), this.mob.attackTimes[num] + Random.Range(0f, this.mob.attackCooldown));
		this.currentAttacks++;
	}

	// Token: 0x06000256 RID: 598 RVA: 0x0000DC9F File Offset: 0x0000BE9F
	private void GetReady()
	{
		this.serverReadyToAttack = true;
	}

	// Token: 0x06000257 RID: 599 RVA: 0x000030D7 File Offset: 0x000012D7
	public override void TookDamage()
	{
	}

	// Token: 0x06000258 RID: 600 RVA: 0x0000DCA8 File Offset: 0x0000BEA8
	private void FindNodes()
	{
		Vector3 a = Boat.Instance.rbTransform.position + Vector3.up * 90f;
		ConsistentRandom consistentRandom = new ConsistentRandom();
		int num = 6;
		for (int i = 0; i < num; i++)
		{
			Vector3 b = Vector3.right * (float)(consistentRandom.NextDouble() * 2.0 - 1.0) * 130f;
			Vector3 b2 = Vector3.forward * (float)(consistentRandom.NextDouble() * 2.0 - 1.0) * 130f;
			Vector3 b3 = Vector3.up * (float)(consistentRandom.NextDouble() * 2.0 - 1.0) * 40f;
			Vector3 item = a + b + b2 + b3;
			this.nodes.Add(item);
		}
	}

	// Token: 0x06000259 RID: 601 RVA: 0x0000DDAC File Offset: 0x0000BFAC
	private void OnDrawGizmos()
	{
		foreach (Vector3 center in this.nodes)
		{
			Gizmos.color = Color.red;
			Gizmos.DrawSphere(center, 10f);
		}
	}

	// Token: 0x0600025A RID: 602 RVA: 0x0000DE0C File Offset: 0x0000C00C
	protected override Vector3 FindNextPosition()
	{
		base.CancelInvoke("SyncFindNextPosition");
		Invoke(nameof(SyncFindNextPosition), this.findPositionInterval[1]);
		if (this.nodes.Count < 1)
		{
			this.FindNodes();
		}
		switch (((BobMob)this.mob).state)
		{
		case BobMob.DragonState.Flying:
		{
			if ((this.currentNodes > this.minFlyingNodes && Random.Range(0f, 1f) < 0.09f) || this.currentNodes > this.maxFlyingNodes)
			{
				return this.FlyingToGrounded();
			}
			this.currentNodes++;
			Vector3 vector = ((BobMob)this.mob).desiredPos;
			int num = 0;
			while (vector == ((BobMob)this.mob).desiredPos)
			{
				vector = this.nodes[Random.Range(0, this.nodes.Count)];
				num++;
				if (num > 100)
				{
					break;
				}
			}
			return vector;
		}
		}
		return Vector3.zero;
	}

	// Token: 0x0400026E RID: 622
	private List<Vector3> nodes;

	// Token: 0x0400026F RID: 623
	private bool serverReadyToAttack = true;

	// Token: 0x04000270 RID: 624
	private BobMob.DragonState previousState;

	// Token: 0x04000271 RID: 625
	private int hpOnLanding;

	// Token: 0x04000272 RID: 626
	private int startFlightHp;

	// Token: 0x04000273 RID: 627
	private int nAttacksBeforeFlight;

	// Token: 0x04000274 RID: 628
	private int currentAttacks;

	// Token: 0x04000275 RID: 629
	private float fireballCooldown = 2.25f;

	// Token: 0x04000276 RID: 630
	private int minFlyingNodes = 6;

	// Token: 0x04000277 RID: 631
	private int maxFlyingNodes = 40;

	// Token: 0x04000278 RID: 632
	private int currentNodes;

	// Token: 0x04000279 RID: 633
	private int damageTakenThisLanding;
}
