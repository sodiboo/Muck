
using UnityEngine;

// Token: 0x02000022 RID: 34
public class EnemyProjectile : MonoBehaviour
{
	// Token: 0x17000007 RID: 7
	// (get) Token: 0x060000C7 RID: 199 RVA: 0x00006055 File Offset: 0x00004255
	// (set) Token: 0x060000C8 RID: 200 RVA: 0x0000605D File Offset: 0x0000425D
	public int damage { get; set; }

	// Token: 0x060000C9 RID: 201 RVA: 0x00006066 File Offset: 0x00004266
	private void Awake()
	{
		base.Invoke("DestroySelf", 10f);
	}

	// Token: 0x060000CA RID: 202 RVA: 0x00006078 File Offset: 0x00004278
	public void DisableCollider(float time)
	{
		base.GetComponent<Collider>().enabled = false;
		base.Invoke("ActivateCollider", time);
	}

	// Token: 0x060000CB RID: 203 RVA: 0x00006092 File Offset: 0x00004292
	private void ActivateCollider()
	{
		base.GetComponent<Collider>().enabled = true;
	}

	// Token: 0x060000CC RID: 204 RVA: 0x000060A0 File Offset: 0x000042A0
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
			GameObject gameObject =Instantiate(this.hitFx, base.transform.position, Quaternion.LookRotation(other.GetContact(0).normal));
			gameObject.transform.rotation = Quaternion.LookRotation(other.GetContact(0).normal);
			ImpactDamage componentInChildren = gameObject.GetComponentInChildren<ImpactDamage>();
			componentInChildren.SetDamage(this.damage);
			componentInChildren.hitPlayer = hitPlayer;
		}
	}

	// Token: 0x060000CD RID: 205 RVA: 0x000057CD File Offset: 0x000039CD
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x040000C9 RID: 201
	public GameObject hitFx;

	// Token: 0x040000CA RID: 202
	private bool done;

	// Token: 0x040000CB RID: 203
	public bool collideWithPlayerAndBuildOnly;

	// Token: 0x040000CC RID: 204
	public bool ignoreGround;

	// Token: 0x040000CE RID: 206
	public float hideFxDistance = 40f;
}
