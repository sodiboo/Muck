using System;
using UnityEngine;
using UnityEngine.AI;

// Token: 0x020000AA RID: 170
public class Mob : MonoBehaviour, SharedObject
{
	// Token: 0x17000027 RID: 39
	// (get) Token: 0x060003EB RID: 1003 RVA: 0x00004BF6 File Offset: 0x00002DF6
	// (set) Token: 0x060003EC RID: 1004 RVA: 0x00004BFE File Offset: 0x00002DFE
	public Transform target { get; set; }

	// Token: 0x17000028 RID: 40
	// (get) Token: 0x060003ED RID: 1005 RVA: 0x00004C07 File Offset: 0x00002E07
	// (set) Token: 0x060003EE RID: 1006 RVA: 0x00004C0F File Offset: 0x00002E0F
	public int targetPlayerId { get; set; }

	// Token: 0x17000029 RID: 41
	// (get) Token: 0x060003EF RID: 1007 RVA: 0x00004C18 File Offset: 0x00002E18
	// (set) Token: 0x060003F0 RID: 1008 RVA: 0x00004C20 File Offset: 0x00002E20
	public bool ready { get; set; } = true;

	// Token: 0x1700002A RID: 42
	// (get) Token: 0x060003F1 RID: 1009 RVA: 0x00004C29 File Offset: 0x00002E29
	// (set) Token: 0x060003F2 RID: 1010 RVA: 0x00004C31 File Offset: 0x00002E31
	public float multiplier { get; set; } = 1f;

	// Token: 0x1700002B RID: 43
	// (get) Token: 0x060003F3 RID: 1011 RVA: 0x00004C3A File Offset: 0x00002E3A
	// (set) Token: 0x060003F4 RID: 1012 RVA: 0x00004C42 File Offset: 0x00002E42
	public float bossMultiplier { get; set; } = 1f;

	// Token: 0x1700002C RID: 44
	// (get) Token: 0x060003F5 RID: 1013 RVA: 0x00004C4B File Offset: 0x00002E4B
	// (set) Token: 0x060003F6 RID: 1014 RVA: 0x00004C53 File Offset: 0x00002E53
	public Animator animator { get; private set; }

	// Token: 0x1700002D RID: 45
	// (get) Token: 0x060003F7 RID: 1015 RVA: 0x00004C5C File Offset: 0x00002E5C
	// (set) Token: 0x060003F8 RID: 1016 RVA: 0x00004C64 File Offset: 0x00002E64
	public NavMeshAgent agent { get; private set; }

	// Token: 0x1700002E RID: 46
	// (get) Token: 0x060003F9 RID: 1017 RVA: 0x00004C6D File Offset: 0x00002E6D
	// (set) Token: 0x060003FA RID: 1018 RVA: 0x00004C75 File Offset: 0x00002E75
	public Hitable hitable { get; private set; }

	// Token: 0x060003FB RID: 1019 RVA: 0x00004C7E File Offset: 0x00002E7E
	private void TestSpawn()
	{
		this.id = MobManager.Instance.GetNextId();
		MobManager.Instance.AddMob(this, this.id);
	}

	// Token: 0x060003FC RID: 1020 RVA: 0x00004CA1 File Offset: 0x00002EA1
	public bool IsBuff()
	{
		return this.multiplier > 1f;
	}

	// Token: 0x060003FD RID: 1021 RVA: 0x00004CB0 File Offset: 0x00002EB0
	private void Start()
	{
		if (this.IsBuff())
		{
			MonoBehaviour.print("dangerous mob oOoOOo spooky");
			base.transform.localScale *= 1.4f;
		}
	}

	// Token: 0x060003FE RID: 1022 RVA: 0x00004CDF File Offset: 0x00002EDF
	public void SetSpeed(float multiplier)
	{
		this.agent.speed = this.mobType.speed * multiplier;
	}

