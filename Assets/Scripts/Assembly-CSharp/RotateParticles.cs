using System;
using UnityEngine;

// Token: 0x0200008C RID: 140
[ExecuteInEditMode]
public class RotateParticles : MonoBehaviour
{
	// Token: 0x0600035F RID: 863 RVA: 0x000126A5 File Offset: 0x000108A5
	private void Update()
	{
		base.transform.rotation = this.parent.rotation;
	}

	// Token: 0x04000369 RID: 873
	public Transform parent;
}
