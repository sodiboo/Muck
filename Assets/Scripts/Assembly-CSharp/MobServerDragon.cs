using System.Collections.Generic;
using UnityEngine;

public class MobServerDragon : MobServer
{
    private List<Vector3> nodes;

    private bool serverReadyToAttack = true;

    private BobMob.DragonState previousState;

    private int hpOnLanding;

    private int startFlightHp;

    private int nAttacksBeforeFlight;

    private int currentAttacks;

    private float fireballCooldown = 2.25f;

    private int minFlyingNodes = 6;

    private int maxFlyingNodes = 40;

    private int currentNodes;

    private int damageTakenThisLanding;

    private void Start()
    {
        StartRoutines();
        nodes = new List<Vector3>();
        serverReadyToAttack = false;
        Invoke(nameof(GetReady), 4f);
    }

    protected override void Behaviour()
    {
        TryAttack();
    }

    private void TryAttack()
    {
        if (serverReadyToAttack)
        {
            switch (((BobMob)mob).state)
            {
            case BobMob.DragonState.Flying:
                FlyingBehaviour();
                break;
            case BobMob.DragonState.Grounded:
                GroundedBehaviour();
                break;
            }
            previousState = ((BobMob)mob).state;
            if ((bool)mob.target && !mob.IsAttacking() && serverReadyToAttack && mob.targetPlayerId != -1 && GameManager.players[mob.targetPlayerId].dead)
            {
                mob.target = null;
            }
        }
    }

    private void FlyingBehaviour()
    {
        if (!(Vector3.Angle((VectorExtensions.XZVector(Boat.Instance.transform.position) - VectorExtensions.XZVector(base.transform.position)).normalized, mob.transform.forward) > 80f))
        {
            PlayerManager randomAlivePlayer = GetRandomAlivePlayer();
            if (!(randomAlivePlayer == null))
            {
                mob.target = randomAlivePlayer.transform;
                float num = fireballCooldown;
                float num2 = (float)mob.hitable.hp / (float)mob.hitable.maxHp;
                num -= 1f - num2;
                serverReadyToAttack = false;
                Invoke(nameof(GetReady), num);
                ((BobMob)mob).projectileController.SpawnProjectilePredictNextPosition();
            }
        }
    }

    private PlayerManager GetRandomAlivePlayer()
    {
        List<PlayerManager> list = new List<PlayerManager>();
        foreach (PlayerManager value in GameManager.players.Values)
        {
            if ((bool)value && !value.dead && !value.disconnected)
            {
                list.Add(value);
            }
        }
        if (list.Count == 0)
        {
            return null;
        }
        return list[Random.Range(0, list.Count)];
    }

    private void GroundedToFlight()
    {
        ((BobMob)mob).GroundedToFlight();
        currentNodes = 0;
        serverReadyToAttack = false;
        Invoke(nameof(GetReady), 4f);
        SyncFindNextPosition();
        ServerSend.DragonUpdate(0);
    }

    private Vector3 FlyingToGrounded()
    {
        hpOnLanding = mob.hitable.hp;
        int num = (int)((float)mob.hitable.maxHp * 0.33f);
        startFlightHp = hpOnLanding - num;
        Debug.LogError("flight hp: " + startFlightHp);
        currentAttacks = 0;
        nAttacksBeforeFlight = Random.Range(6, 12);
        ((BobMob)mob).StartLanding();
        ServerSend.DragonUpdate(1);
        return Boat.Instance.dragonLandingPosition.position;
    }

    private void GroundedBehaviour()
    {
        if (mob.hitable.hp < startFlightHp)
        {
            GroundedToFlight();
            Debug.LogError("Forcing flight since 30% taken");
            return;
        }
        if (currentAttacks >= nAttacksBeforeFlight)
        {
            GroundedToFlight();
            return;
        }
        if (previousState != BobMob.DragonState.Grounded)
        {
            serverReadyToAttack = false;
            Invoke(nameof(GetReady), Random.Range(3.5f, 4.5f));
            currentAttacks = 0;
            return;
        }
        int id = GetRandomAlivePlayer().id;
        mob.SetTarget(id);
        int num = Random.Range(0, mob.attackAnimations.Length);
        mob.Attack(mob.targetPlayerId, num);
        ServerSend.MobAttack(mob.GetId(), mob.targetPlayerId, num);
        serverReadyToAttack = false;
        Invoke(nameof(GetReady), mob.attackTimes[num] + Random.Range(0f, mob.attackCooldown));
        currentAttacks++;
    }

    private void GetReady()
    {
        serverReadyToAttack = true;
    }

    public override void TookDamage()
    {
    }

    private void FindNodes()
    {
        Vector3 vector = Boat.Instance.rbTransform.position + Vector3.up * 90f;
        ConsistentRandom consistentRandom = new ConsistentRandom();
        int num = 6;
        for (int i = 0; i < num; i++)
        {
            Vector3 vector2 = Vector3.right * (float)(consistentRandom.NextDouble() * 2.0 - 1.0) * 130f;
            Vector3 vector3 = Vector3.forward * (float)(consistentRandom.NextDouble() * 2.0 - 1.0) * 130f;
            Vector3 vector4 = Vector3.up * (float)(consistentRandom.NextDouble() * 2.0 - 1.0) * 40f;
            Vector3 item = vector + vector2 + vector3 + vector4;
            nodes.Add(item);
        }
    }

    private void OnDrawGizmos()
    {
        foreach (Vector3 node in nodes)
        {
            Gizmos.color = Color.red;
            Gizmos.DrawSphere(node, 10f);
        }
    }

    protected override Vector3 FindNextPosition()
    {
        CancelInvoke(nameof(SyncFindNextPosition));
        Invoke(nameof(SyncFindNextPosition), findPositionInterval[1]);
        if (nodes.Count < 1)
        {
            FindNodes();
        }
        switch (((BobMob)mob).state)
        {
        case BobMob.DragonState.Flying:
        {
            if ((currentNodes > minFlyingNodes && Random.Range(0f, 1f) < 0.09f) || currentNodes > maxFlyingNodes)
            {
                return FlyingToGrounded();
            }
            currentNodes++;
            Vector3 vector = ((BobMob)mob).desiredPos;
            int num = 0;
            while (vector == ((BobMob)mob).desiredPos)
            {
                vector = nodes[Random.Range(0, nodes.Count)];
                num++;
                if (num > 100)
                {
                    break;
                }
            }
            return vector;
        }
        default:
            return Vector3.zero;
        }
    }
}
