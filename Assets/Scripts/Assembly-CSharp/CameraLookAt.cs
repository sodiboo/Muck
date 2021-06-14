using System;
using UnityEngine;

// Token: 0x0200000D RID: 13
public class CameraLookAt : MonoBehaviour
{
	// Token: 0x06000035 RID: 53 RVA: 0x00008824 File Offset: 0x00006A24
	private void Update()
	{
		Quaternion b = Quaternion.LookRotation(this.target.position - base.transform.position);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6.4f);
	}

	// Token: 0x04000039 RID: 57
	public Transform target;
}
