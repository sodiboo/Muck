
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000F6 RID: 246
public class TestSpawnTrees : MonoBehaviour
{
	// Token: 0x06000735 RID: 1845 RVA: 0x00023D6C File Offset: 0x00021F6C
	private void Start()
	{
		GameObject item = this.SpawnTree(base.transform.position);
		this.resources.Add(item);
		if (ResourceManager.Instance)
		{
			ResourceManager.Instance.AddResources(this.resources);
		}
	}

	// Token: 0x06000736 RID: 1846 RVA: 0x00023DB3 File Offset: 0x00021FB3
	private GameObject SpawnTree(Vector3 pos)
	{
		GameObject gameObject =Instantiate(this.resourcePrefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
		gameObject.SetActive(true);
		return gameObject;
	}

	// Token: 0x040006CD RID: 1741
	public GameObject resourcePrefab;

	// Token: 0x040006CE RID: 1742
	public List<GameObject> resources;
}
