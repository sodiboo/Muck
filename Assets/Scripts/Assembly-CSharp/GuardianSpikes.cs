using System;
using UnityEngine;

public class GuardianSpikes : MonoBehaviour
{
	private void Awake()
	{
		this.indicator = Instantiate<GameObject>(this.warningFx, base.transform.position, this.warningFx.transform.rotation).GetComponent<EnemyAttackIndicator>();
		this.indicator.SetWarning(this.attack.bowComponent.timeToImpact, this.attack.bowComponent.attackSize);
		Invoke(nameof(SpawnAttack), this.attack.bowComponent.timeToImpact);
	}

	private void SpawnAttack()
	{
		HitboxDamage componentInChildren = Instantiate<GameObject>(this.spikeAttack, this.indicator.transform.position, this.spikeAttack.transform.rotation).GetComponentInChildren<HitboxDamage>();
		if (componentInChildren)
		{
			componentInChildren.baseDamage = this.projectile.damage;
		}
		Destroy(base.gameObject);
	}

	public GameObject warningFx;

	public GameObject spikeAttack;

	public InventoryItem attack;

	public EnemyProjectile projectile;

	private EnemyAttackIndicator indicator;
}
