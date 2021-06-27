using UnityEngine;

// Token: 0x0200008F RID: 143
public class RandomSfx : MonoBehaviour
{
	// Token: 0x06000366 RID: 870 RVA: 0x000127DF File Offset: 0x000109DF
	private void Awake()
	{
		this.s = base.GetComponent<AudioSource>();
		if (this.playOnAwake)
		{
			this.Randomize(0f);
		}
	}

	// Token: 0x06000367 RID: 871 RVA: 0x00012800 File Offset: 0x00010A00
	public void Randomize(float delay)
	{
		this.s.clip = this.sounds[Random.Range(0, this.sounds.Length)];
		this.s.pitch = Random.Range(this.minPitch, this.maxPitch);
		this.s.PlayDelayed(delay);
	}

	// Token: 0x0400036C RID: 876
	public AudioClip[] sounds;

	// Token: 0x0400036D RID: 877
	[Range(0f, 2f)]
	public float maxPitch = 0.8f;

	// Token: 0x0400036E RID: 878
	[Range(0f, 2f)]
	public float minPitch = 1.2f;

	// Token: 0x0400036F RID: 879
	private AudioSource s;

	// Token: 0x04000370 RID: 880
	public bool playOnAwake = true;
}
