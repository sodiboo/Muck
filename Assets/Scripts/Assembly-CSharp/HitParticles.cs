
using UnityEngine;

// Token: 0x02000033 RID: 51
public class HitParticles : MonoBehaviour
{
	// Token: 0x0600012C RID: 300 RVA: 0x0000817C File Offset: 0x0000637C
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

	// Token: 0x0600012D RID: 301 RVA: 0x00008221 File Offset: 0x00006421
	private void Start()
	{
		if (!this.audioDone)
		{
			this.audio.Randomize(0f);
		}
	}

	// Token: 0x0400011C RID: 284
	public ParticleSystem[] particles;

	// Token: 0x0400011D RID: 285
	public RandomSfx audio;

	// Token: 0x0400011E RID: 286
	public AudioClip[] normalHit;

	// Token: 0x0400011F RID: 287
	public AudioClip[] critHit;

	// Token: 0x04000120 RID: 288
	private bool audioDone;
}
