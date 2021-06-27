using System;
using UnityEngine;

// Token: 0x020000DD RID: 221
public class StartPlayer : MonoBehaviour
{
	// Token: 0x060006EA RID: 1770 RVA: 0x00023FD0 File Offset: 0x000221D0
	private void Start()
	{
		for (int i = base.transform.childCount - 1; i >= 0; i--)
		{
			base.transform.GetChild(i).parent = null;
		}
		Destroy(base.gameObject);
	}
}
