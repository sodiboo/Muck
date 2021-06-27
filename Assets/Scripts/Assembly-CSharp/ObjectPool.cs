using System;
using System.Collections.Generic;
using UnityEngine;

public class ObjectPool : MonoBehaviour
{
	private void Awake()
	{
		this.InitPools();
	}

	private void InitPools()
	{
		this.gen = base.GetComponent<ResourceGenerator>();
		this.pools = new List<SharedObject>[this.gen.resourcePrefabs.Length];
		for (int i = 0; i < this.gen.resourcePrefabs.Length; i++)
		{
			this.pools[i] = new List<SharedObject>();
		}
	}

	public int ActivateGameObject(PooledObject activatedObject)
	{
		return 0;
	}

	public void DeactivateGameObject(PooledObject deactivatedObject)
	{
	}

	public List<SharedObject>[] pools;

	private ResourceGenerator gen;
}
