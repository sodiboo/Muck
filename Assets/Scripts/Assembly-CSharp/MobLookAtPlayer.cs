using UnityEngine;

public class MobLookAtPlayer : MonoBehaviour
{
    public bool lookAtPlayer;

    public Transform torso;

    public Transform head;

    private Mob mob;

    private Vector3 defaultHeadRotation;

    private Vector3 defaultTorsoRotation;

    public Vector3 maxTorsoRotation;

    public Vector3 maxHeadRotation;

    private void Awake()
    {
        defaultHeadRotation = head.transform.eulerAngles;
        defaultTorsoRotation = torso.transform.eulerAngles;
    }

    private void LateUpdate()
    {
        LookAtPlayer();
    }

    private void LookAtPlayer()
    {
        if (lookAtPlayer && (bool)mob.target)
        {
            Vector3 to = VectorExtensions.XZVector(mob.target.position - base.transform.position);
            Vector3.SignedAngle(VectorExtensions.XZVector(base.transform.forward), to, Vector3.up);
        }
    }
}
