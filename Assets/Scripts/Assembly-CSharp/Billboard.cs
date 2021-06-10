
using UnityEngine;

// Token: 0x02000005 RID: 5
public class Billboard : MonoBehaviour
{
	// Token: 0x0600000E RID: 14 RVA: 0x0000240C File Offset: 0x0000060C
	private void Awake()
	{
		this.defaultScale = base.transform.localScale;
	}

	// Token: 0x0600000F RID: 15 RVA: 0x00002420 File Offset: 0x00000620
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

	// Token: 0x0400000C RID: 12
	private Vector3 defaultScale;

	// Token: 0x0400000D RID: 13
	public bool xz;

	// Token: 0x0400000E RID: 14
	public bool affectScale;

	// Token: 0x0400000F RID: 15
	private Transform t;
}
