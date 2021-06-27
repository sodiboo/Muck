using System;
using UnityEngine;

// Token: 0x02000060 RID: 96
[ExecuteInEditMode]
public class LookAtTarget : MonoBehaviour
{
	// Token: 0x0600022C RID: 556 RVA: 0x0000D21D File Offset: 0x0000B41D
	private void Awake()
	{
		this.mob = base.transform.root.GetComponent<Mob>();
	}

	// Token: 0x0600022D RID: 557 RVA: 0x0000D238 File Offset: 0x0000B438
	private void LateUpdate()
	{
		if (this.mob.target == null)
		{
			return;
		}
		if (Vector3.Distance(this.mob.target.position, base.transform.position) > this.lookDistance)
		{
			return;
		}
		float num = Vector3.SignedAngle(base.transform.forward, VectorExtensions.XZVector(this.mob.target.position) - VectorExtensions.XZVector(base.transform.position), Vector3.up);
		num = Mathf.Clamp(num, -130f, 130f);
		Vector3 eulerAngles = this.head.transform.localRotation.eulerAngles;
		if (!this.yAxis)
		{
			this.head.transform.localRotation = Quaternion.Euler(eulerAngles.x, eulerAngles.y, num);
			return;
		}
		this.head.transform.localRotation = Quaternion.Euler(eulerAngles.x, num, eulerAngles.z);
	}

	// Token: 0x0400024C RID: 588
	public Transform target;

	// Token: 0x0400024D RID: 589
	public Transform head;

	// Token: 0x0400024E RID: 590
	public float lookDistance = 30f;

	// Token: 0x0400024F RID: 591
	public bool yAxis;

	// Token: 0x04000250 RID: 592
	private Mob mob;
}
