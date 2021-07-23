using UnityEngine;

public class PowerupCalculations : MonoBehaviour
{
    public class DamageResult
    {
        public float damageMultiplier;

        public bool crit;

        public float lifesteal;

        public bool sniped;

        public float hammerMultiplier;

        public bool falling;

        public DamageResult(float damage, bool crit, float life, bool sniped, float hammerMultiplier, bool falling)
        {
            damageMultiplier = damage;
            this.crit = crit;
            lifesteal = life;
            this.sniped = sniped;
            this.hammerMultiplier = hammerMultiplier;
            this.falling = falling;
        }
    }

    public GameObject[] onHitEffects;

    private static Vector2 randomDamageRange = new Vector2(0.4f, 1.2f);

    public GameObject hitFx;

    public AudioClip sniperSfx;

    public static PowerupCalculations Instance;

    private void Awake()
    {
        Instance = this;
    }

    public DamageResult GetDamageMultiplier(bool falling, float speedWhileShooting = -1f)
    {
        bool flag = Random.Range(0f, 1f) < PowerupInventory.Instance.GetCritChance();
        float num = Random.Range(randomDamageRange.x, randomDamageRange.y) * PowerupInventory.Instance.GetStrengthMultiplier(null);
        if (flag)
        {
            num *= 2f;
        }
        float lifestealMultiplier = PowerupInventory.Instance.GetLifestealMultiplier();
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
            num2 = PowerupInventory.Instance.GetFallWingsMultiplier();
        }
        float enforcerMultiplier = PowerupInventory.Instance.GetEnforcerMultiplier(null, speedWhileShooting);
        num *= num2 * enforcerMultiplier;
        return new DamageResult(num, flag, lifestealMultiplier, sniped, lightningMultiplier, num2 > 1f);
    }

    public void HitEffect(AudioClip clip)
    {
        GameObject obj = Object.Instantiate(hitFx);
        obj.AddComponent<DestroyObject>().time = 2f;
        AudioSource component = obj.GetComponent<AudioSource>();
        component.clip = clip;
        component.Play();
    }

    public void SpawnOnHitEffect(int id, bool owner, Vector3 pos, int damage)
    {
        GameObject gameObject = Object.Instantiate(onHitEffects[id], pos, onHitEffects[id].transform.rotation);
        if (owner)
        {
            gameObject.GetComponent<AreaEffect>().SetDamage(damage);
        }
    }

    public DamageResult GetMaxMultiplier()
    {
        bool flag = true;
        float num = randomDamageRange.y * PowerupInventory.Instance.GetStrengthMultiplier(null);
        if (flag)
        {
            num *= 2f;
        }
        float lifestealMultiplier = PowerupInventory.Instance.GetLifestealMultiplier();
        float sniperScopeDamageMultiplier = PowerupInventory.Instance.GetSniperScopeDamageMultiplier(null);
        bool sniped = false;
        num *= sniperScopeDamageMultiplier;
        if (sniperScopeDamageMultiplier > 1f)
        {
            sniped = true;
        }
        float lightningMultiplier = PowerupInventory.Instance.GetLightningMultiplier(null);
        float num2 = 1f;
        if (true)
        {
            num2 = PowerupInventory.Instance.GetFallWingsMultiplier();
        }
        num *= num2;
        return new DamageResult(num, flag, lifestealMultiplier, sniped, lightningMultiplier, num2 > 1f);
    }
}
