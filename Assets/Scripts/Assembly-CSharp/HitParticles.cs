using System;
using UnityEngine;

// Token: 0x0200004C RID: 76
public class HitParticles : MonoBehaviour
{
	// Token: 0x060001B7 RID: 439 RVA: 0x0000AB04 File Offset: 0x00008D04
	public void SetEffect(HitEffect effect)
	{
		foreach (ParticleSystem particleSystem in this.particles)
		{
			var sys = particleSystem.main;
			sys.startColor = HitEffectExtension.GetColor(effect);
			ParticleSystem.EmissionModule emission = particleSystem.emission;
			ParticleSystem.Burst burst = emission.GetBurst(0);
			ParticleSystem.MinMaxCurve count = burst.count;
			count.constant *= 2f;
			burst.count = count;
			emission.SetBurst(0, burst);
		}
		this.audioDone = true;
		this.audio.sounds = this.critHit;
		this.audio.Randomize(0f);
	}

	// Token: 0x060001B8 RID: 440 RVA: 0x0000ABA9 File Offset: 0x00008DA9
	private void Start()
	{
		if (this.audio != null && !this.audioDone)
		{
			this.audio.Randomize(0f);
		}
	}

	// Token: 0x040001BC RID: 444
	public ParticleSystem[] particles;

	// Token: 0x040001BD RID: 445
	public RandomSfx audio;

	// Token: 0x040001BE RID: 446
	public AudioClip[] normalHit;

	// Token: 0x040001BF RID: 447
	public AudioClip[] critHit;

	// Token: 0x040001C0 RID: 448
	private bool audioDone;
}
