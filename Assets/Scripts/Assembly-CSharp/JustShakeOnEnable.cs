using MilkShake;
using UnityEngine;

public class JustShakeOnEnable : MonoBehaviour
{
    public ShakePreset customShake;

    public float maxDistance = 50f;

    public float shakeM;

    public bool customAndDist;

    private void OnEnable()
    {
        if ((bool)customShake && !customAndDist)
        {
            CameraShaker.Instance.ShakeWithPreset(customShake);
            return;
        }
        float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
        if (!(num > maxDistance))
        {
            float num2 = 1f - num / maxDistance;
            float shakeRatio = shakeM * num2;
            if (customAndDist)
            {
                CameraShaker.Instance.ShakeWithPresetAndRatio(customShake, shakeRatio);
            }
            CameraShaker.Instance.StepShake(shakeRatio);
        }
    }
}
