using System;
using UnityEngine;

public class RotateNeck : MonoBehaviour
{
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

	private void ResetNeck()
	{
		this.done = true;
	}

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

	public Mob mob;

	public Transform neck;

	public Transform neckForward;

	public Transform customTarget;

	private Quaternion desiredRot;

	private Quaternion desiredHeadRot;

	private Quaternion oldRot;

	private Quaternion oldHeadRot;

	private Transform currentBreath;

	private bool done;

	public GameObject fireBreathPrefab;

	public Transform head;

	public Transform realHead;
}
