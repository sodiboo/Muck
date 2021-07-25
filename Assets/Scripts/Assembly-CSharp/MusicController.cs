using UnityEngine;

public class MusicController : MonoBehaviour
{
    public enum SongType
    {
        Day,
        Night,
        Boss,
        Bob
    }

    public AudioClip[] day;

    public AudioClip[] night;

    public AudioClip[] boss;

    public AudioClip bobTheme;

    private AudioSource audio;

    public static MusicController Instance;

    private AudioClip queuedSong;

    private float fadeTime = 6f;

    private float targetVolume = 0.2f;

    private SongType currentSong;

    private float currentTime;

    private float newFadeTime;

    private float desiredVolume;

    private float startVolume;

    private void Awake()
    {
        Instance = this;
        audio = GetComponent<AudioSource>();
    }

    private void Start()
    {
        targetVolume = CurrentSettings.Instance.music;
    }

    public void SetVolume(float f)
    {
        targetVolume = f;
        StartFade(audio, 0.1f, f);
    }

    public void PlaySong(SongType s, bool chanceToSkip = true)
    {
        if ((bool)GameManager.instance && GameManager.instance.boatLeft && s != SongType.Bob)
        {
            return;
        }
        AudioClip audioClip = null;
        if (currentSong == SongType.Boss && BossUI.Instance.currentBoss != null)
        {
            return;
        }
        currentSong = s;
        switch (s)
        {
        case SongType.Day:
            if (!chanceToSkip || !(Random.Range(0f, 1f) > 0.5f))
            {
                audioClip = day[Random.Range(0, day.Length)];
            }
            break;
        case SongType.Night:
            audioClip = night[Random.Range(0, night.Length)];
            break;
        case SongType.Boss:
            audioClip = boss[Random.Range(0, boss.Length)];
            break;
        case SongType.Bob:
            audioClip = bobTheme;
            break;
        }
        if (audioClip == null)
        {
            StartFade(audio, fadeTime, 0f);
        }
        else if (audio.isPlaying)
        {
            queuedSong = audioClip;
            StartFade(audio, fadeTime, 0f);
            Invoke(nameof(NextSong), fadeTime);
        }
        else
        {
            NextSong(audioClip);
        }
    }

    private void NextSong()
    {
        StartFade(audio, fadeTime, targetVolume);
        audio.clip = queuedSong;
        audio.Play();
    }

    private void NextSong(AudioClip song)
    {
        StartFade(audio, fadeTime, targetVolume);
        audio.clip = song;
        audio.Play();
    }

    public void StopSong(float fade = -1f)
    {
        float duration = fadeTime;
        if (fade >= 0f)
        {
            duration = fade;
        }
        StartFade(audio, duration, 0f);
    }

    public void FinalBoss()
    {
        float num = 0.5f;
        queuedSong = bobTheme;
        StartFade(audio, num, 0f);
        Invoke(nameof(BobTheme), num);
    }

    private void BobTheme()
    {
        StartFade(audio, 4f, targetVolume);
        audio.clip = queuedSong;
        audio.Play();
    }

    private void Update()
    {
        currentTime += Time.deltaTime;
        audio.volume = Mathf.Lerp(startVolume, desiredVolume * targetVolume, currentTime / newFadeTime);
    }

    private void StartFade(AudioSource audioSource, float duration, float targetVolume)
    {
        currentTime = 0f;
        newFadeTime = duration;
        desiredVolume = targetVolume;
        startVolume = audioSource.volume;
    }
}
