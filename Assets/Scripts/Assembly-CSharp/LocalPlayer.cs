using System;
using UnityEngine;

// Token: 0x020000C1 RID: 193
public class LocalPlayer : MonoBehaviour
{
	// Token: 0x060004DA RID: 1242 RVA: 0x0001ABDC File Offset: 0x00018DDC
	public void SwitchUserInterface(bool b)
	{
		GameObject[] array = this.objects;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(b);
		}
	}

	// Token: 0x0400046E RID: 1134
	public GameObject[] objects;
}
