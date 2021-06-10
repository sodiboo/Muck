
using UnityEngine;

// Token: 0x020000DD RID: 221
public class ShakeCamera : MonoBehaviour
{
	// Token: 0x06000695 RID: 1685 RVA: 0x000216B4 File Offset: 0x0001F8B4
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

	// Token: 0x04000641 RID: 1601
	public float maxDistance = 50f;

	// Token: 0x04000642 RID: 1602
	public float shakeM;
}
