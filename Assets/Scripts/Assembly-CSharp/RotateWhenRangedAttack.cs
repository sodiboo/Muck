using System;
using UnityEngine;

// Token: 0x0200007F RID: 127
public class RotateWhenRangedAttack : MonoBehaviour
{
	// Token: 0x060002C4 RID: 708 RVA: 0x00004060 File Offset: 0x00002260
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

	// Token: 0x060002C5 RID: 709 RVA: 0x00012308 File Offset: 0x00010508
	public void LateUpdate()
	{
		if (!this.mob.target)
		{
			return;
		}
		if (this.mob.IsRangedAttacking())
		{
			base.transform.rotation = Quaternion.LookRotation(VectorExtensions.XZVector(this.mob.target.transform.position - base.transform.position));
		}
	}

	// Token: 0x040002D5 RID: 725
	private Mob mob;
}
