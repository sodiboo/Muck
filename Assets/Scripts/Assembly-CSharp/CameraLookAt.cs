using System;
using UnityEngine;

// Token: 0x02000010 RID: 16
public class CameraLookAt : MonoBehaviour
{
	// Token: 0x0600005E RID: 94 RVA: 0x00004178 File Offset: 0x00002378
	private void Update()
	{
		Quaternion b = Quaternion.LookRotation(this.target.position - base.transform.position);
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, b, Time.deltaTime * 6.4f);
	}

	// Token: 0x0400005F RID: 95
	public Transform target;
}
