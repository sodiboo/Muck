
using UnityEngine;

// Token: 0x0200004E RID: 78
public class MoveCameraTowards : MonoBehaviour
{
	// Token: 0x060001BB RID: 443 RVA: 0x0000A88E File Offset: 0x00008A8E
	private void Awake()
	{
		base.Invoke("SetReady", 1f);
	}

	// Token: 0x060001BC RID: 444 RVA: 0x0000A8A0 File Offset: 0x00008AA0
	private void SetReady()
	{
		this.ready = true;
	}

	// Token: 0x060001BD RID: 445 RVA: 0x0000A8A9 File Offset: 0x00008AA9
	private void Update()
	{
		if (!this.ready)
		{
			return;
		}
		base.transform.position = Vector3.Lerp(base.transform.position, this.target.position, Time.deltaTime * this.speed);
	}

	// Token: 0x040001BD RID: 445
	public float speed = 1f;

	// Token: 0x040001BE RID: 446
	public Transform target;

	// Token: 0x040001BF RID: 447
	private bool ready;
}
