using System;
using MilkShake;
using UnityEngine;

public class HandheldCamera : MonoBehaviour
{
	private void Start()
	{
		this.shaker = base.GetComponent<Shaker>();
		this.shaker.Shake(this.cameraShake, null);
	}

	public ShakePreset cameraShake;

	private Shaker shaker;
}
