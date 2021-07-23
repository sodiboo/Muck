using UnityEngine;

public class HitParticles : MonoBehaviour
{
    public ParticleSystem[] particles;

    public RandomSfx audio;

    public AudioClip[] normalHit;

    public AudioClip[] critHit;

    private bool audioDone;

    public void SetEffect(HitEffect effect)
    {
        ParticleSystem[] array = particles;
        foreach (ParticleSystem obj in array)
        {
            ParticleSystem.MainModule main = obj.main;
            main.startColor = HitEffectExtension.GetColor(effect);
            ParticleSystem.EmissionModule emission = obj.emission;
            ParticleSystem.Burst burst = emission.GetBurst(0);
            ParticleSystem.MinMaxCurve count = burst.count;
            count.constant *= 2f;
            burst.count = count;
            emission.SetBurst(0, burst);
        }
        audioDone = true;
        audio.sounds = critHit;
        audio.Randomize(0f);
    }

    private void Start()
    {
        if (audio != null && !audioDone)
        {
            audio.Randomize(0f);
        }
    }
}
