using System;
using MilkShake;
using UnityEngine;

// Token: 0x02000105 RID: 261
public class ShakeCamera : MonoBehaviour
{
	// Token: 0x060007B1 RID: 1969 RVA: 0x000278A8 File Offset: 0x00025AA8
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

	// Token: 0x0400076B RID: 1899
	public ShakePreset customShake;

	// Token: 0x0400076C RID: 1900
	public float maxDistance = 50f;

	// Token: 0x0400076D RID: 1901
	public float shakeM;
}
