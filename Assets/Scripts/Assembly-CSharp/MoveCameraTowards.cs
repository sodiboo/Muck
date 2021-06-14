using System;
using UnityEngine;

// Token: 0x0200005C RID: 92
public class MoveCameraTowards : MonoBehaviour
{
	// Token: 0x060001E4 RID: 484 RVA: 0x0000367D File Offset: 0x0000187D
	private void Awake()
	{
		base.Invoke(nameof(SetReady), 1f);
	}

	// Token: 0x060001E5 RID: 485 RVA: 0x0000368F File Offset: 0x0000188F
	private void SetReady()
	{
		this.ready = true;
	}

	// Token: 0x060001E6 RID: 486 RVA: 0x00003698 File Offset: 0x00001898
	private void Update()
	{
		if (!this.ready)
		{
			return;
		}
		base.transform.position = Vector3.Lerp(base.transform.position, this.target.position, Time.deltaTime * this.speed);
	}

	// Token: 0x040001F9 RID: 505
	public float speed = 1f;

	// Token: 0x040001FA RID: 506
	public Transform target;

	// Token: 0x040001FB RID: 507
	private bool ready;
}
