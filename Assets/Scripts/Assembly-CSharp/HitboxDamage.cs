using System.Collections.Generic;
using UnityEngine;

public class HitboxDamage : MonoBehaviour
{
    public bool dontStopHitbox;

    public int baseDamage;

    private float multiplier = 1f;

    private List<GameObject> alreadyHit = new List<GameObject>();

    public Vector3 pushPlayer;

    public float hitboxTime = 0.15f;

    private bool playerHit;

    private void Awake()
    {
        if (!dontStopHitbox)
        {
            Invoke("DisableHitbox", hitboxTime);
        }
    }

    private void DisableHitbox()
    {
        GetComponent<Collider>().enabled = false;
    }

    public void Reset()
    {
        alreadyHit = new List<GameObject>();
        playerHit = false;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (alreadyHit.Contains(other.gameObject))
        {
            return;
        }
        alreadyHit.Add(other.gameObject);
        if (other.gameObject.layer == LayerMask.NameToLayer("Player"))
        {
            if (!playerHit && other.CompareTag("Local") && (bool)PlayerMovement.Instance && !GameManager.players[LocalClient.instance.myId].dead)
            {
                playerHit = true;
                ClientSend.PlayerHit((int)((float)baseDamage * multiplier), LocalClient.instance.myId, 0f, 0, base.transform.position);
                PlayerMovement.Instance.grounded = false;
                PlayerMovement.Instance.GetRb().velocity += pushPlayer;
                PlayerMovement.Instance.PushPlayer();
            }
        }
        else
        {
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
                multiplier *= 0.5f;
            }
        }
    }

    public void SetDamage(int damage)
    {
        baseDamage = damage;
    }
}
