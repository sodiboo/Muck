using System;
using UnityEngine;

// Token: 0x02000028 RID: 40
public class DestroyObject : MonoBehaviour
{
	// Token: 0x060000EE RID: 238 RVA: 0x00006746 File Offset: 0x00004946
	private void Start()
	{
		Invoke(nameof(DestroySelf), this.time);
	}

	// Token: 0x060000EF RID: 239 RVA: 0x00006759 File Offset: 0x00004959
	private void DestroySelf()
	{
		Destroy(base.gameObject);
	}

	// Token: 0x040000F2 RID: 242
	public float time;
}
