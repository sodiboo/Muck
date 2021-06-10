
using UnityEngine;

// Token: 0x02000069 RID: 105
public class RandomSfx : MonoBehaviour
{
	// Token: 0x0600028D RID: 653 RVA: 0x0000E020 File Offset: 0x0000C220
	private void Awake()
	{
		this.s = base.GetComponent<AudioSource>();
		if (this.playOnAwake)
		{
			this.Randomize(0f);
		}
	}

	// Token: 0x0600028E RID: 654 RVA: 0x0000E044 File Offset: 0x0000C244
	public void Randomize(float delay)
	{
		this.s.clip = this.sounds[Random.Range(0, this.sounds.Length)];
		this.s.pitch = Random.Range(this.minPitch, this.maxPitch);
		this.s.PlayDelayed(delay);
	}

	// Token: 0x04000276 RID: 630
	public AudioClip[] sounds;

	// Token: 0x04000277 RID: 631
	[Range(0f, 2f)]
	public float maxPitch = 0.8f;

	// Token: 0x04000278 RID: 632
	[Range(0f, 2f)]
	public float minPitch = 1.2f;

	// Token: 0x04000279 RID: 633
	private AudioSource s;

	// Token: 0x0400027A RID: 634
	public bool playOnAwake = true;
}
