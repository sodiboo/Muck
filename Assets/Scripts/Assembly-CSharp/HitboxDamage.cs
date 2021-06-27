using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200004E RID: 78
public class HitboxDamage : MonoBehaviour
{
	// Token: 0x060001BD RID: 445 RVA: 0x0000AFF4 File Offset: 0x000091F4
	private void Awake()
	{
		if (!this.dontStopHitbox)
		{
			Invoke(nameof(DisableHitbox), this.hitboxTime);
		}
	}

	// Token: 0x060001BE RID: 446 RVA: 0x0000B00F File Offset: 0x0000920F
	private void DisableHitbox()
	{
		base.GetComponent<Collider>().enabled = false;
	}

	// Token: 0x060001BF RID: 447 RVA: 0x0000B01D File Offset: 0x0000921D
	public void Reset()
	{
		this.alreadyHit = new List<GameObject>();
		this.playerHit = false;
	}

	// Token: 0x060001C0 RID: 448 RVA: 0x0000B034 File Offset: 0x00009234
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

	// Token: 0x060001C1 RID: 449 RVA: 0x0000B18E File Offset: 0x0000938E
	public void SetDamage(int damage)
	{
		this.baseDamage = damage;
	}

	// Token: 0x040001D0 RID: 464
	public bool dontStopHitbox;

	// Token: 0x040001D1 RID: 465
	public int baseDamage;

	// Token: 0x040001D2 RID: 466
	private float multiplier = 1f;

	// Token: 0x040001D3 RID: 467
	private List<GameObject> alreadyHit = new List<GameObject>();

	// Token: 0x040001D4 RID: 468
	public Vector3 pushPlayer;

	// Token: 0x040001D5 RID: 469
	public float hitboxTime = 0.15f;

	// Token: 0x040001D6 RID: 470
	private bool playerHit;
}
