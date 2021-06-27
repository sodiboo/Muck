using System;
using UnityEngine;

public class RotateWhenRangedAttack : MonoBehaviour
{
	private void Awake()
	{
		this.mob = base.GetComponent<Mob>();
	}

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

	private Mob mob;
}
