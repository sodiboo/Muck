using System;
using UnityEngine;

// Token: 0x02000058 RID: 88
public class MobLookAtPlayer : MonoBehaviour
{
	// Token: 0x060001CF RID: 463 RVA: 0x000035AE File Offset: 0x000017AE
	private void Awake()
	{
		this.defaultHeadRotation = this.head.transform.eulerAngles;
		this.defaultTorsoRotation = this.torso.transform.eulerAngles;
	}

	// Token: 0x060001D0 RID: 464 RVA: 0x000035DC File Offset: 0x000017DC
	private void LateUpdate()
	{
		this.LookAtPlayer();
	}

	// Token: 0x060001D1 RID: 465 RVA: 0x0000EEC8 File Offset: 0x0000D0C8
	private void LookAtPlayer()
	{
		if (!this.lookAtPlayer || !this.mob.target)
		{
			return;
		}
		Vector3 to = VectorExtensions.XZVector(this.mob.target.position - base.transform.position);
		Vector3.SignedAngle(VectorExtensions.XZVector(base.transform.forward), to, Vector3.up);
	}

	// Token: 0x040001E3 RID: 483
	public bool lookAtPlayer;

	// Token: 0x040001E4 RID: 484
	public Transform torso;

	// Token: 0x040001E5 RID: 485
	public Transform head;

	// Token: 0x040001E6 RID: 486
	private Mob mob;

	// Token: 0x040001E7 RID: 487
	private Vector3 defaultHeadRotation;

	// Token: 0x040001E8 RID: 488
	private Vector3 defaultTorsoRotation;

	// Token: 0x040001E9 RID: 489
	public Vector3 maxTorsoRotation;

	// Token: 0x040001EA RID: 490
	public Vector3 maxHeadRotation;
}
