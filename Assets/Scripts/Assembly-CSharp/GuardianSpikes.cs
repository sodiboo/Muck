using System;
using UnityEngine;

// Token: 0x02000048 RID: 72
public class GuardianSpikes : MonoBehaviour
{
	// Token: 0x060001A8 RID: 424 RVA: 0x0000A2B4 File Offset: 0x000084B4
	private void Awake()
	{
		this.indicator = Instantiate<GameObject>(this.warningFx, base.transform.position, this.warningFx.transform.rotation).GetComponent<EnemyAttackIndicator>();
		this.indicator.SetWarning(this.attack.bowComponent.timeToImpact, this.attack.bowComponent.attackSize);
		Invoke(nameof(SpawnAttack), this.attack.bowComponent.timeToImpact);
	}

	// Token: 0x060001A9 RID: 425 RVA: 0x0000A338 File Offset: 0x00008538
	private void SpawnAttack()
	{
		HitboxDamage componentInChildren = Instantiate<GameObject>(this.spikeAttack, this.indicator.transform.position, this.spikeAttack.transform.rotation).GetComponentInChildren<HitboxDamage>();
		if (componentInChildren)
		{
			componentInChildren.baseDamage = this.projectile.damage;
		}
		Destroy(base.gameObject);
	}

	// Token: 0x040001AA RID: 426
	public GameObject warningFx;

	// Token: 0x040001AB RID: 427
	public GameObject spikeAttack;

	// Token: 0x040001AC RID: 428
	public InventoryItem attack;

	// Token: 0x040001AD RID: 429
	public EnemyProjectile projectile;

	// Token: 0x040001AE RID: 430
	private EnemyAttackIndicator indicator;
}
