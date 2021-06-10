
using MilkShake;
using UnityEngine;

// Token: 0x0200000D RID: 13
public class CameraShaker : MonoBehaviour
{
	// Token: 0x06000036 RID: 54 RVA: 0x00003979 File Offset: 0x00001B79
	private void Awake()
	{
		CameraShaker.Instance = this;
		this.shaker = base.GetComponent<Shaker>();
	}

	// Token: 0x06000037 RID: 55 RVA: 0x00003990 File Offset: 0x00001B90
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

	// Token: 0x06000038 RID: 56 RVA: 0x000039E0 File Offset: 0x00001BE0
	public void StepShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		this.shaker.Shake(this.stepShakePreset, null).StrengthScale = shakeRatio;
	}

	// Token: 0x06000039 RID: 57 RVA: 0x00003A18 File Offset: 0x00001C18
	public void ChargeShake(float shakeRatio)
	{
		if (!CurrentSettings.cameraShake)
		{
			return;
		}
		shakeRatio = Mathf.Clamp(shakeRatio, 0.2f, 1f);
		this.shaker.Shake(this.chargePreset, null).StrengthScale = shakeRatio;
	}

	// Token: 0x04000037 RID: 55
	public ShakePreset damagePreset;

	// Token: 0x04000038 RID: 56
	public ShakePreset chargePreset;

	// Token: 0x04000039 RID: 57
	public ShakePreset stepShakePreset;

	// Token: 0x0400003A RID: 58
	private Shaker shaker;

	// Token: 0x0400003B RID: 59
	public static CameraShaker Instance;
}
