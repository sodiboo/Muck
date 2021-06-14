using System;
using UnityEngine;

// Token: 0x02000038 RID: 56
public class GronkMob : Mob
{
	// Token: 0x06000136 RID: 310 RVA: 0x0000C1A4 File Offset: 0x0000A3A4
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
