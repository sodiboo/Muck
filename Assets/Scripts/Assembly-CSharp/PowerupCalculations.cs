
using UnityEngine;

// Token: 0x02000086 RID: 134
public class PowerupCalculations : MonoBehaviour
{
	// Token: 0x06000388 RID: 904 RVA: 0x0001249E File Offset: 0x0001069E
	private void Awake()
	{
		PowerupCalculations.Instance = this;
	}

	// Token: 0x06000389 RID: 905 RVA: 0x000124A8 File Offset: 0x000106A8
	public PowerupCalculations.DamageResult GetDamageMultiplier(bool falling, float speedWhileShooting = -1f)
	{
		bool flag = Random.Range(0f, 1f) < PowerupInventory.Instance.GetCritChance(null);
		float num = Random.Range(PowerupCalculations.randomDamageRange.x, PowerupCalculations.randomDamageRange.y) * PowerupInventory.Instance.GetStrengthMultiplier(null);
		if (flag)
		{
			num *= 2f;
		}
		if (flag)
		{
			PowerupInventory.Instance.StartJuice();
		}
		float lifestealMultiplier = PowerupInventory.Instance.GetLifestealMultiplier(null);
		float sniperScopeMultiplier = PowerupInventory.Instance.GetSniperScopeMultiplier(null);
		bool sniped = false;
		num *= sniperScopeMultiplier;
		if (sniperScopeMultiplier > 1f)
		{
			sniped = true;
		}
		float lightningMultiplier = PowerupInventory.Instance.GetLightningMultiplier(null);
		float num2 = 1f;
		if (falling)
		{
			num2 = PowerupInventory.Instance.GetFallWingsMultiplier(null);
		}
		float enforcerMultiplier = PowerupInventory.Instance.GetEnforcerMultiplier(null, speedWhileShooting);
		num *= num2 * enforcerMultiplier;
		return new PowerupCalculations.DamageResult(num, flag, lifestealMultiplier, sniped, lightningMultiplier, num2 > 1f);
	}

	// Token: 0x0600038A RID: 906 RVA: 0x00012589 File Offset: 0x00010789
	public void HitEffect(AudioClip clip)
	{
		GameObject gameObject =Instantiate(this.hitFx);
		gameObject.AddComponent<DestroyObject>().time = 2f;
		AudioSource component = gameObject.GetComponent<AudioSource>();
		component.clip = clip;
		component.Play();
	}

	// Token: 0x0600038B RID: 907 RVA: 0x000125B8 File Offset: 0x000107B8
	public void SpawnOnHitEffect(int id, bool owner, Vector3 pos, int damage)
	{
		GameObject gameObject =Instantiate(this.onHitEffects[id], pos, this.onHitEffects[id].transform.rotation);
		if (owner)
		{
			gameObject.GetComponent<AreaEffect>().SetDamage(damage);
		}
	}

	// Token: 0x0600038C RID: 908 RVA: 0x000125F8 File Offset: 0x000107F8
	public PowerupCalculations.DamageResult GetMaxMultiplier()
	{
		bool flag = true;
		bool flag2 = true;
		float num = PowerupCalculations.randomDamageRange.y * PowerupInventory.Instance.GetStrengthMultiplier(null);
		if (flag2)
		{
			num *= 2f;
		}
		float lifestealMultiplier = PowerupInventory.Instance.GetLifestealMultiplier(null);
		float sniperScopeDamageMultiplier = PowerupInventory.Instance.GetSniperScopeDamageMultiplier(null);
		bool sniped = false;
		num *= sniperScopeDamageMultiplier;
		if (sniperScopeDamageMultiplier > 1f)
		{
			sniped = true;
		}
		float lightningMultiplier = PowerupInventory.Instance.GetLightningMultiplier(null);
		float num2 = 1f;
		if (flag)
		{
			num2 = PowerupInventory.Instance.GetFallWingsMultiplier(null);
		}
		num *= num2;
		return new PowerupCalculations.DamageResult(num, flag2, lifestealMultiplier, sniped, lightningMultiplier, num2 > 1f);
	}

	// Token: 0x0400033E RID: 830
	public GameObject[] onHitEffects;

	// Token: 0x0400033F RID: 831
	private static Vector2 randomDamageRange = new Vector2(0.4f, 1.2f);

	// Token: 0x04000340 RID: 832
	public GameObject hitFx;

	// Token: 0x04000341 RID: 833
	public AudioClip sniperSfx;

	// Token: 0x04000342 RID: 834
	public static PowerupCalculations Instance;

	// Token: 0x0200011E RID: 286
	public class DamageResult
	{
		// Token: 0x060007A9 RID: 1961 RVA: 0x000258D5 File Offset: 0x00023AD5
		public DamageResult(float damage, bool crit, float life, bool sniped, float hammerMultiplier, bool falling)
		{
			this.damageMultiplier = damage;
			this.crit = crit;
			this.lifesteal = life;
			this.sniped = sniped;
			this.hammerMultiplier = hammerMultiplier;
			this.falling = falling;
		}

		// Token: 0x04000784 RID: 1924
		public float damageMultiplier;

		// Token: 0x04000785 RID: 1925
		public bool crit;

		// Token: 0x04000786 RID: 1926
		public float lifesteal;

		// Token: 0x04000787 RID: 1927
		public bool sniped;

		// Token: 0x04000788 RID: 1928
		public float hammerMultiplier;

		// Token: 0x04000789 RID: 1929
		public bool falling;
	}
}
