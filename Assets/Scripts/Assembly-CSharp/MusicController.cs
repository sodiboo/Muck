using UnityEngine;

// Token: 0x0200006D RID: 109
public class MusicController : MonoBehaviour
{
	// Token: 0x0600026D RID: 621 RVA: 0x0000E1A5 File Offset: 0x0000C3A5
	private void Awake()
	{
		MusicController.Instance = this;
		this.audio = base.GetComponent<AudioSource>();
	}

	// Token: 0x0600026E RID: 622 RVA: 0x0000E1B9 File Offset: 0x0000C3B9
	private void Start()
	{
		this.targetVolume = CurrentSettings.Instance.music;
	}

	// Token: 0x0600026F RID: 623 RVA: 0x0000E1CB File Offset: 0x0000C3CB
	public void SetVolume(float f)
	{
		this.targetVolume = f;
		this.StartFade(this.audio, 0.1f, f);
	}

	// Token: 0x06000270 RID: 624 RVA: 0x0000E1E8 File Offset: 0x0000C3E8
	public void PlaySong(MusicController.SongType s, bool chanceToSkip = true)
	{
		if (GameManager.instance && GameManager.instance.boatLeft)
		{
			return;
		}
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
			Invoke(nameof(NextSong), this.fadeTime);
			return;
		}
		this.NextSong(audioClip);
	}

	// Token: 0x06000271 RID: 625 RVA: 0x0000E30B File Offset: 0x0000C50B
	private void NextSong()
	{
		this.StartFade(this.audio, this.fadeTime, this.targetVolume);
		this.audio.clip = this.queuedSong;
		this.audio.Play();
	}

	// Token: 0x06000272 RID: 626 RVA: 0x0000E341 File Offset: 0x0000C541
	private void NextSong(AudioClip song)
	{
		this.StartFade(this.audio, this.fadeTime, this.targetVolume);
		this.audio.clip = song;
		this.audio.Play();
	}

	// Token: 0x06000273 RID: 627 RVA: 0x0000E374 File Offset: 0x0000C574
	public void StopSong(float fade = -1f)
	{
		float duration = this.fadeTime;
		if (fade >= 0f)
		{
			duration = fade;
		}
		this.StartFade(this.audio, duration, 0f);
	}

	// Token: 0x06000274 RID: 628 RVA: 0x0000E3A4 File Offset: 0x0000C5A4
	private void Update()
	{
		this.currentTime += Time.deltaTime;
		this.audio.volume = Mathf.Lerp(this.startVolume, this.desiredVolume * this.targetVolume, this.currentTime / this.newFadeTime);
	}

	// Token: 0x06000275 RID: 629 RVA: 0x0000E3F3 File Offset: 0x0000C5F3
	private void StartFade(AudioSource audioSource, float duration, float targetVolume)
	{
		this.currentTime = 0f;
		this.newFadeTime = duration;
		this.desiredVolume = targetVolume;
		this.startVolume = audioSource.volume;
	}

	// Token: 0x04000286 RID: 646
	public AudioClip[] day;

	// Token: 0x04000287 RID: 647
	public AudioClip[] night;

	// Token: 0x04000288 RID: 648
	public AudioClip[] boss;

	// Token: 0x04000289 RID: 649
	private AudioSource audio;

	// Token: 0x0400028A RID: 650
	public static MusicController Instance;

	// Token: 0x0400028B RID: 651
	private AudioClip queuedSong;

	// Token: 0x0400028C RID: 652
	private float fadeTime = 6f;

	// Token: 0x0400028D RID: 653
	private float targetVolume = 0.2f;

	// Token: 0x0400028E RID: 654
	private MusicController.SongType currentSong;

	// Token: 0x0400028F RID: 655
	private float currentTime;

	// Token: 0x04000290 RID: 656
	private float newFadeTime;

	// Token: 0x04000291 RID: 657
	private float desiredVolume;

	// Token: 0x04000292 RID: 658
	private float startVolume;

	// Token: 0x02000148 RID: 328
	public enum SongType
	{
		// Token: 0x040008A4 RID: 2212
		Day,
		// Token: 0x040008A5 RID: 2213
		Night,
		// Token: 0x040008A6 RID: 2214
		Boss
	}
}
