using System;
using UnityEngine;


public class ShakeCamera : MonoBehaviour
{

	private void Start()
	{
		float num = Vector3.Distance(base.transform.position, PlayerMovement.Instance.playerCam.position);
		if (num > this.maxDistance)
		{
			return;
		}
		float num2 = 1f - num / this.maxDistance;
		float shakeRatio = this.shakeM * num2;
		CameraShaker.Instance.StepShake(shakeRatio);
	}


	public float maxDistance = 50f;


	public float shakeM;
}
