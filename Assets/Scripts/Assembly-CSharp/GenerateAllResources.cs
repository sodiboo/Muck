using System;
using System.Collections;
using UnityEngine;

// Token: 0x0200003B RID: 59
public class GenerateAllResources : MonoBehaviour
{
	// Token: 0x06000160 RID: 352 RVA: 0x00008A6A File Offset: 0x00006C6A
	private void Awake()
	{
		base.StartCoroutine(this.GenerateResources());
	}

	// Token: 0x06000161 RID: 353 RVA: 0x00008A79 File Offset: 0x00006C79
	private IEnumerator GenerateResources()
	{
		for (int i = 0; i < this.spawnersFirst.Length; i++)
		{
			this.spawnersFirst[i].SetActive(true);
		}
		yield return 3000;
		for (int j = 0; j < this.spawners.Length; j++)
		{
			this.spawners[j].SetActive(true);
		}
		yield break;
	}

	// Token: 0x04000157 RID: 343
	public GameObject[] spawnersFirst;

	// Token: 0x04000158 RID: 344
	public GameObject[] spawners;

	// Token: 0x04000159 RID: 345
	public static int seedOffset;
}
