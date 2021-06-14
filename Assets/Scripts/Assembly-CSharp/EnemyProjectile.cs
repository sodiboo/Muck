using System;
using UnityEngine;

// Token: 0x02000028 RID: 40
public class EnemyProjectile : MonoBehaviour
{
	// Token: 0x17000008 RID: 8
	// (get) Token: 0x060000D3 RID: 211 RVA: 0x00002B82 File Offset: 0x00000D82
	// (set) Token: 0x060000D4 RID: 212 RVA: 0x00002B8A File Offset: 0x00000D8A
	public int damage { get; set; }

	// Token: 0x060000D5 RID: 213 RVA: 0x00002B93 File Offset: 0x00000D93
	private void Awake()
	{
		base.Invoke("DestroySelf", 10f);
	}

	// Token: 0x060000D6 RID: 214 RVA: 0x00002BA5 File Offset: 0x00000DA5
	public void DisableCollider(float time)
	{
		base.GetComponent<Collider>().enabled = false;
		base.Invoke("ActivateCollider", time);
	}

	// Token: 0x060000D7 RID: 215 RVA: 0x00002BBF File Offset: 0x00000DBF
	private void ActivateCollider()
	{
		base.GetComponent<Collider>().enabled = true;
	}

	// Token: 0x060000D8 RID: 216 RVA: 0x0000A884 File Offset: 0x00008A84
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
			GameObject gameObject =Instantiate<GameObject>(this.hitFx, base.transform.position, Quaternion.LookRotation(other.GetContact(0).normal));
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

	// Token: 0x060000D9 RID: 217 RVA: 0x00002AC8 File Offset: 0x00000CC8
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x040000DD RID: 221
	public GameObject hitFx;

	// Token: 0x040000DE RID: 222
	private bool done;

	// Token: 0x040000DF RID: 223
	public bool collideWithPlayerAndBuildOnly;

	// Token: 0x040000E0 RID: 224
	public bool ignoreGround;

	// Token: 0x040000E1 RID: 225
	public Transform spawnPos;

	// Token: 0x040000E3 RID: 227
	public float hideFxDistance = 40f;
}
