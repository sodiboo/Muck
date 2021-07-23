using MilkShake;
using UnityEngine;

public class ShakeCamera : MonoBehaviour
{
    public ShakePreset customShake;

    public float maxDistance = 50f;

    public float shakeM;

    private void Start()
    {
        if ((bool)customShake)
        {
            CameraShaker.Instance.ShakeWithPreset(customShake);
            return;
        }
        float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
        if (!(num > maxDistance))
        {
            float num2 = 1f - num / maxDistance;
            float shakeRatio = shakeM * num2;
            CameraShaker.Instance.StepShake(shakeRatio);
        }
    }
}
