using UnityEngine;

public class ChestSfx : MonoBehaviour
{
    public AudioClip open;

    public AudioClip close;

    private AudioSource audio;

    private void Awake()
    {
        audio = GetComponent<AudioSource>();
    }

    public void OpenChest()
    {
        audio.clip = open;
        audio.Play();
    }

    public void CloseChest()
    {
        audio.clip = close;
        audio.Play();
    }
}
