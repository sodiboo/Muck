using System;
using UnityEngine;

// Token: 0x02000128 RID: 296
public class ShakeCamera : MonoBehaviour
{
	// Token: 0x06000734 RID: 1844 RVA: 0x00024984 File Offset: 0x00022B84
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

	// Token: 0x04000788 RID: 1928
	public float maxDistance = 50f;

	// Token: 0x04000789 RID: 1929
	public float shakeM;
}
