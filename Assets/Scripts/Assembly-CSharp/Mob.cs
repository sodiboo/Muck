
using UnityEngine;
using UnityEngine.AI;

// Token: 0x02000088 RID: 136
public class Mob : MonoBehaviour, SharedObject
{
	// Token: 0x17000022 RID: 34
	// (get) Token: 0x06000399 RID: 921 RVA: 0x000128B8 File Offset: 0x00010AB8
	// (set) Token: 0x0600039A RID: 922 RVA: 0x000128C0 File Offset: 0x00010AC0
	public Transform target { get; set; }

	// Token: 0x17000023 RID: 35
	// (get) Token: 0x0600039B RID: 923 RVA: 0x000128C9 File Offset: 0x00010AC9
	// (set) Token: 0x0600039C RID: 924 RVA: 0x000128D1 File Offset: 0x00010AD1
	public int targetPlayerId { get; set; }

	// Token: 0x17000024 RID: 36
	// (get) Token: 0x0600039D RID: 925 RVA: 0x000128DA File Offset: 0x00010ADA
	// (set) Token: 0x0600039E RID: 926 RVA: 0x000128E2 File Offset: 0x00010AE2
	public float multiplier { get; set; } = 1f;

	// Token: 0x17000025 RID: 37
	// (get) Token: 0x0600039F RID: 927 RVA: 0x000128EB File Offset: 0x00010AEB
	// (set) Token: 0x060003A0 RID: 928 RVA: 0x000128F3 File Offset: 0x00010AF3
	public float bossMultiplier { get; set; } = 1f;

	// Token: 0x17000026 RID: 38
	// (get) Token: 0x060003A1 RID: 929 RVA: 0x000128FC File Offset: 0x00010AFC
	// (set) Token: 0x060003A2 RID: 930 RVA: 0x00012904 File Offset: 0x00010B04
	public Animator animator { get; private set; }

	// Token: 0x17000027 RID: 39
	// (get) Token: 0x060003A3 RID: 931 RVA: 0x0001290D File Offset: 0x00010B0D
	// (set) Token: 0x060003A4 RID: 932 RVA: 0x00012915 File Offset: 0x00010B15
	public NavMeshAgent agent { get; private set; }

	// Token: 0x17000028 RID: 40
	// (get) Token: 0x060003A5 RID: 933 RVA: 0x0001291E File Offset: 0x00010B1E
	// (set) Token: 0x060003A6 RID: 934 RVA: 0x00012926 File Offset: 0x00010B26
	public Hitable hitable { get; private set; }

	// Token: 0x060003A7 RID: 935 RVA: 0x0001292F File Offset: 0x00010B2F
	private void TestSpawn()
	{
		this.id = MobManager.Instance.GetNextId();
		MobManager.Instance.AddMob(this, this.id);
	}

	// Token: 0x060003A8 RID: 936 RVA: 0x00012952 File Offset: 0x00010B52
	public bool IsBuff()
	{
		return this.multiplier > 1f;
	}

	// Token: 0x060003A9 RID: 937 RVA: 0x00012961 File Offset: 0x00010B61
	private void Start()
	{
		if (this.IsBuff())
		{
			MonoBehaviour.print("dangerous mob oOoOOo spooky");
			base.transform.localScale *= 1.4f;
		}
	}

	// Token: 0x060003AA RID: 938 RVA: 0x00012990 File Offset: 0x00010B90
	public void SetSpeed(float multiplier)
	{
		this.agent.speed = this.mobType.speed * multiplier;
	}

