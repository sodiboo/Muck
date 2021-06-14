using System;
using UnityEngine;

// Token: 0x0200007E RID: 126
public class RotateTowardsPlayer : MonoBehaviour
{
	// Token: 0x060002C2 RID: 706 RVA: 0x00012260 File Offset: 0x00010460
	private void Update()
	{
		if (!this.mob.target)
		{
			return;
		}
		if ((double)this.mob.agent.velocity.magnitude < 0.05 && !this.mob.IsAttacking())
		{
			Quaternion b = Quaternion.LookRotation(VectorExtensions.XZVector(this.mob.target.transform.position - base.transform.position));
			base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 5f);
		}
	}

	// Token: 0x040002D4 RID: 724
	public Mob mob;
}
