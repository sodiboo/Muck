using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000042 RID: 66
public class ImpactDamage : MonoBehaviour
{
	// Token: 0x06000159 RID: 345 RVA: 0x0000D354 File Offset: 0x0000B554
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

	// Token: 0x0600015A RID: 346 RVA: 0x0000D45C File Offset: 0x0000B65C
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

	// Token: 0x0600015B RID: 347 RVA: 0x000030E0 File Offset: 0x000012E0
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		Gizmos.DrawWireSphere(base.transform.position, this.radius);
	}

	// Token: 0x0600015C RID: 348 RVA: 0x00003102 File Offset: 0x00001302
	public void SetDamage(int damage)
	{
		this.baseDamage = damage;
	}

	// Token: 0x04000165 RID: 357
	public float radius = 1f;

	// Token: 0x04000166 RID: 358
	public int baseDamage;

	// Token: 0x04000167 RID: 359
	public bool hitPlayer;

	// Token: 0x04000168 RID: 360
	public bool decreaseWithDistance;

	// Token: 0x04000169 RID: 361
	private float multiplier = 1f;

	// Token: 0x0400016A RID: 362
	private List<GameObject> alreadyHit = new List<GameObject>();

	// Token: 0x0400016B RID: 363
	private bool race;
}
