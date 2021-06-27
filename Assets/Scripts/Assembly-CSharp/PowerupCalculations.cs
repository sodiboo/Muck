using UnityEngine;

public class PowerupCalculations : MonoBehaviour
{
	private void Awake()
	{
		PowerupCalculations.Instance = this;
	}

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

	public void HitEffect(AudioClip clip)
	{
		GameObject gameObject = Instantiate<GameObject>(this.hitFx);
		gameObject.AddComponent<DestroyObject>().time = 2f;
		AudioSource component = gameObject.GetComponent<AudioSource>();
		component.clip = clip;
		component.Play();
	}

	public void SpawnOnHitEffect(int id, bool owner, Vector3 pos, int damage)
	{
		GameObject gameObject = Instantiate<GameObject>(this.onHitEffects[id], pos, this.onHitEffects[id].transform.rotation);
		if (owner)
		{
			gameObject.GetComponent<AreaEffect>().SetDamage(damage);
		}
	}

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

	public GameObject[] onHitEffects;

	private static Vector2 randomDamageRange = new Vector2(0.4f, 1.2f);

	public GameObject hitFx;

	public AudioClip sniperSfx;

	public static PowerupCalculations Instance;

	public class DamageResult
	{
		public DamageResult(float damage, bool crit, float life, bool sniped, float hammerMultiplier, bool falling)
		{
			this.damageMultiplier = damage;
			this.crit = crit;
			this.lifesteal = life;
			this.sniped = sniped;
			this.hammerMultiplier = hammerMultiplier;
			this.falling = falling;
		}

		public float damageMultiplier;

		public bool crit;

		public float lifesteal;

		public bool sniped;

		public float hammerMultiplier;

		public bool falling;
	}
}
