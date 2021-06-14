using UnityEngine;

// Token: 0x02000080 RID: 128
public class RandomSfx : MonoBehaviour
{
	// Token: 0x060002C7 RID: 711 RVA: 0x0000406E File Offset: 0x0000226E
	private void Awake()
	{
		this.s = base.GetComponent<AudioSource>();
		if (this.playOnAwake)
		{
			this.Randomize(0f);
		}
	}

	// Token: 0x060002C8 RID: 712 RVA: 0x00012370 File Offset: 0x00010570
	public void Randomize(float delay)
	{
		this.s.clip = this.sounds[Random.Range(0, this.sounds.Length)];
		this.s.pitch = Random.Range(this.minPitch, this.maxPitch);
		this.s.PlayDelayed(delay);
	}

	// Token: 0x040002D6 RID: 726
	public AudioClip[] sounds;

	// Token: 0x040002D7 RID: 727
	[Range(0f, 2f)]
	public float maxPitch = 0.8f;

	// Token: 0x040002D8 RID: 728
	[Range(0f, 2f)]
	public float minPitch = 1.2f;

	// Token: 0x040002D9 RID: 729
	private AudioSource s;

	// Token: 0x040002DA RID: 730
	public bool playOnAwake = true;
}
