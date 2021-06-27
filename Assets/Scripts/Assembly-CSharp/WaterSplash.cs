using System;
using UnityEngine;

public class WaterSplash : MonoBehaviour
{
	private void Awake()
	{
		InvokeRepeating(nameof(SlowUpdate), 0.15f, 0.15f);
	}

	private void SlowUpdate()
	{
		float y = World.Instance.water.transform.position.y;
		Vector3 position = base.transform.position;
		if (this.lastPos.y < y)
		{
			if (position.y > y)
			{
				Vector3 forward = position - this.lastPos;
				Instantiate<GameObject>(this.splashFx, base.transform.position, Quaternion.LookRotation(forward));
			}
		}
		else if (position.y < y)
		{
			Vector3 forward2 = position - this.lastPos;
			Instantiate<GameObject>(this.splashFx, base.transform.position, Quaternion.LookRotation(forward2));
		}
		this.lastPos = position;
	}

	public GameObject splashFx;

	private Rigidbody rb;

	private Vector3 lastPos;
}
