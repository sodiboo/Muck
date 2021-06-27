using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000087 RID: 135
public class ResourceManager : MonoBehaviour
{
	// Token: 0x0600033D RID: 829 RVA: 0x00011D3C File Offset: 0x0000FF3C
	private void Awake()
	{
		ResourceManager.Instance = this;
		this.list = new Dictionary<int, GameObject>();
		this.builds = new Dictionary<int, GameObject>();
		ResourceManager.generatorSeedOffset = 0;
		ResourceManager.globalId = 0;
	}

	// Token: 0x0600033E RID: 830 RVA: 0x00011D66 File Offset: 0x0000FF66
	public static int GetNextGenOffset()
	{
		int result = ResourceManager.generatorSeedOffset;
		ResourceManager.generatorSeedOffset++;
		return result;
	}

	// Token: 0x0600033F RID: 831 RVA: 0x00011D7C File Offset: 0x0000FF7C
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

	// Token: 0x06000340 RID: 832 RVA: 0x00011DD8 File Offset: 0x0000FFD8
	public void AddResources(List<GameObject> trees)
	{
		for (int i = 0; i < trees.Count; i++)
		{
			GameObject gameObject = trees[i] = trees[i];
			int id = gameObject.GetComponentInChildren<SharedObject>().GetId();
			this.AddObject(id, gameObject);
		}
	}

	// Token: 0x06000341 RID: 833 RVA: 0x00011E1C File Offset: 0x0001001C
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

	// Token: 0x06000342 RID: 834 RVA: 0x00011E84 File Offset: 0x00010084
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

	// Token: 0x06000343 RID: 835 RVA: 0x00011EE0 File Offset: 0x000100E0
	public void RemoveItem(int id)
	{
		var obj = this.list[id];
		if (this.builds.ContainsKey(id))
		{
			this.builds.Remove(id);
		}
		this.list.Remove(id);
		Destroy(obj);
	}

	// Token: 0x06000344 RID: 836 RVA: 0x00011F1B File Offset: 0x0001011B
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

	// Token: 0x06000345 RID: 837 RVA: 0x00011F51 File Offset: 0x00010151
	public int GetNextId()
	{
		return ResourceManager.globalId++;
	}

	// Token: 0x04000346 RID: 838
	public static int globalId;

	// Token: 0x04000347 RID: 839
	public static int generatorSeedOffset;

	// Token: 0x04000348 RID: 840
	public Dictionary<int, GameObject> list;

	// Token: 0x04000349 RID: 841
	public Dictionary<int, GameObject> builds;

	// Token: 0x0400034A RID: 842
	public GameObject debug;

	// Token: 0x0400034B RID: 843
	public bool attatchDebug;

	// Token: 0x0400034C RID: 844
	public static ResourceManager Instance;
}
