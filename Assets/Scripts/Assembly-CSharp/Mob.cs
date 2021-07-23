using UnityEngine;
using UnityEngine.AI;

public class Mob : MonoBehaviour, SharedObject
{
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

    public MobType mobType;

    public float attackCooldown;

    public int id;

    public bool stopOnAttack;

    private bool attacking;

    public BossType bossType;

    public bool countedKill;

    public AnimationClip[] attackAnimations;

    public GameObject footstepFx;

    private float distance;

    public float footstepFrequency = 1f;

    public bool knocked;

    private float defaulAngularSpeed;

    private float oldAccel;

    private float oldAngularSpeed;

    public int nRangedAttacks;

    private AttackType currentAttackType;

    private Vector3 offsetPosition;

    private Vector3 offsetDir;

    private float syncSpeed = 5f;

    public Transform target { get; set; }

    public int targetPlayerId { get; set; }

    public bool ready { get; set; } = true;


    public float multiplier { get; set; } = 1f;


    public float bossMultiplier { get; set; } = 1f;


    public Animator animator { get; protected set; }

    public NavMeshAgent agent { get; private set; }

    public Hitable hitable { get; protected set; }

    public float[] attackTimes { get; set; }

    private void TestSpawn()
    {
        id = MobManager.Instance.GetNextId();
        MobManager.Instance.AddMob(this, id);
    }

    public bool IsBuff()
    {
        return multiplier > 1f;
    }

    private void Start()
    {
        if (IsBuff())
        {
            base.transform.localScale *= 1.4f;
        }
    }

    public void SetSpeed(float multiplier)
    {
        agent.speed = mobType.speed * multiplier;
    }

    private void Awake()
    {
        hitable = GetComponent<Hitable>();
        agent = GetComponent<NavMeshAgent>();
        agent.speed = mobType.speed;
        animator = GetComponent<Animator>();
        defaulAngularSpeed = agent.angularSpeed;
        if (LocalClient.serverOwner)
        {
            if (mobType.behaviour == MobType.MobBehaviour.Enemy)
            {
                base.gameObject.AddComponent<MobServerEnemy>();
            }
            else if (mobType.behaviour == MobType.MobBehaviour.Neutral)
            {
                base.gameObject.AddComponent<MobServerNeutral>();
            }
            else if (mobType.behaviour == MobType.MobBehaviour.EnemyMeleeAndRanged)
            {
                base.gameObject.AddComponent<MobServerEnemyMeleeAndRanged>();
            }
        }
        attackTimes = new float[attackAnimations.Length];
        for (int i = 0; i < attackAnimations.Length; i++)
        {
            attackTimes[i] = attackAnimations[i].length;
        }
    }

    private void Update()
    {
        Animate();
        ExtraUpdate();
        FootSteps();
        UpdateOffsetPosition();
    }

    private void FootSteps()
    {
        if ((bool)footstepFx && !(Vector3.Distance(PlayerMovement.Instance.playerCam.transform.position, base.transform.position) > 50f))
        {
            float num = agent.velocity.magnitude * 3f;
            if (num > 20f)
            {
                num = 20f;
            }
            distance += num * Time.deltaTime * 50f * footstepFrequency;
            if (distance > 300f / footstepFrequency)
            {
                Object.Instantiate(footstepFx, base.transform.position, Quaternion.identity);
                distance = 0f;
            }
        }
    }

    public virtual void ExtraUpdate()
    {
    }

    public void Knockback(Vector3 dir)
    {
        CancelInvoke("StopKnockback");
        oldAngularSpeed = agent.angularSpeed;
        agent.destination = base.transform.position + dir * 6f;
        animator.SetBool("Knockback", value: true);
        knocked = true;
        agent.velocity += dir * 10f;
        agent.angularSpeed = 0f;
        agent.updateRotation = false;
        Invoke("StopKnockback", 0.75f);
    }

    private void StopKnockback()
    {
        animator.SetBool("Knockback", value: false);
        agent.velocity = Vector3.zero;
        knocked = false;
        agent.angularSpeed = defaulAngularSpeed;
        agent.updateRotation = true;
    }

    private void LateUpdate()
    {
        if ((bool)target)
        {
            float num = Vector3.Distance(base.transform.position, target.position);
            if (!attacking && num < agent.stoppingDistance)
            {
                Quaternion b = Quaternion.LookRotation(VectorExtensions.XZVector(target.transform.position - base.transform.position));
                base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6f);
            }
        }
    }

    public bool IsAttacking()
    {
        return attacking;
    }

    public bool IsRangedAttacking()
    {
        return currentAttackType == AttackType.Ranged;
    }

    public virtual void Attack(int targetPlayerId, int attackAnimationIndex)
    {
        MonoBehaviour.print("attacking. stoponattack: " + stopOnAttack);
        if (stopOnAttack)
        {
            agent.isStopped = true;
            attacking = true;
        }
        if (attackAnimationIndex >= attackAnimations.Length - nRangedAttacks)
        {
            currentAttackType = AttackType.Ranged;
        }
        else
        {
            currentAttackType = AttackType.Melee;
        }
        Invoke("FinishAttacking", attackTimes[attackAnimationIndex]);
        animator.Play(attackAnimations[attackAnimationIndex].name);
        this.targetPlayerId = targetPlayerId;
    }

    protected virtual void FinishAttacking()
    {
        attacking = false;
        currentAttackType = AttackType.Melee;
        if (agent.isOnNavMesh)
        {
            agent.isStopped = false;
        }
    }

    protected virtual void Animate()
    {
        if ((bool)animator)
        {
            float value = agent.velocity.magnitude / agent.speed;
            animator.SetFloat("Speed", value);
        }
    }

    public virtual void SetDestination(Vector3 dest)
    {
        if (agent.isOnNavMesh)
        {
            agent.destination = dest;
            agent.isStopped = false;
        }
    }

    public virtual void SetTarget(int targetId)
    {
        if (agent.isOnNavMesh)
        {
            targetPlayerId = targetId;
            target = GameManager.players[targetPlayerId].transform;
        }
    }

    public void SetPosition(Vector3 nextPosition)
    {
        Debug.DrawLine(base.transform.position, nextPosition, Color.red, 10f);
        offsetPosition = nextPosition - base.transform.position;
        offsetDir = offsetPosition.normalized;
    }

    private void UpdateOffsetPosition()
    {
        if (!(offsetPosition.x <= 0f))
        {
            Vector3 vector = offsetDir * syncSpeed * Time.deltaTime;
            offsetPosition -= vector;
            if (offsetPosition.x < 0f)
            {
                vector -= offsetPosition;
            }
            base.transform.position += vector;
        }
    }

    public void SetId(int id)
    {
        this.id = id;
        hitable.SetId(id);
    }

    public int GetId()
    {
        return id;
    }
}
