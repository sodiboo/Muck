using System;
using UnityEngine;

[ExecuteInEditMode]
public class LookAtTarget : MonoBehaviour
{
	private void Awake()
	{
		this.mob = base.transform.root.GetComponent<Mob>();
	}

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

	public Transform target;

	public Transform head;

	public float lookDistance = 30f;

	public bool yAxis;

	private Mob mob;
}
