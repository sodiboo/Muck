using System;
using UnityEngine;

public class GronkMob : Mob
{
	public override void ExtraUpdate()
	{
		if (!base.target)
		{
			return;
		}
		if (base.IsRangedAttacking() && base.IsAttacking())
		{
			base.transform.rotation = Quaternion.LookRotation(VectorExtensions.XZVector(base.target.transform.position - base.transform.position));
		}
	}
}
