using UnityEngine;

public class SfxOnEnable : MonoBehaviour
{
    public AudioSource sfx;

    private void OnEnable()
    {
        sfx.Play();
    }
}