	// Token: 0x060003FF RID: 1023 RVA: 0x000166E4 File Offset: 0x000148E4
	private void Awake()
	{
		this.hitable = base.GetComponent<Hitable>();
		this.agent = base.GetComponent<NavMeshAgent>();
		this.agent.speed = this.mobType.speed;
		this.animator = base.GetComponent<Animator>();
		this.defaulAngularSpeed = this.agent.angularSpeed;
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
		}
		this.attackTimes = new float[this.attackAnimations.Length];
		for (int i = 0; i < this.attackAnimations.Length; i++)
		{
			this.attackTimes[i] = this.attackAnimations[i].length;
		}
	}

	// Token: 0x1700002F RID: 47
	// (get) Token: 0x06000400 RID: 1024 RVA: 0x00004CF9 File Offset: 0x00002EF9
	// (set) Token: 0x06000401 RID: 1025 RVA: 0x00004D01 File Offset: 0x00002F01
	public float[] attackTimes { get; set; }

	// Token: 0x06000402 RID: 1026 RVA: 0x00004D0A File Offset: 0x00002F0A
	private void Update()
	{
		this.Animate();
		this.ExtraUpdate();
		this.FootSteps();
		this.UpdateOffsetPosition();
	}

	// Token: 0x06000403 RID: 1027 RVA: 0x000167D0 File Offset: 0x000149D0
	private void FootSteps()
	{
		if (!this.footstepFx)
		{
			return;
		}
		if (Vector3.Distance(PlayerMovement.Instance.playerCam.transform.position, base.transform.position) > 50f)
		{
			return;
		}
		float num = this.agent.velocity.magnitude * 3f;
		if (num > 20f)
		{
			num = 20f;
		}
		this.distance += num * Time.deltaTime * 50f * this.footstepFrequency;
		if (this.distance > 300f / this.footstepFrequency)
		{
		Instantiate<GameObject>(this.footstepFx, base.transform.position, Quaternion.identity);
			this.distance = 0f;
		}
	}

	// Token: 0x06000404 RID: 1028 RVA: 0x00002147 File Offset: 0x00000347
	public virtual void ExtraUpdate()
	{
	}

	// Token: 0x06000405 RID: 1029 RVA: 0x0001689C File Offset: 0x00014A9C
	public void Knockback(Vector3 dir)
	{
		base.CancelInvoke(nameof(StopKnockback));
		this.oldAngularSpeed = this.agent.angularSpeed;
		this.agent.destination = base.transform.position + dir * 6f;
		this.animator.SetBool("Knockback", true);
		this.knocked = true;
		this.agent.velocity += dir * 10f;
		this.agent.angularSpeed = 0f;
		this.agent.updateRotation = false;
		base.Invoke(nameof(StopKnockback), 0.75f);
	}

	// Token: 0x06000406 RID: 1030 RVA: 0x00016950 File Offset: 0x00014B50
	private void StopKnockback()
	{
		this.animator.SetBool("Knockback", false);
		this.agent.velocity = Vector3.zero;
		this.knocked = false;
		this.agent.angularSpeed = this.defaulAngularSpeed;
		this.agent.updateRotation = true;
	}

	// Token: 0x06000407 RID: 1031 RVA: 0x000169A4 File Offset: 0x00014BA4
	private void LateUpdate()
	{
		if (!this.target)
		{
			return;
		}
		float num = Vector3.Distance(base.transform.position, this.target.position);
		if (!this.attacking && num < this.agent.stoppingDistance)
		{
			Quaternion b = Quaternion.LookRotation(VectorExtensions.XZVector(this.target.transform.position - base.transform.position));
			base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6f);
		}
	}

	// Token: 0x06000408 RID: 1032 RVA: 0x00004D24 File Offset: 0x00002F24
	public bool IsAttacking()
	{
		return this.attacking;
	}

	// Token: 0x06000409 RID: 1033 RVA: 0x00004D2C File Offset: 0x00002F2C
	public bool IsRangedAttacking()
	{
		return this.currentAttackType == Mob.AttackType.Ranged;
	}

	// Token: 0x0600040A RID: 1034 RVA: 0x00016A44 File Offset: 0x00014C44
	public void Attack(int targetPlayerId, int attackAnimationIndex)
	{
		MonoBehaviour.print("attacking. stoponattack: " + this.stopOnAttack.ToString());
		if (this.stopOnAttack)
		{
			this.agent.isStopped = true;
			this.attacking = true;
		}
		if (attackAnimationIndex >= this.attackAnimations.Length - this.nRangedAttacks)
		{
			this.currentAttackType = Mob.AttackType.Ranged;
		}
		else
		{
			this.currentAttackType = Mob.AttackType.Melee;
		}
		base.Invoke(nameof(FinishAttacking), this.attackTimes[attackAnimationIndex]);
		this.animator.Play(this.attackAnimations[attackAnimationIndex].name);
		this.targetPlayerId = targetPlayerId;
	}

	// Token: 0x0600040B RID: 1035 RVA: 0x00004D37 File Offset: 0x00002F37
	private void FinishAttacking()
	{
		this.attacking = false;
		this.currentAttackType = Mob.AttackType.Melee;
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.agent.isStopped = false;
	}

	// Token: 0x0600040C RID: 1036 RVA: 0x00016ADC File Offset: 0x00014CDC
	private void Animate()
	{
		if (!this.animator)
		{
			return;
		}
		float value = this.agent.velocity.magnitude / this.agent.speed;
		this.animator.SetFloat("Speed", value);
	}

	// Token: 0x0600040D RID: 1037 RVA: 0x00004D61 File Offset: 0x00002F61
	public void SetDestination(Vector3 dest)
	{
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.agent.destination = dest;
		this.agent.isStopped = false;
	}

	// Token: 0x0600040E RID: 1038 RVA: 0x00004D89 File Offset: 0x00002F89
	public void SetTarget(int targetId)
	{
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.targetPlayerId = targetId;
		this.target = GameManager.players[this.targetPlayerId].transform;
	}

	// Token: 0x0600040F RID: 1039 RVA: 0x00016B28 File Offset: 0x00014D28
	public void SetPosition(Vector3 nextPosition)
	{
		Debug.DrawLine(base.transform.position, nextPosition, Color.red, 10f);
		this.offsetPosition = nextPosition - base.transform.position;
		this.offsetDir = this.offsetPosition.normalized;
	}

	// Token: 0x06000410 RID: 1040 RVA: 0x00016B78 File Offset: 0x00014D78
	private void UpdateOffsetPosition()
	{
		if (this.offsetPosition.x <= 0f)
		{
			return;
		}
		Vector3 vector = this.offsetDir * this.syncSpeed * Time.deltaTime;
		this.offsetPosition -= vector;
		if (this.offsetPosition.x < 0f)
		{
			vector -= this.offsetPosition;
		}
		base.transform.position += vector;
	}

	// Token: 0x06000411 RID: 1041 RVA: 0x00004DBB File Offset: 0x00002FBB
	public void SetId(int id)
	{
		this.id = id;
		this.hitable.SetId(id);
	}

	// Token: 0x06000412 RID: 1042 RVA: 0x00004DD0 File Offset: 0x00002FD0
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x040003E4 RID: 996
	public MobType mobType;

	// Token: 0x040003E7 RID: 999
	public float attackCooldown;

	// Token: 0x040003E8 RID: 1000
	public int id;

	// Token: 0x040003EC RID: 1004
	public bool stopOnAttack;

	// Token: 0x040003F0 RID: 1008
	private bool attacking;

	// Token: 0x040003F1 RID: 1009
	public Mob.BossType bossType;

	// Token: 0x040003F2 RID: 1010
	public AnimationClip[] attackAnimations;

	// Token: 0x040003F4 RID: 1012
	public GameObject footstepFx;

	// Token: 0x040003F5 RID: 1013
	private float distance;

	// Token: 0x040003F6 RID: 1014
	public float footstepFrequency = 1f;

	// Token: 0x040003F7 RID: 1015
	public bool knocked;

	// Token: 0x040003F8 RID: 1016
	private float defaulAngularSpeed;

	// Token: 0x040003F9 RID: 1017
	private float oldAccel;

	// Token: 0x040003FA RID: 1018
	private float oldAngularSpeed;

	// Token: 0x040003FB RID: 1019
	public int nRangedAttacks;

	// Token: 0x040003FC RID: 1020
	private Mob.AttackType currentAttackType;

	// Token: 0x040003FD RID: 1021
	private Vector3 offsetPosition;

	// Token: 0x040003FE RID: 1022
	private Vector3 offsetDir;

	// Token: 0x040003FF RID: 1023
	private float syncSpeed = 5f;

	// Token: 0x020000AB RID: 171
	public enum AttackType
	{
		// Token: 0x04000401 RID: 1025
		Melee,
		// Token: 0x04000402 RID: 1026
		Ranged
	}

	// Token: 0x020000AC RID: 172
	public enum BossType
	{
		// Token: 0x04000404 RID: 1028
		None,
		// Token: 0x04000405 RID: 1029
		BossNight,
		// Token: 0x04000406 RID: 1030
		BossShrine
	}
}
