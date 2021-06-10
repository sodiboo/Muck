
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000035 RID: 53
public class ImpactDamage : MonoBehaviour
{
	// Token: 0x06000132 RID: 306 RVA: 0x0000865C File Offset: 0x0000685C
	private void Start()
	{
		if (this.race)
		{
		Destroy(base.gameObject);
			MonoBehaviour.print("destroying deu to race");
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

	// Token: 0x06000133 RID: 307 RVA: 0x00008764 File Offset: 0x00006964
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

	// Token: 0x06000134 RID: 308 RVA: 0x00008814 File Offset: 0x00006A14
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		Gizmos.DrawWireSphere(base.transform.position, this.radius);
	}

	// Token: 0x06000135 RID: 309 RVA: 0x00008836 File Offset: 0x00006A36
	public void SetDamage(int damage)
	{
		this.baseDamage = damage;
	}

	// Token: 0x04000130 RID: 304
	public float radius = 1f;

	// Token: 0x04000131 RID: 305
	public int baseDamage;

	// Token: 0x04000132 RID: 306
	public bool hitPlayer;

	// Token: 0x04000133 RID: 307
	public bool decreaseWithDistance;

	// Token: 0x04000134 RID: 308
	private float multiplier = 1f;

	// Token: 0x04000135 RID: 309
	private List<GameObject> alreadyHit = new List<GameObject>();

	// Token: 0x04000136 RID: 310
	private bool race;
}
