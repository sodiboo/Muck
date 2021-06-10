
using UnityEngine;

// Token: 0x02000029 RID: 41
public class GenerateAllResources : MonoBehaviour
{
	// Token: 0x060000F7 RID: 247 RVA: 0x00006FD8 File Offset: 0x000051D8
	private void Awake()
	{
		for (int i = 0; i < this.spawners.Length; i++)
		{
			this.spawners[i].SetActive(true);
		}
	}

	// Token: 0x040000ED RID: 237
	public GameObject[] spawners;

	// Token: 0x040000EE RID: 238
	public static int seedOffset;
}
