using System;
using UnityEngine;

// Token: 0x02000030 RID: 48
public class EnemyProjectile : MonoBehaviour
{
	// Token: 0x1700000D RID: 13
	// (get) Token: 0x06000119 RID: 281 RVA: 0x000074C9 File Offset: 0x000056C9
	// (set) Token: 0x0600011A RID: 282 RVA: 0x000074D1 File Offset: 0x000056D1
	public int damage { get; set; }

	// Token: 0x0600011B RID: 283 RVA: 0x000074DA File Offset: 0x000056DA
	private void Awake()
	{
		Invoke(nameof(DestroySelf), 10f);
	}

	// Token: 0x0600011C RID: 284 RVA: 0x000074EC File Offset: 0x000056EC
	public void DisableCollider(float time)
	{
		if (!base.GetComponent<Collider>())
		{
			return;
		}
		base.GetComponent<Collider>().enabled = false;
		Invoke(nameof(ActivateCollider), time);
	}

	// Token: 0x0600011D RID: 285 RVA: 0x00007514 File Offset: 0x00005714
	private void ActivateCollider()
	{
		base.GetComponent<Collider>().enabled = true;
	}

	// Token: 0x0600011E RID: 286 RVA: 0x00007524 File Offset: 0x00005724
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

	// Token: 0x0600011F RID: 287 RVA: 0x00006759 File Offset: 0x00004959
	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x04000123 RID: 291
	public GameObject hitFx;

	// Token: 0x04000124 RID: 292
	private bool done;

	// Token: 0x04000125 RID: 293
	public bool collideWithPlayerAndBuildOnly;

	// Token: 0x04000126 RID: 294
	public bool ignoreGround;

	// Token: 0x04000127 RID: 295
	public Transform spawnPos;

	// Token: 0x04000129 RID: 297
	public float hideFxDistance = 40f;
}
