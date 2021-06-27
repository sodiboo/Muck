using System;
using UnityEngine;

// Token: 0x02000110 RID: 272
public class SpawnFxAtPosition : MonoBehaviour
{
	// Token: 0x060007EE RID: 2030 RVA: 0x000280F4 File Offset: 0x000262F4
	public void SpawnFx(int n)
	{
		Instantiate<GameObject>(this.fx[n], this.positions[n].position, this.fx[n].transform.rotation);
	}

	// Token: 0x04000790 RID: 1936
	public GameObject[] fx;

	// Token: 0x04000791 RID: 1937
	public Transform[] positions;
}
