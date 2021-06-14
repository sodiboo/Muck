using System;
using UnityEngine;

// Token: 0x020000F0 RID: 240
public class StartPlayer : MonoBehaviour
{
	// Token: 0x06000668 RID: 1640 RVA: 0x00021DB8 File Offset: 0x0001FFB8
	private void Start()
	{
		for (int i = base.transform.childCount - 1; i >= 0; i--)
		{
			base.transform.GetChild(i).parent = null;
		}
	Destroy(base.gameObject);
	}
}
