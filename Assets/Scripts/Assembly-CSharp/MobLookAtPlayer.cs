
using UnityEngine;

// Token: 0x0200004A RID: 74
public class MobLookAtPlayer : MonoBehaviour
{
	// Token: 0x060001A6 RID: 422 RVA: 0x0000A546 File Offset: 0x00008746
	private void Awake()
	{
		this.defaultHeadRotation = this.head.transform.eulerAngles;
		this.defaultTorsoRotation = this.torso.transform.eulerAngles;
	}

	// Token: 0x060001A7 RID: 423 RVA: 0x0000A574 File Offset: 0x00008774
	private void LateUpdate()
	{
		this.LookAtPlayer();
	}

	// Token: 0x060001A8 RID: 424 RVA: 0x0000A57C File Offset: 0x0000877C
	private void LookAtPlayer()
	{
		if (!this.lookAtPlayer || !this.mob.target)
		{
			return;
		}
		Vector3 to = VectorExtensions.XZVector(this.mob.target.position - base.transform.position);
		Vector3.SignedAngle(VectorExtensions.XZVector(base.transform.forward), to, Vector3.up);
	}

	// Token: 0x040001A7 RID: 423
	public bool lookAtPlayer;

	// Token: 0x040001A8 RID: 424
	public Transform torso;

	// Token: 0x040001A9 RID: 425
	public Transform head;

	// Token: 0x040001AA RID: 426
	private Mob mob;

	// Token: 0x040001AB RID: 427
	private Vector3 defaultHeadRotation;

	// Token: 0x040001AC RID: 428
	private Vector3 defaultTorsoRotation;

	// Token: 0x040001AD RID: 429
	public Vector3 maxTorsoRotation;

	// Token: 0x040001AE RID: 430
	public Vector3 maxHeadRotation;
}
