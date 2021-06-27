using System;
using MilkShake;
using UnityEngine;

public class ShakeCamera : MonoBehaviour
{
	private void Start()
	{
		if (this.customShake)
		{
			CameraShaker.Instance.ShakeWithPreset(this.customShake);
			return;
		}
		float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
		if (num > this.maxDistance)
		{
			return;
		}
		float num2 = 1f - num / this.maxDistance;
		float shakeRatio = this.shakeM * num2;
		CameraShaker.Instance.StepShake(shakeRatio);
	}

	public ShakePreset customShake;

	public float maxDistance = 50f;

	public float shakeM;
}
