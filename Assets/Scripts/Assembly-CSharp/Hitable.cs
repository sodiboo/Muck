using UnityEngine;

public abstract class Hitable : MonoBehaviour, SharedObject
{
    protected int id;

    public string entityName;

    public bool canHitMoreThanOnce;

    public LootDrop dropTable;

    public int hp;

    public int maxHp;

    public GameObject destroyFx;

    public GameObject hitFx;

    public GameObject numberFx;

    protected Collider hitCollider;

    public bool localHit { get; set; }

    protected void Awake()
    {
        hp = maxHp;
        Collider[] components = GetComponents<Collider>();
        foreach (Collider collider in components)
        {
            if (!collider.isTrigger)
            {
                hitCollider = collider;
            }
        }
    }

    public abstract void Hit(int damage, float sharpness, int HitEffect, Vector3 pos, int HitWeaponType = 0);

    public virtual int Damage(int newHp, int fromClient, int hitEffect, Vector3 pos)
    {
        if (fromClient == LocalClient.instance.myId)
        {
            localHit = true;
        }
        Vector3 normalized = (GameManager.players[fromClient].transform.position + Vector3.up * 1.5f - pos).normalized;
        SpawnParticles(pos, normalized, hitEffect);
        int num = hp - newHp;
        if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) < 100f)
        {
            Object.Instantiate(numberFx, pos, Quaternion.identity).GetComponent<HitNumber>().SetTextAndDir(num, normalized, (HitEffect)hitEffect);
        }
        hp = newHp;
        if (hp <= 0)
        {
            hp = 0;
            KillObject(normalized);
        }
        ExecuteHit();
        return hp;
    }

    protected virtual void SpawnParticles(Vector3 pos, Vector3 dir, int hitEffect)
    {
        if (Vector3.Distance(PlayerMovement.Instance.playerCam.position, base.transform.position) > 100f)
        {
            return;
        }
        GameObject gameObject = Object.Instantiate(hitFx);
        gameObject.transform.position = pos;
        gameObject.transform.rotation = Quaternion.LookRotation(dir);
        if (hitEffect != 0)
        {
            HitParticles componentInChildren = gameObject.GetComponentInChildren<HitParticles>();
            if (componentInChildren != null)
            {
                componentInChildren.SetEffect((HitEffect)hitEffect);
            }
        }
    }

    protected virtual void SpawnDeathParticles()
    {
        Object.Instantiate(destroyFx, base.transform.position, destroyFx.transform.rotation);
    }

    public void KillObject(Vector3 dir)
    {
        SpawnDeathParticles();
        OnKill(dir);
    }

    public abstract void OnKill(Vector3 dir);

    protected abstract void ExecuteHit();

    public void SetId(int id)
    {
        this.id = id;
    }

    public int GetId()
    {
        return id;
    }
}
