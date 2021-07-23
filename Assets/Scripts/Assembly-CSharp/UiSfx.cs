using UnityEngine;

public class UiSfx : MonoBehaviour
{
    public AudioSource audio;

    public AudioClip openInventory;

    public AudioClip closeInventory;

    public AudioClip pickupItem;

    public AudioClip armor;

    public AudioClip hover;

    public AudioClip click;

    public AudioClip tutorialTask;

    public static UiSfx Instance;

    private void Awake()
    {
        Instance = this;
    }

    public void PlayInventory(bool open)
    {
        if (open)
        {
            audio.clip = openInventory;
        }
        else
        {
            audio.clip = closeInventory;
        }
        audio.volume = 0.1f;
        audio.pitch = Random.Range(0.8f, 1.2f);
        audio.Play();
    }

    public void PlayPickup()
    {
        audio.clip = pickupItem;
        audio.volume = 0.3f;
        audio.pitch = Random.Range(0.8f, 1.2f);
        audio.Play();
    }

    public void PlayArmor()
    {
        audio.clip = armor;
        audio.volume = 0.55f;
        audio.pitch = Random.Range(0.8f, 1.2f);
        audio.Play();
    }

    public void PlayClick()
    {
        audio.clip = hover;
        audio.volume = 0.65f;
        audio.pitch = Random.Range(0.6f, 0.7f);
        audio.Play();
    }

    public void PlayTaskComplete()
    {
        audio.clip = tutorialTask;
        audio.volume = 0.35f;
        audio.pitch = Random.Range(0.9f, 1.2f);
        audio.Play();
    }
}
