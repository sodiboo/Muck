using System;
using MilkShake;
using UnityEngine;

public class ShakeOnEnable : MonoBehaviour
{
	private void OnEnable()
	{
		this.sfx.Play();
		CameraShaker.Instance.ShakeWithPreset(this.preset);
		if (this.hitbox)
		{
			this.hitbox.Reset();
		}
	}

	public AudioSource sfx;

	public ShakePreset preset;

	public HitboxDamage hitbox;
}
