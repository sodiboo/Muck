using UnityEngine;

// Token: 0x020000A6 RID: 166
public class PowerupCalculations : MonoBehaviour
{
	// Token: 0x060003D5 RID: 981 RVA: 0x00004AFE File Offset: 0x00002CFE
	private void Awake()
	{
		PowerupCalculations.Instance = this;
	}

	// Token: 0x060003D6 RID: 982 RVA: 0x000160DC File Offset: 0x000142DC
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

	// Token: 0x060003D7 RID: 983 RVA: 0x00004B06 File Offset: 0x00002D06
	public void HitEffect(AudioClip clip)
	{
		GameObject gameObject =Instantiate<GameObject>(this.hitFx);
		gameObject.AddComponent<DestroyObject>().time = 2f;
		AudioSource component = gameObject.GetComponent<AudioSource>();
		component.clip = clip;
		component.Play();
	}

	// Token: 0x060003D8 RID: 984 RVA: 0x000161B0 File Offset: 0x000143B0
	public void SpawnOnHitEffect(int id, bool owner, Vector3 pos, int damage)
	{
		GameObject gameObject =Instantiate<GameObject>(this.onHitEffects[id], pos, this.onHitEffects[id].transform.rotation);
		if (owner)
		{
			gameObject.GetComponent<AreaEffect>().SetDamage(damage);
		}
	}

	// Token: 0x060003D9 RID: 985 RVA: 0x000161F0 File Offset: 0x000143F0
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

	// Token: 0x040003D2 RID: 978
	public GameObject[] onHitEffects;

	// Token: 0x040003D3 RID: 979
	private static Vector2 randomDamageRange = new Vector2(0.4f, 1.2f);

	// Token: 0x040003D4 RID: 980
	public GameObject hitFx;

	// Token: 0x040003D5 RID: 981
	public AudioClip sniperSfx;

	// Token: 0x040003D6 RID: 982
	public static PowerupCalculations Instance;

	// Token: 0x020000A7 RID: 167
	public class DamageResult
	{
		// Token: 0x060003DC RID: 988 RVA: 0x00004B4A File Offset: 0x00002D4A
		public DamageResult(float damage, bool crit, float life, bool sniped, float hammerMultiplier, bool falling)
		{
			this.damageMultiplier = damage;
			this.crit = crit;
			this.lifesteal = life;
			this.sniped = sniped;
			this.hammerMultiplier = hammerMultiplier;
			this.falling = falling;
		}

		// Token: 0x040003D7 RID: 983
		public float damageMultiplier;

		// Token: 0x040003D8 RID: 984
		public bool crit;

		// Token: 0x040003D9 RID: 985
		public float lifesteal;

		// Token: 0x040003DA RID: 986
		public bool sniped;

		// Token: 0x040003DB RID: 987
		public float hammerMultiplier;

		// Token: 0x040003DC RID: 988
		public bool falling;
	}
}
