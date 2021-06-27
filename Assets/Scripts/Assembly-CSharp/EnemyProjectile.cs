using System;
using UnityEngine;

public class EnemyProjectile : MonoBehaviour
{
	public int damage { get; set; }

	private void Awake()
	{
		Invoke(nameof(DestroySelf), 10f);
	}

	public void DisableCollider(float time)
	{
		if (!base.GetComponent<Collider>())
		{
			return;
		}
		base.GetComponent<Collider>().enabled = false;
		Invoke(nameof(ActivateCollider), time);
	}

	private void ActivateCollider()
	{
		base.GetComponent<Collider>().enabled = true;
	}

	private void OnCollisionEnter(Collision other)
	{
		int layer = other.gameObject.layer;
		if (this.ignoreGround && other.collider.gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			return;
		}
		if (this.collideWithPlayerAndBuildOnly && layer != LayerMask.NameToLayer("Player") && layer != LayerMask.NameToLayer("Object"))
		{
			return;
		}
		if (this.done)
		{
			return;
		}
		this.done = true;
		bool hitPlayer = layer == LayerMask.NameToLayer("Player") && other.gameObject.CompareTag("Local");
		if (LocalClient.serverOwner && layer == LayerMask.NameToLayer("Object"))
		{
			other.gameObject.CompareTag("Build");
		}
		Destroy(base.gameObject);
		if (Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position) < this.hideFxDistance)
		{
			GameObject gameObject = Instantiate<GameObject>(this.hitFx, base.transform.position, Quaternion.LookRotation(other.GetContact(0).normal));
			gameObject.transform.rotation = Quaternion.LookRotation(other.GetContact(0).normal);
			ImpactDamage componentInChildren = gameObject.GetComponentInChildren<ImpactDamage>();
			componentInChildren.SetDamage(this.damage);
			componentInChildren.hitPlayer = hitPlayer;
			if (this.spawnPos)
			{
				gameObject.transform.position = this.spawnPos.position;
			}
		}
	}

	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	public GameObject hitFx;

	private bool done;

	public bool collideWithPlayerAndBuildOnly;

	public bool ignoreGround;

	public Transform spawnPos;

	public float hideFxDistance = 40f;
}
