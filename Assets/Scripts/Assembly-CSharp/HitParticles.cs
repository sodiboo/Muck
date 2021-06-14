using System;
using UnityEngine;

// Token: 0x02000040 RID: 64
public class HitParticles : MonoBehaviour
{
	// Token: 0x06000153 RID: 339 RVA: 0x0000CEC0 File Offset: 0x0000B0C0
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

	// Token: 0x06000154 RID: 340 RVA: 0x00003092 File Offset: 0x00001292
	private void Start()
	{
		if (!this.audioDone)
		{
			this.audio.Randomize(0f);
		}
	}

	// Token: 0x04000151 RID: 337
	public ParticleSystem[] particles;

	// Token: 0x04000152 RID: 338
	public RandomSfx audio;

	// Token: 0x04000153 RID: 339
	public AudioClip[] normalHit;

	// Token: 0x04000154 RID: 340
	public AudioClip[] critHit;

	// Token: 0x04000155 RID: 341
	private bool audioDone;
}
