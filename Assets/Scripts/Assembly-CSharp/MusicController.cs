using UnityEngine;

// Token: 0x0200005E RID: 94
public class MusicController : MonoBehaviour
{
	// Token: 0x060001EA RID: 490 RVA: 0x00003700 File Offset: 0x00001900
	private void Awake()
	{
		MusicController.Instance = this;
		this.audio = base.GetComponent<AudioSource>();
	}

	// Token: 0x060001EB RID: 491 RVA: 0x00003714 File Offset: 0x00001914
	private void Start()
	{
		this.targetVolume = CurrentSettings.Instance.music;
	}

	// Token: 0x060001EC RID: 492 RVA: 0x00003726 File Offset: 0x00001926
	public void SetVolume(float f)
	{
		this.targetVolume = f;
		this.StartFade(this.audio, 0.1f, f);
	}

	// Token: 0x060001ED RID: 493 RVA: 0x0000F170 File Offset: 0x0000D370
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

	// Token: 0x060001EE RID: 494 RVA: 0x00003741 File Offset: 0x00001941
	private void NextSong()
	{
		this.StartFade(this.audio, this.fadeTime, this.targetVolume);
		this.audio.clip = this.queuedSong;
		this.audio.Play();
	}

	// Token: 0x060001EF RID: 495 RVA: 0x00003777 File Offset: 0x00001977
	private void NextSong(AudioClip song)
	{
		this.StartFade(this.audio, this.fadeTime, this.targetVolume);
		this.audio.clip = song;
		this.audio.Play();
	}

	// Token: 0x060001F0 RID: 496 RVA: 0x000037A8 File Offset: 0x000019A8
	public void StopSong()
	{
		this.StartFade(this.audio, this.fadeTime, 0f);
	}

	// Token: 0x060001F1 RID: 497 RVA: 0x0000F27C File Offset: 0x0000D47C
	private void Update()
	{
		this.currentTime += Time.deltaTime;
		this.audio.volume = Mathf.Lerp(this.startVolume, this.desiredVolume * this.targetVolume, this.currentTime / this.newFadeTime);
	}

	// Token: 0x060001F2 RID: 498 RVA: 0x000037C1 File Offset: 0x000019C1
	private void StartFade(AudioSource audioSource, float duration, float targetVolume)
	{
		this.currentTime = 0f;
		this.newFadeTime = duration;
		this.desiredVolume = targetVolume;
		this.startVolume = audioSource.volume;
	}

	// Token: 0x040001FD RID: 509
	public AudioClip[] day;

	// Token: 0x040001FE RID: 510
	public AudioClip[] night;

	// Token: 0x040001FF RID: 511
	public AudioClip[] boss;

	// Token: 0x04000200 RID: 512
	private AudioSource audio;

	// Token: 0x04000201 RID: 513
	public static MusicController Instance;

	// Token: 0x04000202 RID: 514
	private AudioClip queuedSong;

	// Token: 0x04000203 RID: 515
	private float fadeTime = 6f;

	// Token: 0x04000204 RID: 516
	private float targetVolume = 0.2f;

	// Token: 0x04000205 RID: 517
	private MusicController.SongType currentSong;

	// Token: 0x04000206 RID: 518
	private float currentTime;

	// Token: 0x04000207 RID: 519
	private float newFadeTime;

	// Token: 0x04000208 RID: 520
	private float desiredVolume;

	// Token: 0x04000209 RID: 521
	private float startVolume;

	// Token: 0x0200005F RID: 95
	public enum SongType
	{
		// Token: 0x0400020B RID: 523
		Day,
		// Token: 0x0400020C RID: 524
		Night,
		// Token: 0x0400020D RID: 525
		Boss
	}
}
