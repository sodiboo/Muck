using System.Collections.Generic;
using UnityEngine;

public class AreaEffect : MonoBehaviour
{
    private int damage;

    private List<GameObject> actorsHit;

    public void SetDamage(int d)
    {
        damage = d;
        GetComponent<Collider>().enabled = true;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!other.gameObject.CompareTag("Build"))
        {
            Hitable component = other.GetComponent<Hitable>();
            if (!(component == null) && !other.transform.root.CompareTag("Local"))
            {
                component.Hit(damage, 0f, 3, base.transform.position, -1);
                Object.Destroy(this);
            }
        }
    }
}
