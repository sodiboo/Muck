using MilkShake;
using UnityEngine;

public class ShakeOnEnable : MonoBehaviour
{
    public AudioSource sfx;

    public ShakePreset preset;

    public HitboxDamage hitbox;

    private void OnEnable()
    {
        if ((bool)sfx)
        {
            sfx.Play();
        }
        CameraShaker.Instance.ShakeWithPreset(preset);
        if ((bool)hitbox)
        {
            hitbox.Reset();
        }
    }
}
