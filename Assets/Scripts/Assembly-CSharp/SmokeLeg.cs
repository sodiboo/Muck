using System;
using UnityEngine;

// Token: 0x020000DC RID: 220
public class SmokeLeg : MonoBehaviour
{
	// Token: 0x060006E7 RID: 1767 RVA: 0x00023F48 File Offset: 0x00022148
	private void OnTriggerEnter(Collider other)
	{
		if (!this.ready)
		{
			return;
		}
		if (other.gameObject.layer != LayerMask.NameToLayer("Ground"))
		{
			return;
		}
		this.ready = false;
		Invoke(nameof(GetReady), this.cooldown);
		Instantiate<GameObject>(this.smokeFx, base.transform.position, this.smokeFx.transform.rotation);
	}

	// Token: 0x060006E8 RID: 1768 RVA: 0x00023FB5 File Offset: 0x000221B5
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x04000656 RID: 1622
	public GameObject smokeFx;

	// Token: 0x04000657 RID: 1623
	public float cooldown;

	// Token: 0x04000658 RID: 1624
	private bool ready = true;
}
