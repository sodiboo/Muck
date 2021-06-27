using System;
using UnityEngine;

public class BoatCamera : MonoBehaviour
{
	private void Awake()
	{
		this.target = Boat.Instance.rbTransform;
		this.dragonTransform = Dragon.Instance.transform;
		Invoke(nameof(StopCamera), 5f);
	}

	private void StopCamera()
	{
		base.gameObject.SetActive(false);
	}

	private void Update()
	{
		if (base.transform != this.dragonTransform && this.dragonTransform.position.y > this.target.transform.position.y)
		{
			this.target = this.dragonTransform;
		}
		Quaternion b = Quaternion.LookRotation(this.target.position - base.transform.position);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6f);
	}

	private Transform target;

	private Transform dragonTransform;
}
