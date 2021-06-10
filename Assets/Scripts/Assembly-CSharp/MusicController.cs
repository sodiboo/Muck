
using UnityEngine;

// Token: 0x02000050 RID: 80
public class MusicController : MonoBehaviour
{
	// Token: 0x060001C1 RID: 449 RVA: 0x0000A911 File Offset: 0x00008B11
	private void Awake()
	{
		MusicController.Instance = this;
		this.audio = base.GetComponent<AudioSource>();
	}

	// Token: 0x060001C2 RID: 450 RVA: 0x0000A925 File Offset: 0x00008B25
	private void Start()
	{
		this.targetVolume = CurrentSettings.Instance.music;
	}

	// Token: 0x060001C3 RID: 451 RVA: 0x0000A937 File Offset: 0x00008B37
	public void SetVolume(float f)
	{
		this.targetVolume = f;
		this.StartFade(this.audio, 0.1f, f);
	}

	// Token: 0x060001C4 RID: 452 RVA: 0x0000A954 File Offset: 0x00008B54
	public void PlaySong(MusicController.SongType s, bool chanceToSkip = true)
	{
		AudioClip audioClip = null;
		if (this.currentSong == MusicController.SongType.Boss && BossUI.Instance.currentBoss != null)
		{
			return;
		}
		this.currentSong = s;
		switch (s)
		{
		case MusicController.SongType.Day:
			if (!chanceToSkip || Random.Range(0f, 1f) <= 0.5f)
			{
				audioClip = this.day[Random.Range(0, this.day.Length)];
			}
			break;
		case MusicController.SongType.Night:
			audioClip = this.night[Random.Range(0, this.night.Length)];
			break;
		case MusicController.SongType.Boss:
			audioClip = this.boss[Random.Range(0, this.boss.Length)];
			break;
		}
		if (audioClip == null)
		{
			this.StartFade(this.audio, this.fadeTime, 0f);
			return;
		}
		if (this.audio.isPlaying)
		{
			this.queuedSong = audioClip;
			this.StartFade(this.audio, this.fadeTime, 0f);
			base.Invoke("NextSong", this.fadeTime);
			return;
		}
		this.NextSong(audioClip);
	}

	// Token: 0x060001C5 RID: 453 RVA: 0x0000AA5E File Offset: 0x00008C5E
	private void NextSong()
	{
		this.StartFade(this.audio, this.fadeTime, this.targetVolume);
		this.audio.clip = this.queuedSong;
		this.audio.Play();
	}

	// Token: 0x060001C6 RID: 454 RVA: 0x0000AA94 File Offset: 0x00008C94
	private void NextSong(AudioClip song)
	{
		this.StartFade(this.audio, this.fadeTime, this.targetVolume);
		this.audio.clip = song;
		this.audio.Play();
	}

	// Token: 0x060001C7 RID: 455 RVA: 0x0000AAC5 File Offset: 0x00008CC5
	public void StopSong()
	{
		this.StartFade(this.audio, this.fadeTime, 0f);
	}

	// Token: 0x060001C8 RID: 456 RVA: 0x0000AAE0 File Offset: 0x00008CE0
	private void Update()
	{
		this.currentTime += Time.deltaTime;
		this.audio.volume = Mathf.Lerp(this.startVolume, this.desiredVolume * this.targetVolume, this.currentTime / this.newFadeTime);
	}

	// Token: 0x060001C9 RID: 457 RVA: 0x0000AB2F File Offset: 0x00008D2F
	private void StartFade(AudioSource audioSource, float duration, float targetVolume)
	{
		this.currentTime = 0f;
		this.newFadeTime = duration;
		this.desiredVolume = targetVolume;
		this.startVolume = audioSource.volume;
	}

	// Token: 0x040001C1 RID: 449
	public AudioClip[] day;

	// Token: 0x040001C2 RID: 450
	public AudioClip[] night;

	// Token: 0x040001C3 RID: 451
	public AudioClip[] boss;

	// Token: 0x040001C4 RID: 452
	private AudioSource audio;

	// Token: 0x040001C5 RID: 453
	public static MusicController Instance;

	// Token: 0x040001C6 RID: 454
	private AudioClip queuedSong;

	// Token: 0x040001C7 RID: 455
	private float fadeTime = 6f;

	// Token: 0x040001C8 RID: 456
	private float targetVolume = 0.2f;

	// Token: 0x040001C9 RID: 457
	private MusicController.SongType currentSong;

	// Token: 0x040001CA RID: 458
	private float currentTime;

	// Token: 0x040001CB RID: 459
	private float newFadeTime;

	// Token: 0x040001CC RID: 460
	private float desiredVolume;

	// Token: 0x040001CD RID: 461
	private float startVolume;

	// Token: 0x0200010E RID: 270
	public enum SongType
	{
		// Token: 0x0400073A RID: 1850
		Day,
		// Token: 0x0400073B RID: 1851
		Night,
		// Token: 0x0400073C RID: 1852
		Boss
	}
}
