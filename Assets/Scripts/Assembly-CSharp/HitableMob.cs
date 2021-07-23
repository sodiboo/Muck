using UnityEngine;

public class HitableMob : Hitable
{
    public MobServer mobServer;

    public float maxFractionHit;

    public Mob mob { get; set; }

    private void Start()
    {
        mob = GetComponent<Mob>();
        mobServer = GetComponent<MobServer>();
        maxHp = (int)((float)maxHp * GameManager.instance.MobHpMultiplier() * mob.multiplier * mob.bossMultiplier);
        hp = maxHp;
    }

    public override void Hit(int damage, float sharpness, int hitEffect, Vector3 hitPos, int hitWeaponType = 0)
    {
        if (maxFractionHit > 0f)
        {
            int num = (int)(maxFractionHit * (float)maxHp);
            if (damage > num)
            {
                Debug.LogError("reducing damage from: " + damage + ", to: " + num);
                damage = num;
            }
        }
        ClientSend.PlayerDamageMob(id, damage, sharpness, hitEffect, hitPos, hitWeaponType);
    }

    public override void OnKill(Vector3 dir)
    {
        TestRagdoll component = GetComponent<TestRagdoll>();
        if ((bool)component)
        {
            component.MakeRagdoll(dir);
        }
        MobManager.Instance.RemoveMob(id);
        Object.Destroy(base.gameObject);
        if (mob.mobType.boss && base.localHit)
        {
            AchievementManager.Instance.AddKill(PlayerStatus.WeaponHitType.Melee, mob);
        }
    }

    protected override void ExecuteHit()
    {
        if (LocalClient.serverOwner)
        {
            mobServer.TookDamage();
        }
    }
}
