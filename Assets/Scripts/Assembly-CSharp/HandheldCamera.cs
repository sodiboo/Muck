using System;
using MilkShake;
using UnityEngine;

// Token: 0x0200003C RID: 60
public class HandheldCamera : MonoBehaviour
{
	// Token: 0x06000144 RID: 324 RVA: 0x0000C790 File Offset: 0x0000A990
	private void Start()
	{
		this.shaker = base.GetComponent<Shaker>();
		this.shaker.Shake(this.cameraShake, null);
	}

	// Token: 0x04000142 RID: 322
	public ShakePreset cameraShake;

	// Token: 0x04000143 RID: 323
	private Shaker shaker;
}
