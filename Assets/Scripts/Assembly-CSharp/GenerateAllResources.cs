using System;
using UnityEngine;

// Token: 0x02000031 RID: 49
public class GenerateAllResources : MonoBehaviour
{
	// Token: 0x0600010B RID: 267 RVA: 0x0000B8F8 File Offset: 0x00009AF8
	private void Awake()
	{
		for (int i = 0; i < this.spawners.Length; i++)
		{
			this.spawners[i].SetActive(true);
		}
	}

	// Token: 0x04000110 RID: 272
	public GameObject[] spawners;

	// Token: 0x04000111 RID: 273
	public static int seedOffset;
}
