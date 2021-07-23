using UnityEngine;

public class MobServerEnemy : MobServer
{
    public LayerMask groundMask;

    protected bool serverReadyToAttack = true;

    protected void Start()
    {
        StartRoutines();
        groundMask = 1 << LayerMask.NameToLayer("Ground");
    }

    protected override void Behaviour()
    {
        TryAttack();
    }

    public override void TookDamage()
    {
    }

    private void TryAttack()
    {
        if ((bool)mob.target && !mob.IsAttacking() && serverReadyToAttack)
        {
            if (mob.targetPlayerId != -1 && GameManager.players[mob.targetPlayerId].dead)
            {
                mob.target = null;
            }
            else
            {
                AttackBehaviour();
            }
        }
    }

    protected virtual void AttackBehaviour()
    {
        if (Vector3.Distance(mob.target.position, base.transform.position) <= mob.mobType.startAttackDistance && !(Mathf.Abs(Vector3.SignedAngle(base.transform.forward, VectorExtensions.XZVector(mob.target.position) - VectorExtensions.XZVector(base.transform.position), Vector3.up)) > mob.mobType.minAttackAngle))
        {
            int num = Random.Range(0, mob.attackAnimations.Length);
            mob.Attack(mob.targetPlayerId, num);
            ServerSend.MobAttack(mob.GetId(), mob.targetPlayerId, num);
            serverReadyToAttack = false;
            Invoke("GetReady", mob.attackTimes[num] + Random.Range(0f, mob.attackCooldown));
        }
    }

    protected void GetReady()
    {
        serverReadyToAttack = true;
    }

    protected override Vector3 FindNextPosition()
    {
        float num = 15f * mob.mobType.followPlayerDistance;
        if (mob.target != null)
        {
            num = Vector3.Distance(mob.transform.position, mob.target.transform.position);
        }
        if (num < 10f * mob.mobType.followPlayerDistance)
        {
            Invoke("SyncFindNextPosition", findPositionInterval[0]);
        }
        else if (num < 25f * mob.mobType.followPlayerDistance)
        {
            Invoke("SyncFindNextPosition", findPositionInterval[1]);
        }
        else
        {
            Invoke("SyncFindNextPosition", findPositionInterval[2]);
        }
        if ((mob.IsAttacking() && mob.stopOnAttack) || mob.knocked || !mob.ready)
        {
            return Vector3.zero;
        }
        Vector3 vector = Vector3.zero;
        Transform transform = null;
        int targetPlayerId = -1;
        float num2 = float.PositiveInfinity;
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if (!value || value.dead)
            {
                continue;
            }
            float num3 = Vector3.Distance(value.transform.position, base.transform.position);
            if (num3 < num2)
            {
                num2 = num3;
                Vector3 position = value.transform.position;
                Vector3 vector2 = Vector3.zero;
                if (num3 > 12f)
                {
                    vector2 = new Vector3(Random.Range(-1f, 1f), 0f, Random.Range(-1f, 1f));
                    vector2 *= num3 * (1f - mob.mobType.followPlayerAccuracy);
                }
                vector = position + vector2;
                transform = value.transform;
                targetPlayerId = value.id;
            }
        }
        foreach (PlayerManager value2 in GameManager.players.Values)
        {
            if (!value2 || value2.dead)
            {
                continue;
            }
            float num4 = Vector3.Distance(value2.transform.position, base.transform.position);
            if (num4 < num2)
            {
                num2 = num4;
                Vector3 position2 = value2.transform.position;
                Vector3 vector3 = Vector3.zero;
                if (num4 > 12f)
                {
                    vector3 = new Vector3(Random.Range(-1f, 1f), 0f, Random.Range(-1f, 1f));
                    vector3 *= num4 * (1f - mob.mobType.followPlayerAccuracy);
                }
                vector = position2 + vector3;
                transform = value2.transform;
                targetPlayerId = value2.id;
            }
        }
        bool flag = false;
        foreach (PlayerManager value3 in GameManager.players.Values)
        {
            if ((bool)value3 && !value3.dead)
            {
                Vector3 normalized = (value3.transform.position - mob.transform.position).normalized;
                if (Physics.Raycast(mob.transform.position, normalized, out var hitInfo, 2000f, MobManager.Instance.whatIsRaycastable) && hitInfo.transform.gameObject.layer == LayerMask.NameToLayer("Player"))
                {
                    flag = true;
                    break;
                }
            }
        }
        if (!flag && !mob.mobType.ignoreBuilds)
        {
            foreach (GameObject value4 in ResourceManager.Instance.builds.Values)
            {
                if (!(value4 == null) && Vector3.Distance(base.transform.position, value4.transform.position) < num2)
                {
                    vector = value4.transform.position;
                    transform = value4.transform;
                    targetPlayerId = -1;
                    break;
                }
            }
        }
        if (!transform)
        {
            return Vector3.zero;
        }
        Vector3.Distance(mob.agent.destination, transform.position);
        Vector3.Distance(transform.position, mob.transform.position);
        if (vector == Vector3.zero)
        {
            mob.target = null;
            return Vector3.zero;
        }
        mob.target = transform;
        mob.targetPlayerId = targetPlayerId;
        return vector;
    }
}
