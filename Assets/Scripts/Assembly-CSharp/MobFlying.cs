
using UnityEngine;

// Token: 0x02000089 RID: 137
public class MobFlying : Mob
{
	// Token: 0x060003BD RID: 957 RVA: 0x00012E00 File Offset: 0x00011000
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

	// Token: 0x0400035A RID: 858
	private float defaultHeight = 8f;

	// Token: 0x0400035B RID: 859
	public LayerMask whatIsGround;
}
