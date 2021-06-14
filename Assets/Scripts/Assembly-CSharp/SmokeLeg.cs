using System;
using UnityEngine;

// Token: 0x020000EF RID: 239
public class SmokeLeg : MonoBehaviour
{
	// Token: 0x06000665 RID: 1637 RVA: 0x00021D48 File Offset: 0x0001FF48
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
		base.Invoke("GetReady", this.cooldown);
	Instantiate<GameObject>(this.smokeFx, base.transform.position, this.smokeFx.transform.rotation);
	}

	// Token: 0x06000666 RID: 1638 RVA: 0x0000619B File Offset: 0x0000439B
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x04000637 RID: 1591
	public GameObject smokeFx;

	// Token: 0x04000638 RID: 1592
	public float cooldown;

	// Token: 0x04000639 RID: 1593
	private bool ready = true;
}
