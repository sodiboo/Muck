using System;
using UnityEngine;

// Token: 0x020000B0 RID: 176
public class MobFlying : Mob
{
	// Token: 0x060004B3 RID: 1203 RVA: 0x000180C8 File Offset: 0x000162C8
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

	// Token: 0x04000463 RID: 1123
	private float defaultHeight = 5.6f;

	// Token: 0x04000464 RID: 1124
	public LayerMask whatIsGround;
}
