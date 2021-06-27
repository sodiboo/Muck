using System;
using UnityEngine;

public class MoveCameraTowards : MonoBehaviour
{
	private void Awake()
	{
		Invoke(nameof(SetReady), 1f);
	}

	private void SetReady()
	{
		this.ready = true;
	}

	private void Update()
	{
		if (!this.ready)
		{
			return;
		}
		base.transform.position = Vector3.Lerp(base.transform.position, this.target.position, Time.deltaTime * this.speed);
	}

	public float speed = 1f;

	public Transform target;

	private bool ready;
}
