using System;
using UnityEngine;

// Token: 0x02000061 RID: 97
public class NavmeshTest : MonoBehaviour
{
	// Token: 0x060001F9 RID: 505 RVA: 0x0000F2CC File Offset: 0x0000D4CC
	private void OnDrawGizmos()
	{
		base.GetComponentInChildren<Renderer>();
		Gizmos.color = Color.red;
		Bounds bounds = base.GetComponent<BoxCollider>().bounds;
		Gizmos.DrawWireCube(bounds.center, bounds.size);
	}
}
