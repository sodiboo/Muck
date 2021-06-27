using System;
using UnityEngine;

// Token: 0x02000066 RID: 102
public class MobLookAtPlayer : MonoBehaviour
{
	// Token: 0x06000244 RID: 580 RVA: 0x0000D69E File Offset: 0x0000B89E
	private void Awake()
	{
		this.defaultHeadRotation = this.head.transform.eulerAngles;
		this.defaultTorsoRotation = this.torso.transform.eulerAngles;
	}

	// Token: 0x06000245 RID: 581 RVA: 0x0000D6CC File Offset: 0x0000B8CC
	private void LateUpdate()
	{
		this.LookAtPlayer();
	}

	// Token: 0x06000246 RID: 582 RVA: 0x0000D6D4 File Offset: 0x0000B8D4
	private void LookAtPlayer()
	{
		if (!this.lookAtPlayer || !this.mob.target)
		{
			return;
		}
		Vector3 to = VectorExtensions.XZVector(this.mob.target.position - base.transform.position);
		Vector3.SignedAngle(VectorExtensions.XZVector(base.transform.forward), to, Vector3.up);
	}

	// Token: 0x04000260 RID: 608
	public bool lookAtPlayer;

	// Token: 0x04000261 RID: 609
	public Transform torso;

	// Token: 0x04000262 RID: 610
	public Transform head;

	// Token: 0x04000263 RID: 611
	private Mob mob;

	// Token: 0x04000264 RID: 612
	private Vector3 defaultHeadRotation;

	// Token: 0x04000265 RID: 613
	private Vector3 defaultTorsoRotation;

	// Token: 0x04000266 RID: 614
	public Vector3 maxTorsoRotation;

	// Token: 0x04000267 RID: 615
	public Vector3 maxHeadRotation;
}
