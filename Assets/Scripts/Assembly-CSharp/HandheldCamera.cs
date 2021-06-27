using System;
using MilkShake;
using UnityEngine;

// Token: 0x02000049 RID: 73
public class HandheldCamera : MonoBehaviour
{
	// Token: 0x060001AB RID: 427 RVA: 0x0000A39C File Offset: 0x0000859C
	private void Start()
	{
		this.shaker = base.GetComponent<Shaker>();
		this.shaker.Shake(this.cameraShake, null);
	}

	// Token: 0x040001AF RID: 431
	public ShakePreset cameraShake;

	// Token: 0x040001B0 RID: 432
	private Shaker shaker;
}
