using UnityEngine;

public class MobServerEnemyMeleeAndRanged : MobServerEnemy
{
    public float rangedCooldown = 6f;

    public bool readyForRangedAttack;

    private new void Start()
    {
        base.Start();
        Invoke("GetReadyForRangedAttack", Random.Range(rangedCooldown * 0.5f, rangedCooldown * 1.5f));
    }

    protected override void AttackBehaviour()
    {
        rangedCooldown = mob.mobType.rangedCooldown;
        float num = Vector3.Distance(mob.target.position, base.transform.position);
        bool flag = true;
        if (num <= mob.mobType.startAttackDistance && num >= mob.mobType.startRangedAttackDistance)
        {
            flag = Random.Range(0f, 1f) < 0.5f;
        }
        if (num <= mob.mobType.startAttackDistance && flag)
        {
            if (!(Mathf.Abs(Vector3.SignedAngle(base.transform.forward, VectorExtensions.XZVector(mob.target.position) - VectorExtensions.XZVector(base.transform.position), Vector3.up)) > mob.mobType.minAttackAngle))
            {
                int num2 = 0;
                if (mob.mobType.onlyRangedInRangedPattern)
                {
                    num2 = mob.nRangedAttacks;
                }
                int num3 = Random.Range(0, mob.attackAnimations.Length - num2);
                mob.Attack(mob.targetPlayerId, num3);
                ServerSend.MobAttack(mob.GetId(), mob.targetPlayerId, num3);
                serverReadyToAttack = false;
                Invoke("GetReady", mob.attackTimes[num3] + Random.Range(0f, mob.attackCooldown));
            }
        }
        else if (num <= mob.mobType.maxAttackDistance && readyForRangedAttack)
        {
            int num4 = Random.Range(0, mob.nRangedAttacks);
            int num5 = mob.attackAnimations.Length - 1 - num4;
            mob.Attack(mob.targetPlayerId, num5);
            ServerSend.MobAttack(mob.GetId(), mob.targetPlayerId, num5);
            serverReadyToAttack = false;
            Invoke("GetReady", mob.attackTimes[num5] + Random.Range(0f, mob.attackCooldown));
            readyForRangedAttack = false;
            Invoke("GetReadyForRangedAttack", Random.Range(rangedCooldown * 0.5f, rangedCooldown * 1.5f));
        }
    }

    private void GetReadyForRangedAttack()
    {
        readyForRangedAttack = true;
    }
}
