using System;
using MilkShake;
using UnityEngine;

// Token: 0x0200000E RID: 14
public class CameraShaker : MonoBehaviour
{
	// Token: 0x06000037 RID: 55 RVA: 0x00002281 File Offset: 0x00000481
	private void Awake()
	{
		CameraShaker.Instance = this;
		this.shaker = base.GetComponent<Shaker>();
	}

	// Token: 0x06000038 RID: 56 RVA: 0x0000887C File Offset: 0x00006A7C
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

	// Token: 0x06000039 RID: 57 RVA: 0x000088CC File Offset: 0x00006ACC
	public void StepShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		this.shaker.Shake(this.stepShakePreset, null).StrengthScale = shakeRatio;
	}

	// Token: 0x0600003A RID: 58 RVA: 0x00008904 File Offset: 0x00006B04
	public void ChargeShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
		this.shaker.Shake(this.chargePreset, null).StrengthScale = shakeRatio;
	}

	// Token: 0x0400003A RID: 58
	public ShakePreset damagePreset;

	// Token: 0x0400003B RID: 59
	public ShakePreset chargePreset;

	// Token: 0x0400003C RID: 60
	public ShakePreset stepShakePreset;

	// Token: 0x0400003D RID: 61
	private Shaker shaker;

	// Token: 0x0400003E RID: 62
	public static CameraShaker Instance;
}
