using System;
using System.Collections.Generic;
using UnityEngine;

public class ImpactDamage : MonoBehaviour
{
	private void Start()
	{
		if (this.race)
		{
			Destroy(base.gameObject);
		}
		else
		{
			this.race = true;
		}
		if (!PlayerMovement.Instance)
		{
			return;
		}
		if (GameManager.players[LocalClient.instance.myId].dead)
		{
			return;
		}
		float num = Vector3.Distance(PlayerMovement.Instance.transform.position, base.transform.position);
		if (this.hitPlayer)
		{
			num = 0f;
		}
		if (num > this.radius)
		{
			return;
		}
		num = Mathf.Clamp(num - 1f, 0f, this.radius);
		float num2 = (this.radius - num) / this.radius;
		num2 = Mathf.Clamp(num2, 0f, 1f);
		if (!this.decreaseWithDistance)
		{
			num2 = 1f;
		}
		ClientSend.PlayerHit((int)((float)this.baseDamage * num2), LocalClient.instance.myId, 0f, 0, base.transform.position);
	}

	private void OnTriggerEnter(Collider other)
	{
		if (this.alreadyHit.Contains(other.gameObject))
		{
			return;
		}
		this.alreadyHit.Add(other.gameObject);
		if (this.race)
		{
			Destroy(base.gameObject);
		}
		else
		{
			this.race = true;
		}
		if (!LocalClient.serverOwner)
		{
			return;
		}
		Hitable componentInChildren = other.transform.root.GetComponentInChildren<Hitable>();
		if (!componentInChildren)
		{
			return;
		}
		float num = 0.5f;
		componentInChildren.Hit((int)((float)this.baseDamage * num * this.multiplier), 0f, 0, base.transform.position);
		this.multiplier *= 0.5f;
	}

	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		Gizmos.DrawWireSphere(base.transform.position, this.radius);
	}

	public void SetDamage(int damage)
	{
		this.baseDamage = damage;
	}

	public float radius = 1f;

	public int baseDamage;

	public bool hitPlayer;

	public bool decreaseWithDistance;

	private float multiplier = 1f;

	private List<GameObject> alreadyHit = new List<GameObject>();

	private bool race;
}
