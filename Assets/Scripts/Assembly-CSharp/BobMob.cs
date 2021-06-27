using System;
using UnityEngine;

// Token: 0x02000008 RID: 8
public class BobMob : Mob
{
	// Token: 0x17000005 RID: 5
	// (get) Token: 0x0600002B RID: 43 RVA: 0x00002FBB File Offset: 0x000011BB
	// (set) Token: 0x0600002C RID: 44 RVA: 0x00002FC3 File Offset: 0x000011C3
	public BobMob.DragonState state { get; set; }

	// Token: 0x17000006 RID: 6
	// (get) Token: 0x0600002D RID: 45 RVA: 0x00002FCC File Offset: 0x000011CC
	// (set) Token: 0x0600002E RID: 46 RVA: 0x00002FD4 File Offset: 0x000011D4
	public Vector3 desiredPos { get; set; }

	// Token: 0x17000007 RID: 7
	// (get) Token: 0x0600002F RID: 47 RVA: 0x00002FDD File Offset: 0x000011DD
	// (set) Token: 0x06000030 RID: 48 RVA: 0x00002FE5 File Offset: 0x000011E5
	public ProjectileAttackNoGravity projectileController { get; set; }

	// Token: 0x06000031 RID: 49 RVA: 0x00002FF0 File Offset: 0x000011F0
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

	// Token: 0x06000032 RID: 50 RVA: 0x000030D7 File Offset: 0x000012D7
	protected override void Animate()
	{
	}

	// Token: 0x06000033 RID: 51 RVA: 0x000030D9 File Offset: 0x000012D9
	public override void SetTarget(int targetId)
	{
		base.targetPlayerId = targetId;
		base.target = GameManager.players[base.targetPlayerId].transform;
	}

	// Token: 0x06000034 RID: 52 RVA: 0x000030FD File Offset: 0x000012FD
	public void StartLanding()
	{
		this.landingNode = 0;
		this.state = BobMob.DragonState.Landing;
	}

	// Token: 0x06000035 RID: 53 RVA: 0x0000310D File Offset: 0x0000130D
	public void GroundedToFlight()
	{
		this.state = BobMob.DragonState.Flying;
		base.animator.SetBool("Landed", false);
	}

	// Token: 0x06000036 RID: 54 RVA: 0x00003127 File Offset: 0x00001327
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

	// Token: 0x06000037 RID: 55 RVA: 0x00003140 File Offset: 0x00001340
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

	// Token: 0x06000038 RID: 56 RVA: 0x000030D7 File Offset: 0x000012D7
	private void LateUpdate()
	{
	}

	// Token: 0x06000039 RID: 57 RVA: 0x00003356 File Offset: 0x00001556
	public override void Attack(int targetPlayerId, int attackAnimationIndex)
	{
		Invoke(nameof(FinishAttacking), base.attackTimes[attackAnimationIndex]);
		base.animator.Play(this.attackAnimations[attackAnimationIndex].name);
		base.targetPlayerId = targetPlayerId;
	}

	// Token: 0x0600003A RID: 58 RVA: 0x000030D7 File Offset: 0x000012D7
	protected override void FinishAttacking()
	{
	}

	// Token: 0x0600003B RID: 59 RVA: 0x0000338A File Offset: 0x0000158A
	public override void SetDestination(Vector3 dest)
	{
		this.desiredPos = dest;
	}

	// Token: 0x04000035 RID: 53
	private int landingNode;

	// Token: 0x04000036 RID: 54
	private float t;

	// Token: 0x04000037 RID: 55
	private float speed = 50f;

	// Token: 0x0200013C RID: 316
	public enum DragonState
	{
		// Token: 0x0400087E RID: 2174
		Flying,
		// Token: 0x0400087F RID: 2175
		Landing,
		// Token: 0x04000880 RID: 2176
		Grounded
	}
}
