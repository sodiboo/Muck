using System;
using UnityEngine;

public class WoodmanBehaviour : MonoBehaviour
{
    public enum WoodmanType
    {
        None,
        Archer,
        Smith,
        Woodcutter,
        Chef,
        Wildcard
    }

    private Mob mob;

    private Vector3 headOffset;

    public int mobZoneId;

    private MobServerNeutral neutral;

    private Hitable hitable;

    public GameObject interactObject;

    private bool aggressive;

    private void Awake()
    {
        interactObject = GetComponent<hahahayes>().interact;
    }

    private void Start()
    {
        mob = GetComponent<Mob>();
        if (LocalClient.serverOwner)
        {
            UnityEngine.Object.Destroy(base.gameObject.GetComponent<MobServer>());
            GetComponent<MobServer>().enabled = false;
            neutral = base.gameObject.AddComponent<MobServerNeutral>();
            neutral.mobZoneId = mobZoneId;
        }
        hitable = GetComponent<Hitable>();
        InvokeRepeating(nameof(SlowUpdate), 0.25f, 0.25f);
        AssignRole(new ConsistentRandom(GameManager.GetSeed() + hitable.GetId()));
        mob.agent.speed /= 2f;
    }

    private void AssignRoles()
    {
        MobZoneManager.Instance.zones[mobZoneId].GetComponent<GenerateCamp>().AssignRoles();
    }

    public void AssignRole(ConsistentRandom rand)
    {
        hahahayes component = base.transform.root.GetComponent<hahahayes>();
        component.SkinColor(rand);
        if (!(rand.NextDouble() < 0.4))
        {
            WoodmanType type = (WoodmanType)rand.Next(1, Enum.GetValues(typeof(WoodmanType)).Length);
            TraderInteract traderInteract = interactObject.AddComponent<TraderInteract>();
            int nextId = ResourceManager.Instance.GetNextId();
            traderInteract.SetId(nextId);
            ResourceManager.Instance.AddObject(nextId, traderInteract.gameObject);
            traderInteract.SetType(type, rand);
            component.SetType(type);
            component.Randomize(rand);
            UnityEngine.Object.Destroy(neutral);
        }
    }

    private void SlowUpdate()
    {
        if (hitable.hp < hitable.maxHp)
        {
            MakeAggressive(first: true);
        }
    }

    public void MakeAggressive(bool first)
    {
        if (aggressive)
        {
            return;
        }
        aggressive = true;
        mob.ready = true;
        try
        {
            UnityEngine.Object.Destroy(neutral);
        }
        catch (Exception)
        {
        }
        if (mob.mobType.behaviour == MobType.MobBehaviour.Enemy)
        {
            base.gameObject.AddComponent<MobServerEnemy>();
        }
        else
        {
            base.gameObject.AddComponent<MobServerEnemyMeleeAndRanged>();
        }
        if (first)
        {
            foreach (GameObject entity in MobZoneManager.Instance.zones[mobZoneId].entities)
            {
                entity.GetComponent<WoodmanBehaviour>().MakeAggressive(first: false);
            }
        }
        mob.agent.speed = mob.mobType.speed;
        UnityEngine.Object.Destroy(this);
        UnityEngine.Object.Destroy(interactObject);
    }
}
