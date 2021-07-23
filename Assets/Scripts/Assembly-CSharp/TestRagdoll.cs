using UnityEngine;

public class TestRagdoll : MonoBehaviour
{
    private Transform cow;

    public PhysicMaterial mat;

    private void Awake()
    {
        cow = base.transform.GetChild(0);
    }

    private void Update()
    {
    }

    private void Test()
    {
    }

    public void MakeRagdoll(Vector3 dir)
    {
        Animator component = GetComponent<Animator>();
        if ((bool)component)
        {
            component.enabled = false;
        }
        cow.SetParent(null);
        Transform child = cow.GetChild(0);
        AddComponents(child, null, dir);
        Ragdoll(child, dir);
        cow.gameObject.AddComponent<DestroyObject>().time = 10f;
        cow.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
        child.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
    }

    private void Ragdoll(Transform part, Vector3 dir)
    {
        part.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
        for (int i = 0; i < part.childCount; i++)
        {
            Transform child = part.GetChild(i);
            if (!child.CompareTag("Ignore"))
            {
                AddComponents(child, part.GetComponent<Rigidbody>(), dir);
                Ragdoll(child, dir);
            }
        }
    }

    private void AddComponents(Transform p, Rigidbody parent, Vector3 dir)
    {
        p.gameObject.layer = LayerMask.NameToLayer("GroundAndObjectOnly");
        Rigidbody rigidbody = p.gameObject.AddComponent<Rigidbody>();
        if (!rigidbody)
        {
            rigidbody = p.GetComponent<Rigidbody>();
            rigidbody.isKinematic = false;
            rigidbody.useGravity = true;
        }
        rigidbody.velocity = -dir.normalized * 8f;
        rigidbody.interpolation = RigidbodyInterpolation.Interpolate;
        rigidbody.angularDrag = 1f;
        rigidbody.drag = 0.2f;
        p.gameObject.AddComponent<SphereCollider>().material = mat;
        if (parent != null)
        {
            CharacterJoint characterJoint = p.gameObject.AddComponent<CharacterJoint>();
            characterJoint.connectedBody = parent;
            characterJoint.enableProjection = true;
        }
    }
}
