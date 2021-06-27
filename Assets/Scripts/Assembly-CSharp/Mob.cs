using System;
using UnityEngine;
using UnityEngine.AI;

// Token: 0x020000AF RID: 175
public class Mob : MonoBehaviour, SharedObject
{
	// Token: 0x1700002D RID: 45
	// (get) Token: 0x0600048A RID: 1162 RVA: 0x0001799B File Offset: 0x00015B9B
	// (set) Token: 0x0600048B RID: 1163 RVA: 0x000179A3 File Offset: 0x00015BA3
	public Transform target { get; set; }

	// Token: 0x1700002E RID: 46
	// (get) Token: 0x0600048C RID: 1164 RVA: 0x000179AC File Offset: 0x00015BAC
	// (set) Token: 0x0600048D RID: 1165 RVA: 0x000179B4 File Offset: 0x00015BB4
	public int targetPlayerId { get; set; }

	// Token: 0x1700002F RID: 47
	// (get) Token: 0x0600048E RID: 1166 RVA: 0x000179BD File Offset: 0x00015BBD
	// (set) Token: 0x0600048F RID: 1167 RVA: 0x000179C5 File Offset: 0x00015BC5
	public bool ready { get; set; } = true;

	// Token: 0x17000030 RID: 48
	// (get) Token: 0x06000490 RID: 1168 RVA: 0x000179CE File Offset: 0x00015BCE
	// (set) Token: 0x06000491 RID: 1169 RVA: 0x000179D6 File Offset: 0x00015BD6
	public float multiplier { get; set; } = 1f;

	// Token: 0x17000031 RID: 49
	// (get) Token: 0x06000492 RID: 1170 RVA: 0x000179DF File Offset: 0x00015BDF
	// (set) Token: 0x06000493 RID: 1171 RVA: 0x000179E7 File Offset: 0x00015BE7
	public float bossMultiplier { get; set; } = 1f;

	// Token: 0x17000032 RID: 50
	// (get) Token: 0x06000494 RID: 1172 RVA: 0x000179F0 File Offset: 0x00015BF0
	// (set) Token: 0x06000495 RID: 1173 RVA: 0x000179F8 File Offset: 0x00015BF8
	public Animator animator { get; protected set; }

	// Token: 0x17000033 RID: 51
	// (get) Token: 0x06000496 RID: 1174 RVA: 0x00017A01 File Offset: 0x00015C01
	// (set) Token: 0x06000497 RID: 1175 RVA: 0x00017A09 File Offset: 0x00015C09
	public NavMeshAgent agent { get; private set; }

	// Token: 0x17000034 RID: 52
	// (get) Token: 0x06000498 RID: 1176 RVA: 0x00017A12 File Offset: 0x00015C12
	// (set) Token: 0x06000499 RID: 1177 RVA: 0x00017A1A File Offset: 0x00015C1A
	public Hitable hitable { get; protected set; }

	// Token: 0x0600049A RID: 1178 RVA: 0x00017A23 File Offset: 0x00015C23
	private void TestSpawn()
	{
		this.id = MobManager.Instance.GetNextId();
		MobManager.Instance.AddMob(this, this.id);
	}

	// Token: 0x0600049B RID: 1179 RVA: 0x00017A46 File Offset: 0x00015C46
	public bool IsBuff()
	{
		return this.multiplier > 1f;
	}

	// Token: 0x0600049C RID: 1180 RVA: 0x00017A55 File Offset: 0x00015C55
	private void Start()
	{
		if (this.IsBuff())
		{
			base.transform.localScale *= 1.4f;
		}
	}

	// Token: 0x0600049D RID: 1181 RVA: 0x00017A7A File Offset: 0x00015C7A
	public void SetSpeed(float multiplier)
	{
		this.agent.speed = this.mobType.speed * multiplier;
	}

	// Token: 0x0600049E RID: 1182 RVA: 0x00017A94 File Offset: 0x00015C94
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

	// Token: 0x17000035 RID: 53
	// (get) Token: 0x0600049F RID: 1183 RVA: 0x00017B7F File Offset: 0x00015D7F
	// (set) Token: 0x060004A0 RID: 1184 RVA: 0x00017B87 File Offset: 0x00015D87
	public float[] attackTimes { get; set; }

	// Token: 0x060004A1 RID: 1185 RVA: 0x00017B90 File Offset: 0x00015D90
	private void Update()
	{
		this.Animate();
		this.ExtraUpdate();
		this.FootSteps();
		this.UpdateOffsetPosition();
	}

	// Token: 0x060004A2 RID: 1186 RVA: 0x00017BAC File Offset: 0x00015DAC
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

	// Token: 0x060004A3 RID: 1187 RVA: 0x000030D7 File Offset: 0x000012D7
	public virtual void ExtraUpdate()
	{
	}

	// Token: 0x060004A4 RID: 1188 RVA: 0x00017C78 File Offset: 0x00015E78
	public void Knockback(Vector3 dir)
	{
		base.CancelInvoke("StopKnockback");
		this.oldAngularSpeed = this.agent.angularSpeed;
		this.agent.destination = base.transform.position + dir * 6f;
		this.animator.SetBool("Knockback", true);
		this.knocked = true;
		this.agent.velocity += dir * 10f;
		this.agent.angularSpeed = 0f;
		this.agent.updateRotation = false;
		Invoke(nameof(StopKnockback), 0.75f);
	}

