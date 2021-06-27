using System;
using UnityEngine;

// Token: 0x0200006F RID: 111
public class NavmeshTest : MonoBehaviour
{
	// Token: 0x0600027C RID: 636 RVA: 0x0000E4B4 File Offset: 0x0000C6B4
	private void OnDrawGizmos()
	{
		base.GetComponentInChildren<Renderer>();
		Gizmos.color = Color.red;
		Bounds bounds = base.GetComponent<BoxCollider>().bounds;
		Gizmos.DrawWireCube(bounds.center, bounds.size);
	}
}
