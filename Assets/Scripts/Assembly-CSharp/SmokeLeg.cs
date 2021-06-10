
using UnityEngine;

// Token: 0x020000B4 RID: 180
public class SmokeLeg : MonoBehaviour
{
	// Token: 0x060005D2 RID: 1490 RVA: 0x0001E100 File Offset: 0x0001C300
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
	Instantiate(this.smokeFx, base.transform.position, this.smokeFx.transform.rotation);
	}

	// Token: 0x060005D3 RID: 1491 RVA: 0x0001E16D File Offset: 0x0001C36D
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x0400053B RID: 1339
	public GameObject smokeFx;

	// Token: 0x0400053C RID: 1340
	public float cooldown;

	// Token: 0x0400053D RID: 1341
	private bool ready = true;
}
