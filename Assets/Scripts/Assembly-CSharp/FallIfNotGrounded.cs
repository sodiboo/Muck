using UnityEngine;

public class FallIfNotGrounded : MonoBehaviour
{
    private Rigidbody rb;

    public float x;

    public float z;

    private bool falling;

    private Vector3 bottomOffset;

    public LayerMask whatIsLandable;

    private Mesh mesh;

    private Collider c;

    private void Start()
    {
        x = base.transform.position.x;
        z = base.transform.position.z;
        MeshFilter componentInChildren = GetComponentInChildren<MeshFilter>();
        if ((bool)componentInChildren)
        {
            mesh = componentInChildren.mesh;
        }
        else
        {
            SkinnedMeshRenderer componentInChildren2 = GetComponentInChildren<SkinnedMeshRenderer>();
            if ((bool)componentInChildren2)
            {
                mesh = componentInChildren2.sharedMesh;
            }
        }
        c = GetComponent<Collider>();
        if ((bool)c)
        {
            bottomOffset = new Vector3(0f, c.bounds.extents.y, 0f);
        }
        InvokeRepeating("CheckFalling", 1f, 1f);
    }

    private void CheckFalling()
    {
        if (falling)
        {
            return;
        }
        bool flag = false;
        RaycastHit[] array = Physics.RaycastAll(base.transform.position, Vector3.down, 2f, whatIsLandable);
        foreach (RaycastHit raycastHit in array)
        {
            if (raycastHit.collider.gameObject.layer != LayerMask.NameToLayer("Pickup"))
            {
                flag = true;
            }
        }
        if (!flag)
        {
            StartFalling();
        }
    }

    private void StartFalling()
    {
        Hitable component = GetComponent<Hitable>();
        component.Hit(component.maxHp, 0f, 0, base.transform.position, -1);
        falling = true;
        rb = base.gameObject.AddComponent<Rigidbody>();
        rb.isKinematic = false;
        rb.constraints = (RigidbodyConstraints)122;
    }

    private void Land()
    {
        Object.Destroy(rb);
        falling = false;
    }
}
