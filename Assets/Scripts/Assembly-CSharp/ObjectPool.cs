using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000E6 RID: 230
public class ObjectPool : MonoBehaviour
{
	// Token: 0x06000727 RID: 1831 RVA: 0x00024D17 File Offset: 0x00022F17
	private void Awake()
	{
		this.InitPools();
	}

	// Token: 0x06000728 RID: 1832 RVA: 0x00024D20 File Offset: 0x00022F20
	private void InitPools()
	{
		this.gen = base.GetComponent<ResourceGenerator>();
		this.pools = new List<SharedObject>[this.gen.resourcePrefabs.Length];
		for (int i = 0; i < this.gen.resourcePrefabs.Length; i++)
		{
			this.pools[i] = new List<SharedObject>();
		}
	}

	// Token: 0x06000729 RID: 1833 RVA: 0x00007C91 File Offset: 0x00005E91
	public int ActivateGameObject(PooledObject activatedObject)
	{
		return 0;
	}

	// Token: 0x0600072A RID: 1834 RVA: 0x000030D7 File Offset: 0x000012D7
	public void DeactivateGameObject(PooledObject deactivatedObject)
	{
	}

	// Token: 0x040006A5 RID: 1701
	public List<SharedObject>[] pools;

	// Token: 0x040006A6 RID: 1702
	private ResourceGenerator gen;
}
