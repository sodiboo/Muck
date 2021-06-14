using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200007A RID: 122
public class ResourceManager : MonoBehaviour
{
	// Token: 0x060002A4 RID: 676 RVA: 0x00003EB3 File Offset: 0x000020B3
	private void Awake()
	{
		ResourceManager.Instance = this;
		this.list = new Dictionary<int, GameObject>();
		this.builds = new Dictionary<int, GameObject>();
		ResourceManager.generatorSeedOffset = 0;
		ResourceManager.globalId = 0;
	}

	// Token: 0x060002A5 RID: 677 RVA: 0x00003EDD File Offset: 0x000020DD
	public static int GetNextGenOffset()
	{
		int result = ResourceManager.generatorSeedOffset;
		ResourceManager.generatorSeedOffset++;
		return result;
	}

	// Token: 0x060002A6 RID: 678 RVA: 0x00011DF4 File Offset: 0x0000FFF4
	public void AddResources(List<GameObject>[] trees)
	{
		for (int i = 0; i < trees.Length; i++)
		{
			for (int j = 0; j < trees[i].Count; j++)
			{
				GameObject gameObject = trees[i][j] = trees[i][j];
				int id = gameObject.GetComponentInChildren<SharedObject>().GetId();
				this.AddObject(id, gameObject);
			}
		}
	}

	// Token: 0x060002A7 RID: 679 RVA: 0x00011E50 File Offset: 0x00010050
	public void AddResources(List<GameObject> trees)
	{
		for (int i = 0; i < trees.Count; i++)
		{
			GameObject gameObject = trees[i] = trees[i];
			int id = gameObject.GetComponentInChildren<SharedObject>().GetId();
			this.AddObject(id, gameObject);
		}
	}

	// Token: 0x060002A8 RID: 680 RVA: 0x00011E94 File Offset: 0x00010094
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

	// Token: 0x060002A9 RID: 681 RVA: 0x00011EFC File Offset: 0x000100FC
	public void AddBuild(int key, GameObject o)
	{
		if (this.builds.ContainsKey(key))
		{
			return;
		}
		this.builds.Add(key, o);
		if (this.attatchDebug)
		{
		Instantiate<GameObject>(this.debug, o.transform).GetComponentInChildren<DebugObject>().text = "id" + key;
		}
	}

	// Token: 0x060002AA RID: 682 RVA: 0x00003EF0 File Offset: 0x000020F0
	public void RemoveItem(int id)
	{
		Object obj = this.list[id];
		if (this.builds.ContainsKey(id))
		{
			this.builds.Remove(id);
		}
		this.list.Remove(id);
	Destroy(obj);
	}

	// Token: 0x060002AB RID: 683 RVA: 0x00003F2B File Offset: 0x0000212B
	public bool RemoveInteractItem(int id)
	{
		if (!this.list.ContainsKey(id))
		{
			return false;
		}
		Interactable componentInChildren = this.list[id].GetComponentInChildren<Interactable>();
		this.list.Remove(id);
		componentInChildren.RemoveObject();
		return true;
	}

	// Token: 0x060002AC RID: 684 RVA: 0x00003F61 File Offset: 0x00002161
	public int GetNextId()
	{
		return ResourceManager.globalId++;
	}

	// Token: 0x040002BE RID: 702
	public static int globalId;

	// Token: 0x040002BF RID: 703
	public static int generatorSeedOffset;

	// Token: 0x040002C0 RID: 704
	public Dictionary<int, GameObject> list;

	// Token: 0x040002C1 RID: 705
	public Dictionary<int, GameObject> builds;

	// Token: 0x040002C2 RID: 706
	public GameObject debug;

	// Token: 0x040002C3 RID: 707
	public bool attatchDebug;

	// Token: 0x040002C4 RID: 708
	public static ResourceManager Instance;
}
