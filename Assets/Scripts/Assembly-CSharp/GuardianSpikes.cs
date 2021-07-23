using UnityEngine;

public class GuardianSpikes : MonoBehaviour
{
    public GameObject warningFx;

    public GameObject spikeAttack;

    public InventoryItem attack;

    public EnemyProjectile projectile;

    private EnemyAttackIndicator indicator;

    private void Awake()
    {
        indicator = Object.Instantiate(warningFx, base.transform.position, warningFx.transform.rotation).GetComponent<EnemyAttackIndicator>();
        indicator.SetWarning(attack.bowComponent.timeToImpact, attack.bowComponent.attackSize);
        Invoke("SpawnAttack", attack.bowComponent.timeToImpact);
    }

    private void SpawnAttack()
    {
        HitboxDamage componentInChildren = Object.Instantiate(spikeAttack, indicator.transform.position, spikeAttack.transform.rotation).GetComponentInChildren<HitboxDamage>();
        if ((bool)componentInChildren)
        {
            componentInChildren.baseDamage = projectile.damage;
        }
        Object.Destroy(base.gameObject);
    }
}
