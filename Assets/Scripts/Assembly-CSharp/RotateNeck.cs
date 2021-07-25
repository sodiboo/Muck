using UnityEngine;

public class RotateNeck : MonoBehaviour
{
    public Mob mob;

    public Transform neck;

    public Transform neckForward;

    public Transform customTarget;

    private Quaternion desiredRot;

    private Quaternion desiredHeadRot;

    private Quaternion oldRot;

    private Quaternion oldHeadRot;

    private Transform currentBreath;

    private bool done;

    public GameObject fireBreathPrefab;

    public Transform head;

    public Transform realHead;

    private void OnEnable()
    {
        desiredRot = Quaternion.Euler(-8f, 2f, 0f);
        desiredHeadRot = Quaternion.Euler(-34f, 0f, 0f);
        oldRot = desiredRot;
        oldHeadRot = desiredHeadRot;
        Invoke(nameof(ResetNeck), 3f);
        done = false;
        currentBreath = Object.Instantiate(fireBreathPrefab).transform;
    }

    private void ResetNeck()
    {
        done = true;
    }

    private void LateUpdate()
    {
        if (done)
        {
            desiredRot = Quaternion.Lerp(desiredRot, oldRot, Time.deltaTime * 3f);
            neck.transform.localRotation = desiredRot;
            currentBreath.rotation = Quaternion.LookRotation(head.transform.up);
            currentBreath.position = head.position;
            desiredHeadRot = Quaternion.Lerp(desiredHeadRot, oldHeadRot, Time.deltaTime * 3f);
            realHead.transform.localRotation = desiredHeadRot;
        }
        else if (!(mob.target == null))
        {
            Transform target = mob.target;
            Vector3 vector = VectorExtensions.XZVector(neckForward.forward);
            Vector3 vector2 = VectorExtensions.XZVector(target.position) - VectorExtensions.XZVector(neckForward.position);
            Debug.DrawLine(neckForward.position, neckForward.position + vector * 5f, Color.green);
            Debug.DrawLine(neckForward.position, neckForward.position + vector2 * 5f, Color.blue);
            float value = Vector3.SignedAngle(vector, vector2, Vector3.up);
            value = Mathf.Clamp(value, -130f, 130f);
            Vector3 eulerAngles = neck.transform.localRotation.eulerAngles;
            Vector3 eulerAngles2 = oldHeadRot.eulerAngles;
            desiredRot = Quaternion.Lerp(desiredRot, Quaternion.Euler(eulerAngles.x, value, eulerAngles.z), Time.deltaTime * 2.5f);
            float num = Vector3.Distance(target.position, realHead.transform.position);
            float value2 = -40f + num * 1.5f;
            value2 = Mathf.Clamp(value2, -40f, 3f);
            desiredHeadRot = Quaternion.Lerp(desiredHeadRot, Quaternion.Euler(eulerAngles2.x + value2, eulerAngles2.y, eulerAngles2.z), Time.deltaTime * 4f);
            neck.transform.localRotation = desiredRot;
            realHead.transform.localRotation = desiredHeadRot;
            currentBreath.rotation = Quaternion.LookRotation(head.transform.up);
            currentBreath.position = head.position;
        }
    }
}
