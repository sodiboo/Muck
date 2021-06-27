using System;
using UnityEngine;

public class ChestSfx : MonoBehaviour
{
	private void Awake()
	{
		this.audio = base.GetComponent<AudioSource>();
	}

	public void OpenChest()
	{
		this.audio.clip = this.open;
		this.audio.Play();
	}

	public void CloseChest()
	{
		this.audio.clip = this.close;
		this.audio.Play();
	}

	public AudioClip open;

	public AudioClip close;

	private AudioSource audio;
}
