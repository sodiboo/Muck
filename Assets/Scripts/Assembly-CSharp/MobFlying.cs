using System;
using UnityEngine;

// Token: 0x020000AD RID: 173
public class MobFlying : Mob
{
	// Token: 0x06000414 RID: 1044 RVA: 0x00016BFC File Offset: 0x00014DFC
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

	// Token: 0x04000407 RID: 1031
	private float defaultHeight = 5.6f;

	// Token: 0x04000408 RID: 1032
	public LayerMask whatIsGround;
}
