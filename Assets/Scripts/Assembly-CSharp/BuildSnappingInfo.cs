using System;
using UnityEngine;

// Token: 0x0200000E RID: 14
[ExecuteInEditMode]
public class BuildSnappingInfo : MonoBehaviour
{
	// Token: 0x06000059 RID: 89 RVA: 0x00004108 File Offset: 0x00002308
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		foreach (Vector3 a in this.position)
		{
			Gizmos.DrawCube(base.transform.position + a * 1f, Vector3.one * 0.1f);
		}
	}

	// Token: 0x0400005D RID: 93
	public Vector3[] position;

	// Token: 0x0400005E RID: 94
	public bool half;
}
