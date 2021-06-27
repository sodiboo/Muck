using System;
using UnityEngine;

public class PlayParticlesOnEnable : MonoBehaviour
{
	private void OnEnable()
	{
		this.ps.Play(true);
	}

	public ParticleSystem ps;
}
