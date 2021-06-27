using System;
using UnityEngine;

// Token: 0x0200008D RID: 141
public class RotateTowardsPlayer : MonoBehaviour
{
	// Token: 0x06000361 RID: 865 RVA: 0x000126C0 File Offset: 0x000108C0
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

	// Token: 0x0400036A RID: 874
	public Mob mob;
}
