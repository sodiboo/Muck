using System;
using UnityEngine;


public class HitableResource : Hitable
{

    protected void Start()
    {
        Material material = base.GetComponentInChildren<Renderer>().materials[0];
        this.materialText = material.mainTexture;
    }


    public override void Hit(int damage, float sharpness, int hitEffect, Vector3 pos)
    {
        if (damage > 0)
        {
            ClientSend.PlayerHitObject(damage, this.id, hitEffect, pos);
            return;
        }
        Vector3 vector = GameManager.players[LocalClient.instance.myId].transform.position + Vector3.up * 1.5f;
        Vector3 normalized = (vector - pos).normalized;
        pos = this.hitCollider.ClosestPoint(vector);
        this.SpawnParticles(pos, normalized, hitEffect);
        float d = Vector3.Distance(pos, vector);
        pos += normalized * d * 0.5f;
        Instantiate<GameObject>(this.numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir(0f, normalized, (HitEffect)hitEffect);
    }


    protected override void SpawnDeathParticles()
    {
        Instantiate<GameObject>(this.destroyFx, base.transform.position, this.destroyFx.transform.rotation).GetComponent<ParticleSystemRenderer>().material.mainTexture = this.materialText;
    }


    protected override void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
    {
        GameObject gameObject = Instantiate<GameObject>(this.hitFx);
        gameObject.transform.position = pos;
        gameObject.transform.rotation = Quaternion.LookRotation(dir);
        gameObject.GetComponent<ParticleSystemRenderer>().material.mainTexture = this.materialText;
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
        ResourceManager.Instance.RemoveItem(this.id);
        if (!SaveData.isExecuting) SaveData.Instance.save.Add(new SaveData.DestroyItem { objectId = id });
    }


    private void OnEnable()
    {
        if (this.dontScale)
        {
            return;
        }
        base.transform.localScale = Vector3.zero;
    }


    private new void Awake()
    {
        base.Awake();
        if (this.dontScale)
        {
            return;
        }
        if (this.defaultScale == Vector3.zero)
        {
            this.defaultScale = base.transform.localScale;
        }
        this.desiredScale = this.defaultScale;
        base.transform.localScale = Vector3.zero;
    }


    public void SetDefaultScale(Vector3 scale)
    {
        this.defaultScale = scale;
    }


    protected override void ExecuteHit()
    {
        MonoBehaviour.print("changing scale lol");
        this.currentScale = this.defaultScale * 0.7f;
    }


    public void PopIn()
    {
        base.transform.localScale = Vector3.zero;
        this.desiredScale = this.defaultScale;
    }


    private void Update()
    {
        if (ResourceManager.Instance != null)
        {
            if (!ResourceManager.Instance.list.ContainsKey(id)) Destroy(gameObject);
            else if (ResourceManager.Instance.list[id] != gameObject) Destroy(gameObject);
        }
        if (this.dontScale)
        {
            return;
        }
        if (Mathf.Abs(base.transform.localScale.x - this.desiredScale.x) < 0.002f && Mathf.Abs(this.desiredScale.x - this.currentScale.x) < 0.002f)
        {
            return;
        }
        this.currentScale = Vector3.Lerp(this.currentScale, this.desiredScale, Time.deltaTime * 10f);
        base.transform.localScale = Vector3.Lerp(base.transform.localScale, this.currentScale, Time.deltaTime * 15f);
    }


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
}
