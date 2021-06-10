
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000066 RID: 102
public class ResourceManagerPooled : MonoBehaviour
{
	// Token: 0x06000279 RID: 633 RVA: 0x0000DC28 File Offset: 0x0000BE28
	private void Awake()
	{
		ResourceManagerPooled.Instance = this;
		this.list = new Dictionary<int, GameObject>();
	}

	// Token: 0x0600027A RID: 634 RVA: 0x0000DC3C File Offset: 0x0000BE3C
	public void PopulateTrees(List<GameObject>[] trees)
	{
		for (int i = 0; i < trees.Length; i++)
		{
			for (int j = 0; j < trees[i].Count; j++)
			{
				GameObject gameObject = trees[i][j] = trees[i][j];
				int id = gameObject.GetComponent<SharedObject>().GetId();
				this.AddObject(id, gameObject);
			}
		}
	}

	// Token: 0x0600027B RID: 635 RVA: 0x0000DC98 File Offset: 0x0000BE98
	public void AddObject(int key, GameObject o)
	{
		if (this.list.ContainsKey(key))
		{
			Debug.Log("Tried to add same key twice to resource manager, returning...");
			return;
		}
		this.list.Add(key, o);
		if (this.attatchDebug)
		{
		Instantiate(this.debug, o.transform).GetComponentInChildren<DebugObject>().text = "id" + key;
		}
	}

	// Token: 0x0600027C RID: 636 RVA: 0x0000DD00 File Offset: 0x0000BF00
	public void RemoveItem(int id)
	{
		GameObject gameObject = this.list[id];
		if (gameObject.activeInHierarchy)
		{
			gameObject.SetActive(false);
			return;
		}
		this.list.Remove(id);
	Destroy(gameObject);
	}

	// Token: 0x0600027D RID: 637 RVA: 0x0000DD3D File Offset: 0x0000BF3D
	public bool RemoveInteractItem(int id)
	{
		if (!this.list.ContainsKey(id))
		{
			return false;
		}
		Object obj = this.list[id];
		this.list.Remove(id);
	Destroy(obj);
		return true;
	}

	// Token: 0x04000267 RID: 615
	public Dictionary<int, GameObject> list;

	// Token: 0x04000268 RID: 616
	public GameObject debug;

	// Token: 0x04000269 RID: 617
	public bool attatchDebug;

	// Token: 0x0400026A RID: 618
	public static ResourceManagerPooled Instance;
}
