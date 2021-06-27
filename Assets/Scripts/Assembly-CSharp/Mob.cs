using System;
using UnityEngine;
using UnityEngine.AI;

public class Mob : MonoBehaviour, SharedObject
{
	public Transform target { get; set; }

	public int targetPlayerId { get; set; }

	public bool ready { get; set; } = true;

	public float multiplier { get; set; } = 1f;

	public float bossMultiplier { get; set; } = 1f;

	public Animator animator { get; protected set; }

	public NavMeshAgent agent { get; private set; }

	public Hitable hitable { get; protected set; }

	private void TestSpawn()
	{
		this.id = MobManager.Instance.GetNextId();
		MobManager.Instance.AddMob(this, this.id);
	}

	public bool IsBuff()
	{
		return this.multiplier > 1f;
	}

	private void Start()
	{
		if (this.IsBuff())
		{
			base.transform.localScale *= 1.4f;
		}
	}

	public void SetSpeed(float multiplier)
	{
		this.agent.speed = this.mobType.speed * multiplier;
	}

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

	public float[] attackTimes { get; set; }

	private void Update()
	{
		this.Animate();
		this.ExtraUpdate();
		this.FootSteps();
		this.UpdateOffsetPosition();
	}

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

	public virtual void ExtraUpdate()
	{
	}

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

	private void StopKnockback()
	{
		this.animator.SetBool("Knockback", false);
		this.agent.velocity = Vector3.zero;
		this.knocked = false;
		this.agent.angularSpeed = this.defaulAngularSpeed;
		this.agent.updateRotation = true;
	}

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

	public bool IsAttacking()
	{
		return this.attacking;
	}

	public bool IsRangedAttacking()
	{
		return this.currentAttackType == Mob.AttackType.Ranged;
	}

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

	protected virtual void Animate()
	{
		if (!this.animator)
		{
			return;
		}
		float value = this.agent.velocity.magnitude / this.agent.speed;
		this.animator.SetFloat("Speed", value);
	}

	public virtual void SetDestination(Vector3 dest)
	{
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.agent.destination = dest;
		this.agent.isStopped = false;
	}

	public virtual void SetTarget(int targetId)
	{
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.targetPlayerId = targetId;
		this.target = GameManager.players[this.targetPlayerId].transform;
	}

	public void SetPosition(Vector3 nextPosition)
	{
		Debug.DrawLine(base.transform.position, nextPosition, Color.red, 10f);
		this.offsetPosition = nextPosition - base.transform.position;
		this.offsetDir = this.offsetPosition.normalized;
	}

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

	public void SetId(int id)
	{
		this.id = id;
		this.hitable.SetId(id);
	}

	public int GetId()
	{
		return this.id;
	}

	public MobType mobType;

	public float attackCooldown;

	public int id;

	public bool stopOnAttack;

	private bool attacking;

	public Mob.BossType bossType;

	public AnimationClip[] attackAnimations;

	public GameObject footstepFx;

	private float distance;

	public float footstepFrequency = 1f;

	public bool knocked;

	private float defaulAngularSpeed;

	private float oldAccel;

	private float oldAngularSpeed;

	public int nRangedAttacks;

	private Mob.AttackType currentAttackType;

	private Vector3 offsetPosition;

	private Vector3 offsetDir;

	private float syncSpeed = 5f;

	public enum AttackType
	{
		Melee,
		Ranged
	}

	public enum BossType
	{
		None,
		BossNight,
		BossShrine
	}
}
