using System;
using UnityEngine;

public class CameraLookAt : MonoBehaviour
{
	private void Update()
	{
		Quaternion b = Quaternion.LookRotation(this.target.position - base.transform.position);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6.4f);
	}

	public Transform target;
}
