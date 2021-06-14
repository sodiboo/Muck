using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000FB RID: 251
public class ObjectPool : MonoBehaviour
{
	// Token: 0x060006A0 RID: 1696 RVA: 0x000062FE File Offset: 0x000044FE
	private void Awake()
	{
		this.InitPools();
	}

	// Token: 0x060006A1 RID: 1697 RVA: 0x00022768 File Offset: 0x00020968
	private void InitPools()
	{
		this.gen = base.GetComponent<ResourceGenerator>();
		this.pools = new List<SharedObject>[this.gen.resourcePrefabs.Length];
		for (int i = 0; i < this.gen.resourcePrefabs.Length; i++)
		{
			this.pools[i] = new List<SharedObject>();
		}
	}

	// Token: 0x060006A2 RID: 1698 RVA: 0x00002EB3 File Offset: 0x000010B3
	public int ActivateGameObject(PooledObject activatedObject)
	{
		return 0;
	}

	// Token: 0x060006A3 RID: 1699 RVA: 0x00002147 File Offset: 0x00000347
	public void DeactivateGameObject(PooledObject deactivatedObject)
	{
	}

	// Token: 0x04000686 RID: 1670
	public List<SharedObject>[] pools;

	// Token: 0x04000687 RID: 1671
	private ResourceGenerator gen;
}
