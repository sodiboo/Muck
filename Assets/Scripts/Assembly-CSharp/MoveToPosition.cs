
using UnityEngine;

// Token: 0x0200004F RID: 79
[ExecuteInEditMode]
public class MoveToPosition : MonoBehaviour
{
	// Token: 0x060001BF RID: 447 RVA: 0x0000A8F9 File Offset: 0x00008AF9
	public void LateUpdate()
	{
		base.transform.position = this.target.position;
	}

	// Token: 0x040001C0 RID: 448
	public Transform target;
}
