using System;
using UnityEngine;

public class MobFlying : Mob
{
	public override void ExtraUpdate()
	{
		if (!base.target)
		{
			return;
		}
		RaycastHit raycastHit;
		if (Physics.Raycast(base.target.transform.position, Vector3.down, out raycastHit, 5000f, this.whatIsGround))
		{
			float distance = raycastHit.distance;
			float b = this.defaultHeight + distance;
			base.agent.baseOffset = Mathf.Lerp(base.agent.baseOffset, b, Time.deltaTime * 0.3f);
		}
	}

	private float defaultHeight = 5.6f;

	public LayerMask whatIsGround;
}
