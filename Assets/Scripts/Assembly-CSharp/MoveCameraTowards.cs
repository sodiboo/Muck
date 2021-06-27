using System;
using UnityEngine;

// Token: 0x0200006B RID: 107
public class MoveCameraTowards : MonoBehaviour
{
	// Token: 0x06000267 RID: 615 RVA: 0x0000E122 File Offset: 0x0000C322
	private void Awake()
	{
		Invoke(nameof(SetReady), 1f);
	}

	// Token: 0x06000268 RID: 616 RVA: 0x0000E134 File Offset: 0x0000C334
	private void SetReady()
	{
		this.ready = true;
	}

	// Token: 0x06000269 RID: 617 RVA: 0x0000E13D File Offset: 0x0000C33D
	private void Update()
	{
		if (!this.ready)
		{
			return;
		}
		base.transform.position = Vector3.Lerp(base.transform.position, this.target.position, Time.deltaTime * this.speed);
	}

	// Token: 0x04000282 RID: 642
	public float speed = 1f;

	// Token: 0x04000283 RID: 643
	public Transform target;

	// Token: 0x04000284 RID: 644
	private bool ready;
}
