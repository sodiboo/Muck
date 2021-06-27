using System;
using UnityEngine;

public class SmokeLeg : MonoBehaviour
{
	private void OnTriggerEnter(Collider other)
	{
		if (!this.ready)
		{
			return;
		}
		if (other.gameObject.layer != LayerMask.NameToLayer("Ground"))
		{
			return;
		}
		this.ready = false;
		Invoke(nameof(GetReady), this.cooldown);
		Instantiate<GameObject>(this.smokeFx, base.transform.position, this.smokeFx.transform.rotation);
	}

	private void GetReady()
	{
		this.ready = true;
	}

	public GameObject smokeFx;

	public float cooldown;

	private bool ready = true;
}
