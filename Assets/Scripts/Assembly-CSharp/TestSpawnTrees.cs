using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200014A RID: 330
public class TestSpawnTrees : MonoBehaviour
{
	// Token: 0x060007F1 RID: 2033 RVA: 0x00027114 File Offset: 0x00025314
	private void Start()
	{
		GameObject item = this.SpawnTree(base.transform.position);
		this.resources.Add(item);
		if (ResourceManager.Instance)
		{
			ResourceManager.Instance.AddResources(this.resources);
		}
	}

	// Token: 0x060007F2 RID: 2034 RVA: 0x0000736C File Offset: 0x0000556C
	private GameObject SpawnTree(Vector3 pos)
	{
		GameObject gameObject =Instantiate<GameObject>(this.resourcePrefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
		gameObject.SetActive(true);
		return gameObject;
	}

	// Token: 0x04000833 RID: 2099
	public GameObject resourcePrefab;

	// Token: 0x04000834 RID: 2100
	public List<GameObject> resources;
}
