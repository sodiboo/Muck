using UnityEngine;

public class LookAtTarget : MonoBehaviour
{
    public Transform target;

    public Transform head;

    public float lookDistance = 30f;

    public bool yAxis;

    private Mob mob;

    private void Awake()
    {
        mob = base.transform.root.GetComponent<Mob>();
    }

    private void LateUpdate()
    {
        if (!(mob.target == null) && !(Vector3.Distance(mob.target.position, base.transform.position) > lookDistance))
        {
            float value = Vector3.SignedAngle(base.transform.forward, VectorExtensions.XZVector(mob.target.position) - VectorExtensions.XZVector(base.transform.position), Vector3.up);
            value = Mathf.Clamp(value, -130f, 130f);
            Vector3 eulerAngles = head.transform.localRotation.eulerAngles;
            if (!yAxis)
            {
                head.transform.localRotation = Quaternion.Euler(eulerAngles.x, eulerAngles.y, value);
            }
            else
            {
                head.transform.localRotation = Quaternion.Euler(eulerAngles.x, value, eulerAngles.z);
            }
        }
    }
}
