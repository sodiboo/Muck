using System;
using UnityEngine;

// Token: 0x02000051 RID: 81
[ExecuteInEditMode]
public class LookAtTarget : MonoBehaviour
{
	// Token: 0x060001B7 RID: 439 RVA: 0x00003462 File Offset: 0x00001662
	private void Awake()
	{
		this.mob = base.transform.root.GetComponent<Mob>();
	}

	// Token: 0x060001B8 RID: 440 RVA: 0x0000EB94 File Offset: 0x0000CD94
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

	// Token: 0x040001C9 RID: 457
	public Transform target;

	// Token: 0x040001CA RID: 458
	public Transform head;

	// Token: 0x040001CB RID: 459
	public float lookDistance = 30f;

	// Token: 0x040001CC RID: 460
	public bool yAxis;

	// Token: 0x040001CD RID: 461
	private Mob mob;
}
