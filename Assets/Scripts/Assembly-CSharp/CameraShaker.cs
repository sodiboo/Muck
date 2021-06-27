using System;
using MilkShake;
using UnityEngine;

public class CameraShaker : MonoBehaviour
{
	private void Awake()
	{
		CameraShaker.Instance = this;
		this.shaker = base.GetComponent<Shaker>();
	}

	public void DamageShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		shakeRatio *= 2f;
		shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
		this.shaker.Shake(this.damagePreset, null).StrengthScale = shakeRatio;
	}

	public void StepShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		this.shaker.Shake(this.stepShakePreset, null).StrengthScale = shakeRatio;
	}

	public void ChargeShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
		this.shaker.Shake(this.chargePreset, null).StrengthScale = shakeRatio;
	}

	public void ShakeWithPreset(ShakePreset preset)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		this.shaker.Shake(preset, null);
	}

	public ShakePreset damagePreset;

	public ShakePreset chargePreset;

	public ShakePreset stepShakePreset;

	private Shaker shaker;

	public static CameraShaker Instance;
}
