
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000BE RID: 190
public class ObjectPool : MonoBehaviour
{
	// Token: 0x0600060D RID: 1549 RVA: 0x0001EC73 File Offset: 0x0001CE73
	private void Awake()
	{
		this.InitPools();
	}

	// Token: 0x0600060E RID: 1550 RVA: 0x0001EC7C File Offset: 0x0001CE7C
	private void InitPools()
	{
		this.gen = base.GetComponent<ResourceGenerator>();
		this.pools = new List<SharedObject>[this.gen.resourcePrefabs.Length];
		for (int i = 0; i < this.gen.resourcePrefabs.Length; i++)
		{
			this.pools[i] = new List<SharedObject>();
		}
	}

	// Token: 0x0600060F RID: 1551 RVA: 0x00016F54 File Offset: 0x00015154
	public int ActivateGameObject(PooledObject activatedObject)
	{
		return 0;
	}

	// Token: 0x06000610 RID: 1552 RVA: 0x0000276E File Offset: 0x0000096E
	public void DeactivateGameObject(PooledObject deactivatedObject)
	{
	}

	// Token: 0x0400057F RID: 1407
	public List<SharedObject>[] pools;

	// Token: 0x04000580 RID: 1408
	private ResourceGenerator gen;
}
