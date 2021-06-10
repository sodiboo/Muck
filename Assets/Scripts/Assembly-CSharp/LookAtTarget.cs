
using UnityEngine;

// Token: 0x02000044 RID: 68
public class LookAtTarget : MonoBehaviour
{
	// Token: 0x0600018F RID: 399 RVA: 0x0000A115 File Offset: 0x00008315
	private void Awake()
	{
		this.mob = base.transform.root.GetComponent<Mob>();
	}

	// Token: 0x06000190 RID: 400 RVA: 0x0000A130 File Offset: 0x00008330
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
		this.head.transform.localRotation = Quaternion.Euler(eulerAngles.x, eulerAngles.y, num);
	}

	// Token: 0x04000194 RID: 404
	public Transform target;

	// Token: 0x04000195 RID: 405
	public Transform head;

	// Token: 0x04000196 RID: 406
	public float lookDistance = 30f;

	// Token: 0x04000197 RID: 407
	private Mob mob;
}
