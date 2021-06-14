using System;
using UnityEngine;

// Token: 0x0200000B RID: 11
[ExecuteInEditMode]
public class BuildSnappingInfo : MonoBehaviour
{
	// Token: 0x06000030 RID: 48 RVA: 0x000087C0 File Offset: 0x000069C0
	private void OnDrawGizmos()
	{
		Gizmos.color = Color.red;
		foreach (Vector3 a in this.position)
		{
			Gizmos.DrawCube(base.transform.position + a * 1f, Vector3.one * 0.1f);
		}
	}

	// Token: 0x04000037 RID: 55
	public Vector3[] position;

	// Token: 0x04000038 RID: 56
	public bool half;
}
