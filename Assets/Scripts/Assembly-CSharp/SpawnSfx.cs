using System;
using UnityEngine;

// Token: 0x02000114 RID: 276
public class SpawnSfx : MonoBehaviour
{
	// Token: 0x060007F9 RID: 2041 RVA: 0x00028492 File Offset: 0x00026692
	public void SpawnSound()
	{
		Instantiate<GameObject>(this.startCharge, this.pos.position, this.startCharge.transform.rotation);
	}

	// Token: 0x0400079B RID: 1947
	public GameObject startCharge;

	// Token: 0x0400079C RID: 1948
	public Transform pos;
}
