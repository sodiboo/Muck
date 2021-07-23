using MilkShake;
using UnityEngine;

public class HandheldCamera : MonoBehaviour
{
    public ShakePreset cameraShake;

    private Shaker shaker;

    private void Start()
    {
        shaker = GetComponent<Shaker>();
        shaker.Shake(cameraShake);
    }
}
