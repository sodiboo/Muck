using System;
using MilkShake;
using UnityEngine;

// Token: 0x02000011 RID: 17
public class CameraShaker : MonoBehaviour
{
	// Token: 0x06000060 RID: 96 RVA: 0x000041CD File Offset: 0x000023CD
	private void Awake()
	{
		CameraShaker.Instance = this;
		this.shaker = base.GetComponent<Shaker>();
	}

	// Token: 0x06000061 RID: 97 RVA: 0x000041E4 File Offset: 0x000023E4
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

	// Token: 0x06000062 RID: 98 RVA: 0x00004234 File Offset: 0x00002434
	public void StepShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		this.shaker.Shake(this.stepShakePreset, null).StrengthScale = shakeRatio;
	}

	// Token: 0x06000063 RID: 99 RVA: 0x0000426C File Offset: 0x0000246C
	public void ChargeShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
		this.shaker.Shake(this.chargePreset, null).StrengthScale = shakeRatio;
	}

	// Token: 0x06000064 RID: 100 RVA: 0x000042B4 File Offset: 0x000024B4
	public void ShakeWithPreset(ShakePreset preset)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		this.shaker.Shake(preset, null);
	}

	// Token: 0x04000060 RID: 96
	public ShakePreset damagePreset;

	// Token: 0x04000061 RID: 97
	public ShakePreset chargePreset;

	// Token: 0x04000062 RID: 98
	public ShakePreset stepShakePreset;

	// Token: 0x04000063 RID: 99
	private Shaker shaker;

	// Token: 0x04000064 RID: 100
	public static CameraShaker Instance;
}
