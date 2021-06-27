using System;
using UnityEngine;

public class RotateTowardsPlayer : MonoBehaviour
{
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

	public Mob mob;
}
