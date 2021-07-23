using System.Collections.Generic;
using UnityEngine;

public class ImpactDamage : MonoBehaviour
{
    public float radius = 1f;

    public int baseDamage;

    public bool hitPlayer;

    public bool decreaseWithDistance;

    private float multiplier = 1f;

    private List<GameObject> alreadyHit = new List<GameObject>();

    private bool race;

    private void Start()
    {
        if (race)
        {
            Object.Destroy(base.gameObject);
        }
        else
        {
            race = true;
        }
        if (!PlayerMovement.Instance || GameManager.players[LocalClient.instance.myId].dead)
        {
            return;
        }
        float num = Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
        if (hitPlayer)
        {
            num = 0f;
        }
        if (!(num > radius))
        {
            num = Mathf.Clamp(num - 1f, 0f, radius);
            float value = (radius - num) / radius;
            value = Mathf.Clamp(value, 0f, 1f);
            if (!decreaseWithDistance)
            {
                value = 1f;
            }
            ClientSend.PlayerHit((int)((float)baseDamage * value), LocalClient.instance.myId, 0f, 0, base.transform.position);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (alreadyHit.Contains(other.gameObject))
        {
            return;
        }
        alreadyHit.Add(other.gameObject);
        if (race)
        {
            Object.Destroy(base.gameObject);
        }
        else
        {
            race = true;
        }
        if (!LocalClient.serverOwner)
        {
            return;
        }
        Hitable componentInChildren = other.transform.root.GetComponentInChildren<Hitable>();
        if ((bool)componentInChildren)
        {
            float num = 1f;
            if (other.CompareTag("Build"))
            {
                num = 0.5f;
                multiplier *= 0.5f;
            }
            componentInChildren.Hit((int)((float)baseDamage * num * multiplier), 0f, 0, base.transform.position, -1);
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(base.transform.position, radius);
    }

    public void SetDamage(int damage)
    {
        baseDamage = damage;
    }
}
