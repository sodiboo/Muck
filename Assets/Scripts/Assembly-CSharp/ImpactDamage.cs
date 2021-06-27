using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200004F RID: 79
public class ImpactDamage : MonoBehaviour
{
	// Token: 0x060001C3 RID: 451 RVA: 0x0000B1C0 File Offset: 0x000093C0
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

	// Token: 0x060001C4 RID: 452 RVA: 0x0000B2BC File Offset: 0x000094BC
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

	// Token: 0x060001C5 RID: 453 RVA: 0x0000B36C File Offset: 0x0000956C
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		Gizmos.DrawWireSphere(base.transform.position, this.radius);
	}

	// Token: 0x060001C6 RID: 454 RVA: 0x0000B38E File Offset: 0x0000958E
	public void SetDamage(int damage)
	{
		this.baseDamage = damage;
	}

	// Token: 0x040001D7 RID: 471
	public float radius = 1f;

	// Token: 0x040001D8 RID: 472
	public int baseDamage;

	// Token: 0x040001D9 RID: 473
	public bool hitPlayer;

	// Token: 0x040001DA RID: 474
	public bool decreaseWithDistance;

	// Token: 0x040001DB RID: 475
	private float multiplier = 1f;

	// Token: 0x040001DC RID: 476
	private List<GameObject> alreadyHit = new List<GameObject>();

	// Token: 0x040001DD RID: 477
	private bool race;
}
