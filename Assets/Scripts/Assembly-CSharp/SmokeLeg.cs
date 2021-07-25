using UnityEngine;

public class SmokeLeg : MonoBehaviour
{
    public GameObject smokeFx;

    public float cooldown;

    private bool ready = true;

    private void OnTriggerEnter(Collider other)
    {
        if (ready && other.gameObject.layer == LayerMask.NameToLayer("Ground"))
        {
            ready = false;
            Invoke(nameof(GetReady), cooldown);
            Object.Instantiate(smokeFx, base.transform.position, smokeFx.transform.rotation);
        }
    }

    private void GetReady()
    {
        ready = true;
    }
}
