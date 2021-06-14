using System;
using UnityEngine;

// Token: 0x02000024 RID: 36
public class DestroyObject : MonoBehaviour
{
	// Token: 0x060000BC RID: 188 RVA: 0x00002AB5 File Offset: 0x00000CB5
	private void Start()
	{
		base.Invoke(nameof(DestroySelf), this.time);
	}

	// Token: 0x060000BD RID: 189 RVA: 0x00002AC8 File Offset: 0x00000CC8
	private void DestroySelf()
	{
	Destroy(base.gameObject);
	}

	// Token: 0x040000BA RID: 186
	public float time;
}
