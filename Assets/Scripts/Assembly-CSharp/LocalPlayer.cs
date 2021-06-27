using System;
using UnityEngine;

// Token: 0x020000BA RID: 186
public class LocalPlayer : MonoBehaviour
{
	// Token: 0x06000560 RID: 1376 RVA: 0x0001BF60 File Offset: 0x0001A160
	public void SwitchUserInterface(bool b)
	{
		GameObject[] array = this.objects;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(b);
		}
	}

	// Token: 0x040004B0 RID: 1200
	public GameObject[] objects;
}
