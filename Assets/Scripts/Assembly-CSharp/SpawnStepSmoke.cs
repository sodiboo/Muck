
using UnityEngine;

// Token: 0x020000E6 RID: 230
public class SpawnStepSmoke : MonoBehaviour
{
	// Token: 0x060006B9 RID: 1721 RVA: 0x00021C53 File Offset: 0x0001FE53
	public void LeftStep()
	{
	Instantiate(this.stepFx, this.leftFoot.position, this.stepFx.transform.rotation);
	}

	// Token: 0x060006BA RID: 1722 RVA: 0x00021C7C File Offset: 0x0001FE7C
	public void RightStep()
	{
	Instantiate(this.stepFx, this.rightFoot.position, this.stepFx.transform.rotation);
	}

	// Token: 0x04000659 RID: 1625
	public Transform leftFoot;

	// Token: 0x0400065A RID: 1626
	public Transform rightFoot;

	// Token: 0x0400065B RID: 1627
	public GameObject stepFx;
}