	// Token: 0x060004A5 RID: 1189 RVA: 0x00017D2C File Offset: 0x00015F2C
	private void StopKnockback()
	{
		this.animator.SetBool("Knockback", false);
		this.agent.velocity = Vector3.zero;
		this.knocked = false;
		this.agent.angularSpeed = this.defaulAngularSpeed;
		this.agent.updateRotation = true;
	}

	// Token: 0x060004A6 RID: 1190 RVA: 0x00017D80 File Offset: 0x00015F80
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

	// Token: 0x060004A7 RID: 1191 RVA: 0x00017E1F File Offset: 0x0001601F
	public bool IsAttacking()
	{
		return this.attacking;
	}

	// Token: 0x060004A8 RID: 1192 RVA: 0x00017E27 File Offset: 0x00016027
	public bool IsRangedAttacking()
	{
		return this.currentAttackType == Mob.AttackType.Ranged;
	}

	// Token: 0x060004A9 RID: 1193 RVA: 0x00017E34 File Offset: 0x00016034
	public virtual void Attack(int targetPlayerId, int attackAnimationIndex)
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
		Invoke(nameof(FinishAttacking), this.attackTimes[attackAnimationIndex]);
		this.animator.Play(this.attackAnimations[attackAnimationIndex].name);
		this.targetPlayerId = targetPlayerId;
	}

	// Token: 0x060004AA RID: 1194 RVA: 0x00017ECA File Offset: 0x000160CA
	protected virtual void FinishAttacking()
	{
		this.attacking = false;
		this.currentAttackType = Mob.AttackType.Melee;
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.agent.isStopped = false;
	}

	// Token: 0x060004AB RID: 1195 RVA: 0x00017EF4 File Offset: 0x000160F4
	protected virtual void Animate()
	{
		if (!this.animator)
		{
			return;
		}
		float value = this.agent.velocity.magnitude / this.agent.speed;
		this.animator.SetFloat("Speed", value);
	}

	// Token: 0x060004AC RID: 1196 RVA: 0x00017F40 File Offset: 0x00016140
	public virtual void SetDestination(Vector3 dest)
	{
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.agent.destination = dest;
		this.agent.isStopped = false;
	}

	// Token: 0x060004AD RID: 1197 RVA: 0x00017F68 File Offset: 0x00016168
	public virtual void SetTarget(int targetId)
	{
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.targetPlayerId = targetId;
		this.target = GameManager.players[this.targetPlayerId].transform;
	}

	// Token: 0x060004AE RID: 1198 RVA: 0x00017F9C File Offset: 0x0001619C
	public void SetPosition(Vector3 nextPosition)
	{
		Debug.DrawLine(base.transform.position, nextPosition, Color.red, 10f);
		this.offsetPosition = nextPosition - base.transform.position;
		this.offsetDir = this.offsetPosition.normalized;
	}

	// Token: 0x060004AF RID: 1199 RVA: 0x00017FEC File Offset: 0x000161EC
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

	// Token: 0x060004B0 RID: 1200 RVA: 0x00018070 File Offset: 0x00016270
	public void SetId(int id)
	{
		this.id = id;
		this.hitable.SetId(id);
	}

	// Token: 0x060004B1 RID: 1201 RVA: 0x00018085 File Offset: 0x00016285
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x04000447 RID: 1095
	public MobType mobType;

	// Token: 0x0400044A RID: 1098
	public float attackCooldown;

	// Token: 0x0400044B RID: 1099
	public int id;

	// Token: 0x0400044F RID: 1103
	public bool stopOnAttack;

	// Token: 0x04000453 RID: 1107
	private bool attacking;

	// Token: 0x04000454 RID: 1108
	public Mob.BossType bossType;

	// Token: 0x04000455 RID: 1109
	public AnimationClip[] attackAnimations;

	// Token: 0x04000457 RID: 1111
	public GameObject footstepFx;

	// Token: 0x04000458 RID: 1112
	private float distance;

	// Token: 0x04000459 RID: 1113
	public float footstepFrequency = 1f;

	// Token: 0x0400045A RID: 1114
	public bool knocked;

	// Token: 0x0400045B RID: 1115
	private float defaulAngularSpeed;

	// Token: 0x0400045C RID: 1116
	private float oldAccel;

	// Token: 0x0400045D RID: 1117
	private float oldAngularSpeed;

	// Token: 0x0400045E RID: 1118
	public int nRangedAttacks;

	// Token: 0x0400045F RID: 1119
	private Mob.AttackType currentAttackType;

	// Token: 0x04000460 RID: 1120
	private Vector3 offsetPosition;

	// Token: 0x04000461 RID: 1121
	private Vector3 offsetDir;

	// Token: 0x04000462 RID: 1122
	private float syncSpeed = 5f;

	// Token: 0x02000159 RID: 345
	public enum AttackType
	{
		// Token: 0x040008F6 RID: 2294
		Melee,
		// Token: 0x040008F7 RID: 2295
		Ranged
	}

	// Token: 0x0200015A RID: 346
	public enum BossType
	{
		// Token: 0x040008F9 RID: 2297
		None,
		// Token: 0x040008FA RID: 2298
		BossNight,
		// Token: 0x040008FB RID: 2299
		BossShrine
	}
}
