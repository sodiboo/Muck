using UnityEngine;

public class RandomSfx : MonoBehaviour
{
	private void Awake()
	{
		this.s = base.GetComponent<AudioSource>();
		if (this.playOnAwake)
		{
			this.Randomize(0f);
		}
	}

	public void Randomize(float delay)
	{
		this.s.clip = this.sounds[Random.Range(0, this.sounds.Length)];
		this.s.pitch = Random.Range(this.minPitch, this.maxPitch);
		this.s.PlayDelayed(delay);
	}

	public AudioClip[] sounds;

	[Range(0f, 2f)]
	public float maxPitch = 0.8f;

	[Range(0f, 2f)]
	public float minPitch = 1.2f;

	private AudioSource s;

	public bool playOnAwake = true;
}
