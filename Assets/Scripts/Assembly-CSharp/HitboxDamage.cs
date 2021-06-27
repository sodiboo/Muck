using System;
using System.Collections.Generic;
using UnityEngine;

public class HitboxDamage : MonoBehaviour
{
	private void Awake()
	{
		if (!this.dontStopHitbox)
		{
			Invoke(nameof(DisableHitbox), this.hitboxTime);
		}
	}

	private void DisableHitbox()
	{
		base.GetComponent<Collider>().enabled = false;
	}

	public void Reset()
	{
		this.alreadyHit = new List<GameObject>();
		this.playerHit = false;
	}

	private void OnTriggerEnter(Collider other)
	{
		if (this.alreadyHit.Contains(other.gameObject))
		{
			return;
		}
		this.alreadyHit.Add(other.gameObject);
		if (other.gameObject.layer == LayerMask.NameToLayer("Player"))
		{
			if (this.playerHit)
			{
				return;
			}
			if (!other.CompareTag("Local"))
			{
				return;
			}
			if (!PlayerMovement.Instance)
			{
				return;
			}
			if (GameManager.players[LocalClient.instance.myId].dead)
			{
				return;
			}
			this.playerHit = true;
			ClientSend.PlayerHit((int)((float)this.baseDamage * this.multiplier), LocalClient.instance.myId, 0f, 0, base.transform.position);
			PlayerMovement.Instance.grounded = false;
			PlayerMovement.Instance.GetRb().velocity += this.pushPlayer;
			PlayerMovement.Instance.PushPlayer();
			return;
		}
		else
		{
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
			return;
		}
	}

	public void SetDamage(int damage)
	{
		this.baseDamage = damage;
	}

	public bool dontStopHitbox;

	public int baseDamage;

	private float multiplier = 1f;

	private List<GameObject> alreadyHit = new List<GameObject>();

	public Vector3 pushPlayer;

	public float hitboxTime = 0.15f;

	private bool playerHit;
}
