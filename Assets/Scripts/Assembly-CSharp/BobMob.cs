using UnityEngine;

public class BobMob : Mob
{
    public enum DragonState
    {
        Flying,
        Landing,
        Grounded
    }

    private int landingNode;

    private float t;

    private float speed = 50f;

    public DragonState state { get; set; }

    public Vector3 desiredPos { get; set; }

    public ProjectileAttackNoGravity projectileController { get; set; }

    private void Awake()
    {
        projectileController = GetComponent<ProjectileAttackNoGravity>();
        state = DragonState.Flying;
        base.hitable = GetComponent<Hitable>();
        base.animator = GetComponent<Animator>();
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
            else if (mobType.behaviour == MobType.MobBehaviour.Dragon)
            {
                base.gameObject.AddComponent<MobServerDragon>();
            }
        }
        base.attackTimes = new float[attackAnimations.Length];
        for (int i = 0; i < attackAnimations.Length; i++)
        {
            base.attackTimes[i] = attackAnimations[i].length;
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
        landingNode = 0;
        state = DragonState.Landing;
    }

    public void GroundedToFlight()
    {
        state = DragonState.Flying;
        base.animator.SetBool("Landed", value: false);
    }

    public void DragonUpdate(DragonState state)
    {
        switch (state)
        {
        case DragonState.Landing:
            StartLanding();
            break;
        case DragonState.Flying:
            GroundedToFlight();
            break;
        }
    }

    public override void ExtraUpdate()
    {
        switch (state)
        {
        case DragonState.Flying:
            base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.LookRotation((desiredPos - base.transform.position).normalized), Time.deltaTime * 0.6f);
            base.transform.position += base.transform.forward * speed * Time.deltaTime;
            break;
        case DragonState.Landing:
            if (landingNode < 2)
            {
                Vector3 position = Boat.Instance.landingNodes[landingNode].position;
                base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.LookRotation((position - base.transform.position).normalized), Time.deltaTime * 6f);
                base.transform.position += base.transform.forward * speed * 1.3f * Time.deltaTime;
                if (Vector3.Distance(base.transform.position, position) < 10f)
                {
                    landingNode++;
                }
                if (landingNode > 1)
                {
                    state = DragonState.Grounded;
                    CameraShaker.Instance.StepShake(1f);
                }
            }
            break;
        case DragonState.Grounded:
            base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.LookRotation(Boat.Instance.dragonLandingPosition.forward.normalized), Time.deltaTime * 2f);
            base.transform.position = Vector3.Lerp(base.transform.position, desiredPos, Time.deltaTime * 2f);
            base.animator.SetBool("Landed", value: true);
            break;
        }
    }

    private void LateUpdate()
    {
    }

    public override void Attack(int targetPlayerId, int attackAnimationIndex)
    {
        Invoke(nameof(FinishAttacking), base.attackTimes[attackAnimationIndex]);
        base.animator.Play(attackAnimations[attackAnimationIndex].name);
        base.targetPlayerId = targetPlayerId;
    }

    protected override void FinishAttacking()
    {
    }

    public override void SetDestination(Vector3 dest)
    {
        desiredPos = dest;
    }
}
