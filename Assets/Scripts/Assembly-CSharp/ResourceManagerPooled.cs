using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200007B RID: 123
public class ResourceManagerPooled : MonoBehaviour
{
	// Token: 0x060002AE RID: 686 RVA: 0x00003F70 File Offset: 0x00002170
	private void Awake()
	{
		ResourceManagerPooled.Instance = this;
		this.list = new Dictionary<int, GameObject>();
	}

	// Token: 0x060002AF RID: 687 RVA: 0x00011F58 File Offset: 0x00010158
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

	// Token: 0x060002B0 RID: 688 RVA: 0x00011FB4 File Offset: 0x000101B4
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

	// Token: 0x060002B1 RID: 689 RVA: 0x0001201C File Offset: 0x0001021C
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

	// Token: 0x060002B2 RID: 690 RVA: 0x00003F83 File Offset: 0x00002183
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

	// Token: 0x040002C5 RID: 709
	public Dictionary<int, GameObject> list;

	// Token: 0x040002C6 RID: 710
	public GameObject debug;

	// Token: 0x040002C7 RID: 711
	public bool attatchDebug;

	// Token: 0x040002C8 RID: 712
	public static ResourceManagerPooled Instance;
}
