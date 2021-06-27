using UnityEngine;

// Token: 0x020000AC RID: 172
public class PowerupCalculations : MonoBehaviour
{
	// Token: 0x06000475 RID: 1141 RVA: 0x000172CE File Offset: 0x000154CE
	private void Awake()
	{
		PowerupCalculations.Instance = this;
	}

	// Token: 0x06000476 RID: 1142 RVA: 0x000172D8 File Offset: 0x000154D8
	public PowerupCalculations.DamageResult GetDamageMultiplier(bool falling, float speedWhileShooting = -1f)
	{
		bool flag = Random.Range(0f, 1f) < PowerupInventory.Instance.GetCritChance(null);
		float num = Random.Range(PowerupCalculations.randomDamageRange.x, PowerupCalculations.randomDamageRange.y) * PowerupInventory.Instance.GetStrengthMultiplier(null);
		if (flag)
		{
			num *= 2f;
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

	// Token: 0x06000477 RID: 1143 RVA: 0x000173AC File Offset: 0x000155AC
	public void HitEffect(AudioClip clip)
	{
		GameObject gameObject = Instantiate<GameObject>(this.hitFx);
		gameObject.AddComponent<DestroyObject>().time = 2f;
		AudioSource component = gameObject.GetComponent<AudioSource>();
		component.clip = clip;
		component.Play();
	}

	// Token: 0x06000478 RID: 1144 RVA: 0x000173DC File Offset: 0x000155DC
	public void SpawnOnHitEffect(int id, bool owner, Vector3 pos, int damage)
	{
		GameObject gameObject = Instantiate<GameObject>(this.onHitEffects[id], pos, this.onHitEffects[id].transform.rotation);
		if (owner)
		{
			gameObject.GetComponent<AreaEffect>().SetDamage(damage);
		}
	}

	// Token: 0x06000479 RID: 1145 RVA: 0x0001741C File Offset: 0x0001561C
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

	// Token: 0x0400043B RID: 1083
	public GameObject[] onHitEffects;

	// Token: 0x0400043C RID: 1084
	private static Vector2 randomDamageRange = new Vector2(0.4f, 1.2f);

	// Token: 0x0400043D RID: 1085
	public GameObject hitFx;

	// Token: 0x0400043E RID: 1086
	public AudioClip sniperSfx;

	// Token: 0x0400043F RID: 1087
	public static PowerupCalculations Instance;

	// Token: 0x02000158 RID: 344
	public class DamageResult
	{
		// Token: 0x060008FD RID: 2301 RVA: 0x0002C371 File Offset: 0x0002A571
		public DamageResult(float damage, bool crit, float life, bool sniped, float hammerMultiplier, bool falling)
		{
			this.damageMultiplier = damage;
			this.crit = crit;
			this.lifesteal = life;
			this.sniped = sniped;
			this.hammerMultiplier = hammerMultiplier;
			this.falling = falling;
		}

		// Token: 0x040008EF RID: 2287
		public float damageMultiplier;

		// Token: 0x040008F0 RID: 2288
		public bool crit;

		// Token: 0x040008F1 RID: 2289
		public float lifesteal;

		// Token: 0x040008F2 RID: 2290
		public bool sniped;

		// Token: 0x040008F3 RID: 2291
		public float hammerMultiplier;

		// Token: 0x040008F4 RID: 2292
		public bool falling;
	}
}
