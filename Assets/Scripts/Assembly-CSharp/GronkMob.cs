using System;
using UnityEngine;

// Token: 0x02000042 RID: 66
public class GronkMob : Mob
{
	// Token: 0x0600018F RID: 399 RVA: 0x000096CC File Offset: 0x000078CC
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
