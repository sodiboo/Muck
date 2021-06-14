using System;
using UnityEngine;

// Token: 0x02000133 RID: 307
public class SpawnSfx : MonoBehaviour
{
	// Token: 0x06000767 RID: 1895 RVA: 0x00006DF2 File Offset: 0x00004FF2
	public void SpawnSound()
	{
	Instantiate<GameObject>(this.startCharge, this.pos.position, this.startCharge.transform.rotation);
	}

	// Token: 0x040007A6 RID: 1958
	public GameObject startCharge;

	// Token: 0x040007A7 RID: 1959
	public Transform pos;
}
