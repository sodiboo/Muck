using MilkShake;
using UnityEngine;

public class CameraShaker : MonoBehaviour
{
    public ShakePreset damagePreset;

    public ShakePreset chargePreset;

    public ShakePreset stepShakePreset;

    private Shaker shaker;

    public static CameraShaker Instance;

    private void Awake()
    {
        Instance = this;
        shaker = GetComponent<Shaker>();
    }

    public void DamageShake(float shakeRatio)
    {
        if (CurrentSettings.cameraShake)
        {
            shakeRatio *= 2f;
            shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
            shaker.Shake(damagePreset).StrengthScale = shakeRatio;
        }
    }

    public void StepShake(float shakeRatio)
    {
        if (CurrentSettings.cameraShake)
        {
            shaker.Shake(stepShakePreset).StrengthScale = shakeRatio;
        }
    }

    public void ChargeShake(float shakeRatio)
    {
        if (CurrentSettings.cameraShake)
        {
            shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
            shaker.Shake(chargePreset).StrengthScale = shakeRatio;
        }
    }

    public void ShakeWithPreset(ShakePreset preset)
    {
        if (CurrentSettings.cameraShake)
        {
            shaker.Shake(preset);
        }
    }

    public void ShakeWithPresetAndRatio(ShakePreset preset, float shakeRatio)
    {
        if (CurrentSettings.cameraShake)
        {
            shakeRatio *= 2f;
            shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
            shaker.Shake(preset).StrengthScale = shakeRatio;
        }
    }
}
