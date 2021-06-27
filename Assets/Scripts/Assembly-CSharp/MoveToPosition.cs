using System;
using UnityEngine;

// Token: 0x0200006C RID: 108
[ExecuteInEditMode]
public class MoveToPosition : MonoBehaviour
{
	// Token: 0x0600026B RID: 619 RVA: 0x0000E18D File Offset: 0x0000C38D
	public void LateUpdate()
	{
		base.transform.position = this.target.position;
	}

	// Token: 0x04000285 RID: 645
	public Transform target;
}
