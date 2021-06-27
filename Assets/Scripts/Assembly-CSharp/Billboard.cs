using System;
using UnityEngine;

// Token: 0x02000005 RID: 5
public class Billboard : MonoBehaviour
{
	// Token: 0x06000010 RID: 16 RVA: 0x00002502 File Offset: 0x00000702
	private void Awake()
	{
		this.defaultScale = base.transform.localScale;
	}

	// Token: 0x06000011 RID: 17 RVA: 0x00002518 File Offset: 0x00000718
	private void Update()
	{
		if (!this.t)
		{
			if (this.t == null || !this.t.gameObject.activeInHierarchy)
			{
				if (PlayerMovement.Instance)
				{
					this.t = PlayerMovement.Instance.playerCam;
					return;
				}
				if (Camera.main)
				{
					this.t = Camera.main.transform;
				}
			}
			return;
		}
		base.transform.LookAt(this.t);
		if (!this.xz)
		{
			base.transform.rotation = Quaternion.Euler(0f, base.transform.rotation.eulerAngles.y + 180f, 0f);
		}
		if (!this.affectScale)
		{
			return;
		}
		base.transform.localScale = this.defaultScale;
	}

	// Token: 0x0400000D RID: 13
	private Vector3 defaultScale;

	// Token: 0x0400000E RID: 14
	public bool xz;

	// Token: 0x0400000F RID: 15
	public bool affectScale;

	// Token: 0x04000010 RID: 16
	private Transform t;
}
