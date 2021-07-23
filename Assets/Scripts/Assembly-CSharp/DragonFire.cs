using UnityEngine;

public class DragonFire : MonoBehaviour
{
    private Collider c;

    public HitboxDamage hitbox;

    private float yHeight;

    private void Awake()
    {
        InvokeRepeating("UpdateHitbox", 0.1f, 0.1f);
        Invoke("StartHitbox", 1.35f);
        c = GetComponent<Collider>();
        c.enabled = false;
    }

    private void StartHitbox()
    {
        Invoke("StopHitbox", 1.5f);
        c.enabled = true;
    }

    private void StopHitbox()
    {
        c.enabled = false;
    }

    private void UpdateHitbox()
    {
        hitbox.Reset();
    }

    private void Update()
    {
        Vector3 euler = new Vector3(0f, base.transform.parent.rotation.eulerAngles.y, 0f);
        base.transform.rotation = Quaternion.Euler(euler);
    }
}
