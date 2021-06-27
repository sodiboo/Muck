using System;
using UnityEngine;

// Token: 0x0200008E RID: 142
public class RotateWhenRangedAttack : MonoBehaviour
{
	// Token: 0x06000363 RID: 867 RVA: 0x00012768 File Offset: 0x00010968
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

	// Token: 0x06000364 RID: 868 RVA: 0x00012778 File Offset: 0x00010978
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

	// Token: 0x0400036B RID: 875
	private Mob mob;
}
