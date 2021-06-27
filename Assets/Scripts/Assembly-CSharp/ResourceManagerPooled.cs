using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000088 RID: 136
public class ResourceManagerPooled : MonoBehaviour
{
	// Token: 0x06000347 RID: 839 RVA: 0x00011F60 File Offset: 0x00010160
	private void Awake()
	{
		ResourceManagerPooled.Instance = this;
		this.list = new Dictionary<int, GameObject>();
	}

	// Token: 0x06000348 RID: 840 RVA: 0x00011F74 File Offset: 0x00010174
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

	// Token: 0x06000349 RID: 841 RVA: 0x00011FD0 File Offset: 0x000101D0
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
			Instantiate<GameObject>(this.debug, o.transform).GetComponentInChildren<DebugObject>().text = "id" + key;
		}
	}

	// Token: 0x0600034A RID: 842 RVA: 0x00012038 File Offset: 0x00010238
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

	// Token: 0x0600034B RID: 843 RVA: 0x00012075 File Offset: 0x00010275
	public bool RemoveInteractItem(int id)
	{
		if (!this.list.ContainsKey(id))
		{
			return false;
		}
		var obj = this.list[id];
		this.list.Remove(id);
		Destroy(obj);
		return true;
	}

	// Token: 0x0400034D RID: 845
	public Dictionary<int, GameObject> list;

	// Token: 0x0400034E RID: 846
	public GameObject debug;

	// Token: 0x0400034F RID: 847
	public bool attatchDebug;

	// Token: 0x04000350 RID: 848
	public static ResourceManagerPooled Instance;
}
