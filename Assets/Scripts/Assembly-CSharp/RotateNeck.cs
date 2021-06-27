using System;
using UnityEngine;

// Token: 0x0200008B RID: 139
public class RotateNeck : MonoBehaviour
{
	// Token: 0x0600035B RID: 859 RVA: 0x00012358 File Offset: 0x00010558
	private void OnEnable()
	{
		this.desiredRot = Quaternion.Euler(-8f, 2f, 0f);
		this.desiredHeadRot = Quaternion.Euler(-34f, 0f, 0f);
		this.oldRot = this.desiredRot;
		this.oldHeadRot = this.desiredHeadRot;
		Invoke(nameof(ResetNeck), 3f);
		this.done = false;
		this.currentBreath = Instantiate<GameObject>(this.fireBreathPrefab).transform;
	}

	// Token: 0x0600035C RID: 860 RVA: 0x000123DE File Offset: 0x000105DE
	private void ResetNeck()
	{
		this.done = true;
	}

	// Token: 0x0600035D RID: 861 RVA: 0x000123E8 File Offset: 0x000105E8
	private void LateUpdate()
	{
		if (this.done)
		{
			this.desiredRot = Quaternion.Lerp(this.desiredRot, this.oldRot, Time.deltaTime * 3f);
			this.neck.transform.localRotation = this.desiredRot;
			this.currentBreath.rotation = Quaternion.LookRotation(this.head.transform.up);
			this.currentBreath.position = this.head.position;
			this.desiredHeadRot = Quaternion.Lerp(this.desiredHeadRot, this.oldHeadRot, Time.deltaTime * 3f);
			this.realHead.transform.localRotation = this.desiredHeadRot;
			return;
		}
		if (this.mob.target == null)
		{
			return;
		}
		Transform target = this.mob.target;
		Vector3 vector = VectorExtensions.XZVector(this.neckForward.forward);
		Vector3 vector2 = VectorExtensions.XZVector(target.position) - VectorExtensions.XZVector(this.neckForward.position);
		Debug.DrawLine(this.neckForward.position, this.neckForward.position + vector * 5f, Color.green);
		Debug.DrawLine(this.neckForward.position, this.neckForward.position + vector2 * 5f, Color.blue);
		float num = Vector3.SignedAngle(vector, vector2, Vector3.up);
		num = Mathf.Clamp(num, -130f, 130f);
		Vector3 eulerAngles = this.neck.transform.localRotation.eulerAngles;
		Vector3 eulerAngles2 = this.oldHeadRot.eulerAngles;
		this.desiredRot = Quaternion.Lerp(this.desiredRot, Quaternion.Euler(eulerAngles.x, num, eulerAngles.z), Time.deltaTime * 2.5f);
		float num2 = Vector3.Distance(target.position, this.realHead.transform.position);
		float num3 = -40f + num2 * 1.5f;
		num3 = Mathf.Clamp(num3, -40f, 3f);
		this.desiredHeadRot = Quaternion.Lerp(this.desiredHeadRot, Quaternion.Euler(eulerAngles2.x + num3, eulerAngles2.y, eulerAngles2.z), Time.deltaTime * 4f);
		this.neck.transform.localRotation = this.desiredRot;
		this.realHead.transform.localRotation = this.desiredHeadRot;
		this.currentBreath.rotation = Quaternion.LookRotation(this.head.transform.up);
		this.currentBreath.position = this.head.position;
	}

	// Token: 0x0400035C RID: 860
	public Mob mob;

	// Token: 0x0400035D RID: 861
	public Transform neck;

	// Token: 0x0400035E RID: 862
	public Transform neckForward;

	// Token: 0x0400035F RID: 863
	public Transform customTarget;

	// Token: 0x04000360 RID: 864
	private Quaternion desiredRot;

	// Token: 0x04000361 RID: 865
	private Quaternion desiredHeadRot;

	// Token: 0x04000362 RID: 866
	private Quaternion oldRot;

	// Token: 0x04000363 RID: 867
	private Quaternion oldHeadRot;

	// Token: 0x04000364 RID: 868
	private Transform currentBreath;

	// Token: 0x04000365 RID: 869
	private bool done;

	// Token: 0x04000366 RID: 870
	public GameObject fireBreathPrefab;

	// Token: 0x04000367 RID: 871
	public Transform head;

	// Token: 0x04000368 RID: 872
	public Transform realHead;
}
