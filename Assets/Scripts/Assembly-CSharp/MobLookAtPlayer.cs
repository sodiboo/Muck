using System;
using UnityEngine;

public class MobLookAtPlayer : MonoBehaviour
{
	private void Awake()
	{
		this.defaultHeadRotation = this.head.transform.eulerAngles;
		this.defaultTorsoRotation = this.torso.transform.eulerAngles;
	}

	private void LateUpdate()
	{
		this.LookAtPlayer();
	}

	private void LookAtPlayer()
	{
		if (!this.lookAtPlayer || !this.mob.target)
		{
			return;
		}
		Vector3 to = VectorExtensions.XZVector(this.mob.target.position - base.transform.position);
		Vector3.SignedAngle(VectorExtensions.XZVector(base.transform.forward), to, Vector3.up);
	}

	public bool lookAtPlayer;

	public Transform torso;

	public Transform head;

	private Mob mob;

	private Vector3 defaultHeadRotation;

	private Vector3 defaultTorsoRotation;

	public Vector3 maxTorsoRotation;

	public Vector3 maxHeadRotation;
}