	// Token: 0x060003AB RID: 939 RVA: 0x000129AC File Offset: 0x00010BAC
	private void Awake()
	{
		this.hitable = base.GetComponent<Hitable>();
		this.agent = base.GetComponent<NavMeshAgent>();
		this.agent.speed = this.mobType.speed;
		this.animator = base.GetComponent<Animator>();
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

	// Token: 0x17000029 RID: 41
	// (get) Token: 0x060003AC RID: 940 RVA: 0x00012A86 File Offset: 0x00010C86
	// (set) Token: 0x060003AD RID: 941 RVA: 0x00012A8E File Offset: 0x00010C8E
	public float[] attackTimes { get; set; }

	// Token: 0x060003AE RID: 942 RVA: 0x00012A97 File Offset: 0x00010C97
	private void Update()
	{
		this.Animate();
		this.ExtraUpdate();
		this.FootSteps();
	}

	// Token: 0x060003AF RID: 943 RVA: 0x00012AAC File Offset: 0x00010CAC
	private void FootSteps()
	{
		if (!this.footstepFx)
		{
			return;
		}
		if (Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position) > 50f)
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
		Instantiate(this.footstepFx, base.transform.position, Quaternion.identity);
			this.distance = 0f;
		}
	}

	// Token: 0x060003B0 RID: 944 RVA: 0x0000276E File Offset: 0x0000096E
	public virtual void ExtraUpdate()
	{
	}

	// Token: 0x060003B1 RID: 945 RVA: 0x00012B74 File Offset: 0x00010D74
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
		base.Invoke("StopKnockback", 0.75f);
	}

	// Token: 0x060003B2 RID: 946 RVA: 0x00012C28 File Offset: 0x00010E28
	private void StopKnockback()
	{
		this.animator.SetBool("Knockback", false);
		this.knocked = false;
		this.agent.angularSpeed = this.oldAngularSpeed;
		this.agent.updateRotation = true;
	}

	// Token: 0x060003B3 RID: 947 RVA: 0x0000276E File Offset: 0x0000096E
	private void LateUpdate()
	{
	}

	// Token: 0x060003B4 RID: 948 RVA: 0x00012C5F File Offset: 0x00010E5F
	public bool IsAttacking()
	{
		return this.attacking;
	}

	// Token: 0x060003B5 RID: 949 RVA: 0x00012C68 File Offset: 0x00010E68
	public void Attack(int targetPlayerId, int attackAnimationIndex)
	{
		MonoBehaviour.print("attacking. stoponattack: " + this.stopOnAttack.ToString());
		if (this.stopOnAttack)
		{
			this.agent.isStopped = true;
			this.attacking = true;
		}
		MonoBehaviour.print("ataacking, cooldowntime: " + this.attackTimes[attackAnimationIndex]);
		base.Invoke("FinishAttacking", this.attackTimes[attackAnimationIndex]);
		this.animator.Play(this.attackAnimations[attackAnimationIndex].name);
		this.targetPlayerId = targetPlayerId;
	}

	// Token: 0x060003B6 RID: 950 RVA: 0x00012CF8 File Offset: 0x00010EF8
	private void FinishAttacking()
	{
		this.attacking = false;
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.agent.isStopped = false;
	}

	// Token: 0x060003B7 RID: 951 RVA: 0x00012D1C File Offset: 0x00010F1C
	private void Animate()
	{
		if (!this.animator)
		{
			return;
		}
		float value = this.agent.velocity.magnitude / this.agent.speed;
		this.animator.SetFloat("Speed", value);
	}

	// Token: 0x060003B8 RID: 952 RVA: 0x00012D68 File Offset: 0x00010F68
	public void SetDestination(Vector3 dest)
	{
		if (!this.agent.isOnNavMesh)
		{
			return;
		}
		this.agent.destination = dest;
		this.agent.isStopped = false;
	}

	// Token: 0x060003B9 RID: 953 RVA: 0x00012D90 File Offset: 0x00010F90
	public void SetPosition(Vector3 nextPosition)
	{
		Debug.DrawLine(base.transform.position, nextPosition, Color.red, 10f);
		base.transform.position = nextPosition;
	}

	// Token: 0x060003BA RID: 954 RVA: 0x00012DB9 File Offset: 0x00010FB9
	public void SetId(int id)
	{
		this.id = id;
		this.hitable.SetId(id);
	}

	// Token: 0x060003BB RID: 955 RVA: 0x00012DCE File Offset: 0x00010FCE
	public int GetId()
	{
		return this.id;
	}

	// Token: 0x04000346 RID: 838
	public MobType mobType;

	// Token: 0x04000349 RID: 841
	public float attackCooldown;

	// Token: 0x0400034A RID: 842
	public int id;

	// Token: 0x0400034D RID: 845
	public bool stopOnAttack;

	// Token: 0x04000351 RID: 849
	private bool attacking;

	// Token: 0x04000352 RID: 850
	public AnimationClip[] attackAnimations;

	// Token: 0x04000354 RID: 852
	public GameObject footstepFx;

	// Token: 0x04000355 RID: 853
	private float distance;

	// Token: 0x04000356 RID: 854
	public float footstepFrequency = 1f;

	// Token: 0x04000357 RID: 855
	public bool knocked;

	// Token: 0x04000358 RID: 856
	private float oldAccel;

	// Token: 0x04000359 RID: 857
	private float oldAngularSpeed;
}
