using System;
using UnityEngine;

public class BobMob : Mob
{
	public BobMob.DragonState state { get; set; }

	public Vector3 desiredPos { get; set; }

	public ProjectileAttackNoGravity projectileController { get; set; }

	private void Awake()
	{
		this.projectileController = base.GetComponent<ProjectileAttackNoGravity>();
		this.state = BobMob.DragonState.Flying;
		base.hitable = base.GetComponent<Hitable>();
		base.animator = base.GetComponent<Animator>();
		if (LocalClient.serverOwner)
		{
			if (this.mobType.behaviour == MobType.MobBehaviour.Enemy)
			{
				base.gameObject.AddComponent<MobServerEnemy>();
			}
			else if (this.mobType.behaviour == MobType.MobBehaviour.Neutral)
			{
				base.gameObject.AddComponent<MobServerNeutral>();
			}
			else if (this.mobType.behaviour == MobType.MobBehaviour.EnemyMeleeAndRanged)
			{
				base.gameObject.AddComponent<MobServerEnemyMeleeAndRanged>();
			}
			else if (this.mobType.behaviour == MobType.MobBehaviour.Dragon)
			{
				base.gameObject.AddComponent<MobServerDragon>();
			}
		}
		base.attackTimes = new float[this.attackAnimations.Length];
		for (int i = 0; i < this.attackAnimations.Length; i++)
		{
			base.attackTimes[i] = this.attackAnimations[i].length;
		}
	}

	protected override void Animate()
	{
	}

	public override void SetTarget(int targetId)
	{
		base.targetPlayerId = targetId;
		base.target = GameManager.players[base.targetPlayerId].transform;
	}

	public void StartLanding()
	{
		this.landingNode = 0;
		this.state = BobMob.DragonState.Landing;
	}

	public void GroundedToFlight()
	{
		this.state = BobMob.DragonState.Flying;
		base.animator.SetBool("Landed", false);
	}

	public void DragonUpdate(BobMob.DragonState state)
	{
		if (state != BobMob.DragonState.Flying)
		{
			if (state == BobMob.DragonState.Landing)
			{
				this.StartLanding();
				return;
			}
		}
		else
		{
			this.GroundedToFlight();
		}
	}

	public override void ExtraUpdate()
	{
		switch (this.state)
		{
		case BobMob.DragonState.Flying:
			base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.LookRotation((this.desiredPos - base.transform.position).normalized), Time.deltaTime * 0.6f);
			base.transform.position += base.transform.forward * this.speed * Time.deltaTime;
			return;
		case BobMob.DragonState.Landing:
			if (this.landingNode < 2)
			{
				Vector3 position = Boat.Instance.landingNodes[this.landingNode].position;
				base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.LookRotation((position - base.transform.position).normalized), Time.deltaTime * 6f);
				base.transform.position += base.transform.forward * this.speed * 1.3f * Time.deltaTime;
				if (Vector3.Distance(base.transform.position, position) < 10f)
				{
					this.landingNode++;
				}
				if (this.landingNode > 1)
				{
					this.state = BobMob.DragonState.Grounded;
					CameraShaker.Instance.StepShake(1f);
					return;
				}
			}
			break;
		case BobMob.DragonState.Grounded:
			base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.LookRotation(Boat.Instance.dragonLandingPosition.forward.normalized), Time.deltaTime * 2f);
			base.transform.position = Vector3.Lerp(base.transform.position, this.desiredPos, Time.deltaTime * 2f);
			base.animator.SetBool("Landed", true);
			break;
		default:
			return;
		}
	}

	private void LateUpdate()
	{
	}

	public override void Attack(int targetPlayerId, int attackAnimationIndex)
	{
		Invoke(nameof(FinishAttacking), base.attackTimes[attackAnimationIndex]);
		base.animator.Play(this.attackAnimations[attackAnimationIndex].name);
		base.targetPlayerId = targetPlayerId;
	}

	protected override void FinishAttacking()
	{
	}

	public override void SetDestination(Vector3 dest)
	{
		this.desiredPos = dest;
	}

	private int landingNode;

	private float t;

	private float speed = 50f;

	public enum DragonState
	{
		Flying,
		Landing,
		Grounded
	}
}
