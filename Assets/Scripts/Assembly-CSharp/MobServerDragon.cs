using System.Collections.Generic;
using UnityEngine;

public class MobServerDragon : MobServer
{
	private void Start()
	{
		base.StartRoutines();
		this.nodes = new List<Vector3>();
		this.serverReadyToAttack = false;
		Invoke(nameof(GetReady), 4f);
	}

	protected override void Behaviour()
	{
		this.TryAttack();
	}

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

	private void GroundedToFlight()
	{
		((BobMob)this.mob).GroundedToFlight();
		this.currentNodes = 0;
		this.serverReadyToAttack = false;
		Invoke(nameof(GetReady), 4f);
		base.SyncFindNextPosition();
		ServerSend.DragonUpdate(0);
	}

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

	private void GetReady()
	{
		this.serverReadyToAttack = true;
	}

	public override void TookDamage()
	{
	}

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

	private void OnDrawGizmos()
	{
		foreach (Vector3 center in this.nodes)
		{
			Gizmos.color = Color.red;
			Gizmos.DrawSphere(center, 10f);
		}
	}

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

	private List<Vector3> nodes;

	private bool serverReadyToAttack = true;

	private BobMob.DragonState previousState;

	private int hpOnLanding;

	private int startFlightHp;

	private int nAttacksBeforeFlight;

	private int currentAttacks;

	private float fireballCooldown = 2.25f;

	private int minFlyingNodes = 6;

	private int maxFlyingNodes = 40;

	private int currentNodes;

	private int damageTakenThisLanding;
}
