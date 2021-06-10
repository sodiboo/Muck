
using UnityEngine;

// Token: 0x02000052 RID: 82
public class NavmeshTest : MonoBehaviour
{
	// Token: 0x060001D0 RID: 464 RVA: 0x0000ABF0 File Offset: 0x00008DF0
	private void OnDrawGizmos()
	{
		base.GetComponentInChildren<Renderer>();
		Gizmos.color = Color.red;
		Bounds bounds = base.GetComponent<BoxCollider>().bounds;
		Gizmos.DrawWireCube(bounds.center, bounds.size);
	}
}
