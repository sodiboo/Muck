
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000065 RID: 101
public class ResourceManager : MonoBehaviour
{
	// Token: 0x0600026F RID: 623 RVA: 0x0000DA04 File Offset: 0x0000BC04
	private void Awake()
	{
		ResourceManager.Instance = this;
		this.list = new Dictionary<int, GameObject>();
		this.builds = new Dictionary<int, GameObject>();
		ResourceManager.generatorSeedOffset = 0;
		ResourceManager.globalId = 0;
	}

	// Token: 0x06000270 RID: 624 RVA: 0x0000DA2E File Offset: 0x0000BC2E
	public static int GetNextGenOffset()
	{
		int result = ResourceManager.generatorSeedOffset;
		ResourceManager.generatorSeedOffset++;
		return result;
	}

	// Token: 0x06000271 RID: 625 RVA: 0x0000DA44 File Offset: 0x0000BC44
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

	// Token: 0x06000272 RID: 626 RVA: 0x0000DAA0 File Offset: 0x0000BCA0
	public void AddResources(List<GameObject> trees)
	{
		for (int i = 0; i < trees.Count; i++)
		{
			GameObject gameObject = trees[i] = trees[i];
			int id = gameObject.GetComponentInChildren<SharedObject>().GetId();
			this.AddObject(id, gameObject);
		}
	}

	// Token: 0x06000273 RID: 627 RVA: 0x0000DAE4 File Offset: 0x0000BCE4
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

	// Token: 0x06000274 RID: 628 RVA: 0x0000DB4C File Offset: 0x0000BD4C
	public void AddBuild(int key, GameObject o)
	{
		if (this.builds.ContainsKey(key))
		{
			return;
		}
		this.builds.Add(key, o);
		if (this.attatchDebug)
		{
		Instantiate(this.debug, o.transform).GetComponentInChildren<DebugObject>().text = "id" + key;
		}
	}

	// Token: 0x06000275 RID: 629 RVA: 0x0000DBA8 File Offset: 0x0000BDA8
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

	// Token: 0x06000276 RID: 630 RVA: 0x0000DBE3 File Offset: 0x0000BDE3
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

	// Token: 0x06000277 RID: 631 RVA: 0x0000DC19 File Offset: 0x0000BE19
	public int GetNextId()
	{
		return ResourceManager.globalId++;
	}

	// Token: 0x04000260 RID: 608
	public static int globalId;

	// Token: 0x04000261 RID: 609
	public static int generatorSeedOffset;

	// Token: 0x04000262 RID: 610
	public Dictionary<int, GameObject> list;

	// Token: 0x04000263 RID: 611
	public Dictionary<int, GameObject> builds;

	// Token: 0x04000264 RID: 612
	public GameObject debug;

	// Token: 0x04000265 RID: 613
	public bool attatchDebug;

	// Token: 0x04000266 RID: 614
	public static ResourceManager Instance;
}
