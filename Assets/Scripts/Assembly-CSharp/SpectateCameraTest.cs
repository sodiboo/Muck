using System;
using UnityEngine;

public class SpectateCameraTest : MonoBehaviour
{
	private void Start()
	{
		base.transform.parent = this.target;
		base.transform.localRotation = Quaternion.identity;
		base.transform.localPosition = new Vector3(0f, 0f, -6f);
	}

	private void Update()
	{
		Vector2 vector = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y"));
		this.desiredSpectateRotation += new Vector3(vector.y, -vector.x, 0f) * 1.5f;
		this.target.rotation = Quaternion.Lerp(base.transform.rotation, Quaternion.Euler(this.desiredSpectateRotation), Time.deltaTime * 10f);
	}

	public Transform target;

	private Vector3 desiredSpectateRotation;
}
