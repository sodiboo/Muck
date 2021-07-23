using UnityEngine;

public class RotateWhenRangedAttack : MonoBehaviour
{
    private Mob mob;

    private void Awake()
    {
        mob = GetComponent<Mob>();
    }

    public void LateUpdate()
    {
        if ((bool)mob.target && mob.IsRangedAttacking())
        {
            base.transform.rotation = Quaternion.LookRotation(VectorExtensions.XZVector(mob.target.transform.position - base.transform.position));
        }
    }
}
