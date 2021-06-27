using System;
using MilkShake;
using UnityEngine;

// Token: 0x02000106 RID: 262
public class ShakeOnEnable : MonoBehaviour
{
	// Token: 0x060007B3 RID: 1971 RVA: 0x00027933 File Offset: 0x00025B33
	private void OnEnable()
	{
		this.sfx.Play();
		CameraShaker.Instance.ShakeWithPreset(this.preset);
		if (this.hitbox)
		{
			this.hitbox.Reset();
		}
	}

	// Token: 0x0400076E RID: 1902
	public AudioSource sfx;

	// Token: 0x0400076F RID: 1903
	public ShakePreset preset;

	// Token: 0x04000770 RID: 1904
	public HitboxDamage hitbox;
}
