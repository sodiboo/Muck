using System;
using UnityEngine;

// Token: 0x0200005D RID: 93
[ExecuteInEditMode]
public class MoveToPosition : MonoBehaviour
{
	// Token: 0x060001E8 RID: 488 RVA: 0x000036E8 File Offset: 0x000018E8
	public void LateUpdate()
	{
		base.transform.position = this.target.position;
	}

	// Token: 0x040001FC RID: 508
	public Transform target;
}
