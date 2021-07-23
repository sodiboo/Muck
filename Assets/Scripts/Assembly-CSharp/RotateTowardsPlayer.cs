using UnityEngine;

public class RotateTowardsPlayer : MonoBehaviour
{
    public Mob mob;

    private void Update()
    {
        if ((bool)mob.target && (double)mob.agent.velocity.magnitude < 0.05 && !mob.IsAttacking())
        {
            Quaternion b = Quaternion.LookRotation(VectorExtensions.XZVector(mob.target.transform.position - base.transform.position));
            base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 5f);
        }
    }
}
