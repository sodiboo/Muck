using UnityEngine;
using UnityEngine.AI;

public class JumpAttack : MonoBehaviour
{
    public RotateWhenRangedAttack rangedRotation;

    public NavMeshAgent agent;

    public Mob mob;

    public GameObject warningPrefab;

    public GameObject jumpFx;

    public GameObject landingFx;

    public float jumpTime = 1f;

    private float currentTime;

    private Vector3 startJumpPos;

    private Vector3 desiredPos;

    public Transform raycastPos;

    public LayerMask whatIsHittable;

    public LayerMask whatIsGroundOnly;

    private void Update()
    {
        if (!agent.enabled)
        {
            currentTime += Time.deltaTime;
            float num = currentTime;
            float y = Physics.gravity.y;
            float num2 = 2f;
            float num3 = (10f * num + y * Mathf.Pow(num, 2f)) * num2;
            base.transform.position = Vector3.Lerp(startJumpPos, desiredPos, currentTime / jumpTime);
            base.transform.position += Vector3.up * num3;
        }
    }

    private void Jump()
    {
        startJumpPos = base.transform.position;
        if (!mob.target)
        {
            desiredPos = base.transform.position;
        }
        else
        {
            Vector3 direction = mob.target.position - raycastPos.position;
            if (Physics.Raycast(raycastPos.position, direction, out var hitInfo, 200f, whatIsHittable))
            {
                if (Physics.Raycast(hitInfo.point, Vector3.down, out var hitInfo2, 500f, whatIsGroundOnly))
                {
                    desiredPos = hitInfo2.point - Vector3.up * agent.baseOffset;
                }
                else
                {
                    desiredPos = base.transform.position;
                }
            }
            else
            {
                desiredPos = base.transform.position;
            }
        }
        agent.enabled = false;
        rangedRotation.enabled = false;
        currentTime = 0f;
        Object.Instantiate(warningPrefab, desiredPos, warningPrefab.transform.rotation).GetComponent<EnemyAttackIndicator>().SetWarning(1f, 13.5f);
        Object.Instantiate(jumpFx, base.transform.position, landingFx.transform.rotation);
    }

    private void Land()
    {
        agent.enabled = true;
        rangedRotation.enabled = true;
        Object.Instantiate(landingFx, base.transform.position, landingFx.transform.rotation);
    }
}
