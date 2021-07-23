using UnityEngine;

public class HitableResource : Hitable
{
    public InventoryItem.ItemType compatibleItem;

    public int minTier;

    [Header("Loot")]
    public InventoryItem dropItem;

    public InventoryItem[] dropExtra;

    public float[] dropChance;

    public int amount;

    public bool dontScale;

    private Texture materialText;

    public int poolId;

    private Vector3 defaultScale;

    private float scaleMultiplier;

    private Vector3 desiredScale;

    private Vector3 currentScale;

    protected void Start()
    {
        Material material = GetComponentInChildren<Renderer>().materials[0];
        materialText = material.mainTexture;
    }

    public override void Hit(int damage, float sharpness, int hitEffect, Vector3 pos, int hitWeaponType)
    {
        if (damage > 0)
        {
            ClientSend.PlayerHitObject(damage, id, hitEffect, pos, hitWeaponType);
            return;
        }
        Vector3 vector = GameManager.players[LocalClient.instance.myId].transform.position + Vector3.up * 1.5f;
        Vector3 normalized = (vector - pos).normalized;
        pos = hitCollider.ClosestPoint(vector);
        SpawnParticles(pos, normalized, hitEffect);
        float num = Vector3.Distance(pos, vector);
        pos += normalized * num * 0.5f;
        Object.Instantiate(numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir(0f, normalized, (HitEffect)hitEffect);
    }

    protected override void SpawnDeathParticles()
    {
        Object.Instantiate(destroyFx, base.transform.position, destroyFx.transform.rotation).GetComponent<ParticleSystemRenderer>().material.mainTexture = materialText;
    }

    protected override void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
    {
        GameObject gameObject = Object.Instantiate(hitFx);
        gameObject.transform.position = pos;
        gameObject.transform.rotation = Quaternion.LookRotation(dir);
        gameObject.GetComponent<ParticleSystemRenderer>().material.mainTexture = materialText;
        if (hitEffect != 0)
        {
            HitParticles componentInChildren = gameObject.GetComponentInChildren<HitParticles>();
            if (componentInChildren != null)
            {
                componentInChildren.SetEffect((HitEffect)hitEffect);
            }
        }
    }

    public override void OnKill(Vector3 dir)
    {
        ResourceManager.Instance.RemoveItem(id);
    }

    private void OnEnable()
    {
        desiredScale = base.transform.localScale;
        currentScale = base.transform.localScale;
    }

    private new void Awake()
    {
        base.Awake();
    }

    public void SetDefaultScale(Vector3 scale)
    {
        defaultScale = scale;
        desiredScale = scale;
    }

    protected override void ExecuteHit()
    {
        MonoBehaviour.print("changing scale lol");
        currentScale = defaultScale * 0.7f;
    }

    public void PopIn()
    {
    }

    private void Update()
    {
        if (!(Mathf.Abs(base.transform.localScale.x - desiredScale.x) < 0.002f) || !(Mathf.Abs(desiredScale.x - currentScale.x) < 0.002f))
        {
            currentScale = Vector3.Lerp(currentScale, desiredScale, Time.deltaTime * 10f);
            base.transform.localScale = Vector3.Lerp(base.transform.localScale, currentScale, Time.deltaTime * 15f);
        }
    }
}
