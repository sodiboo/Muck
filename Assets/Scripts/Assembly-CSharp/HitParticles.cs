using System;
using UnityEngine;

public class HitParticles : MonoBehaviour
{
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

	private void Start()
	{
		if (this.audio != null && !this.audioDone)
		{
			this.audio.Randomize(0f);
		}
	}

	public ParticleSystem[] particles;

	public RandomSfx audio;

	public AudioClip[] normalHit;

	public AudioClip[] critHit;

	private bool audioDone;
}
