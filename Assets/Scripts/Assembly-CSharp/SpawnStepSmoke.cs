using System;
using UnityEngine;

// Token: 0x02000134 RID: 308
public class SpawnStepSmoke : MonoBehaviour
{
	// Token: 0x06000769 RID: 1897 RVA: 0x00006E1B File Offset: 0x0000501B
	public void LeftStep()
	{
	Instantiate<GameObject>(this.stepFx, this.leftFoot.position, this.stepFx.transform.rotation);
	}

	// Token: 0x0600076A RID: 1898 RVA: 0x00006E44 File Offset: 0x00005044
	public void RightStep()
	{
	Instantiate<GameObject>(this.stepFx, this.rightFoot.position, this.stepFx.transform.rotation);
	}

	// Token: 0x040007A8 RID: 1960
	public Transform leftFoot;

	// Token: 0x040007A9 RID: 1961
	public Transform rightFoot;

	// Token: 0x040007AA RID: 1962
	public GameObject stepFx;
}
