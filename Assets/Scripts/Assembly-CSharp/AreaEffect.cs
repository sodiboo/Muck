using System;
using System.Collections.Generic;
using UnityEngine;

public class AreaEffect : MonoBehaviour
{
	public void SetDamage(int d)
	{
		this.damage = d;
		base.GetComponent<Collider>().enabled = true;
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Build"))
		{
			return;
		}
		Hitable component = other.GetComponent<Hitable>();
		if (component == null)
		{
			return;
		}
		if (other.transform.root.CompareTag("Local"))
		{
			return;
		}
		component.Hit(this.damage, 0f, 3, base.transform.position);
		Destroy(this);
	}

	private int damage;

	private List<GameObject> actorsHit;
}
