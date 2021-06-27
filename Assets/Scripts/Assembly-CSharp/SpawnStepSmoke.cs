using System;
using UnityEngine;

// Token: 0x02000115 RID: 277
public class SpawnStepSmoke : MonoBehaviour
{
	// Token: 0x060007FB RID: 2043 RVA: 0x000284BB File Offset: 0x000266BB
	public void LeftStep()
	{
		Instantiate<GameObject>(this.stepFx, this.leftFoot.position, this.stepFx.transform.rotation);
	}

	// Token: 0x060007FC RID: 2044 RVA: 0x000284E4 File Offset: 0x000266E4
	public void RightStep()
	{
		Instantiate<GameObject>(this.stepFx, this.rightFoot.position, this.stepFx.transform.rotation);
	}

	// Token: 0x0400079D RID: 1949
	public Transform leftFoot;

	// Token: 0x0400079E RID: 1950
	public Transform rightFoot;

	// Token: 0x0400079F RID: 1951
	public GameObject stepFx;
}
