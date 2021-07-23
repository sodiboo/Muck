using UnityEngine;

public class EnemyProjectile : MonoBehaviour
{
    public GameObject hitFx;

    private bool done;

    public bool collideWithPlayerAndBuildOnly;

    public bool ignoreGround;

    public Transform spawnPos;

    public float hideFxDistance = 40f;

    public int damage { get; set; }

    private void Awake()
    {
        Invoke("DestroySelf", 10f);
    }

    public void DisableCollider(float time)
    {
        if ((bool)GetComponent<Collider>())
        {
            GetComponent<Collider>().enabled = false;
            Invoke("ActivateCollider", time);
        }
    }

    private void ActivateCollider()
    {
        GetComponent<Collider>().enabled = true;
    }

    private void OnCollisionEnter(Collision other)
    {
        int layer = other.gameObject.layer;
        if ((ignoreGround && other.collider.gameObject.layer == LayerMask.NameToLayer("Ground")) || (collideWithPlayerAndBuildOnly && layer != LayerMask.NameToLayer("Player") && layer != LayerMask.NameToLayer("Object")) || done)
        {
            return;
        }
        done = true;
        bool hitPlayer = layer == LayerMask.NameToLayer("Player") && other.gameObject.CompareTag("Local");
        if (LocalClient.serverOwner && layer == LayerMask.NameToLayer("Object"))
        {
            other.gameObject.CompareTag("Build");
        }
        Object.Destroy(base.gameObject);
        if (Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position) < hideFxDistance)
        {
            GameObject gameObject = Object.Instantiate(hitFx, base.transform.position, Quaternion.LookRotation(other.GetContact(0).normal));
            gameObject.transform.rotation = Quaternion.LookRotation(other.GetContact(0).normal);
            ImpactDamage componentInChildren = gameObject.GetComponentInChildren<ImpactDamage>();
            componentInChildren.SetDamage(damage);
            componentInChildren.hitPlayer = hitPlayer;
            if ((bool)spawnPos)
            {
                gameObject.transform.position = spawnPos.position;
            }
        }
    }

    private void DestroySelf()
    {
        Object.Destroy(base.gameObject);
    }
}
