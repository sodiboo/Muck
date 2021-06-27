using System;
using UnityEngine;

public class CinematicCamera : MonoBehaviour
{
	private void Update()
	{
		base.transform.LookAt(this.target);
		base.transform.RotateAround(this.target.position, Vector3.up, this.speed);
	}

	public Transform target;

	public float speed;
}
