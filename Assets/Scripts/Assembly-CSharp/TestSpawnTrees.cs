using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000126 RID: 294
public class TestSpawnTrees : MonoBehaviour
{
	// Token: 0x06000879 RID: 2169 RVA: 0x0002A64C File Offset: 0x0002884C
	private void Start()
	{
		GameObject item = this.SpawnTree(base.transform.position);
		this.resources.Add(item);
		if (ResourceManager.Instance)
		{
			ResourceManager.Instance.AddResources(this.resources);
		}
	}

	// Token: 0x0600087A RID: 2170 RVA: 0x0002A693 File Offset: 0x00028893
	private GameObject SpawnTree(Vector3 pos)
	{
		GameObject gameObject = Instantiate<GameObject>(this.resourcePrefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
		gameObject.SetActive(true);
		return gameObject;
	}

	// Token: 0x04000812 RID: 2066
	public GameObject resourcePrefab;

	// Token: 0x04000813 RID: 2067
	public List<GameObject> resources;
}
