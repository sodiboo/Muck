using UnityEngine;

public class GronkMob : Mob
{
    public override void ExtraUpdate()
    {
        if ((bool)base.target && IsRangedAttacking() && IsAttacking())
        {
            base.transform.rotation = Quaternion.LookRotation(VectorExtensions.XZVector(base.target.transform.position - base.transform.position));
        }
    }
}
