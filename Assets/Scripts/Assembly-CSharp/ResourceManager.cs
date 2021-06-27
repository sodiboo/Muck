using System;
using System.Collections.Generic;
using UnityEngine;

public class ResourceManager : MonoBehaviour
{
	private void Awake()
	{
		ResourceManager.Instance = this;
		this.list = new Dictionary<int, GameObject>();
		this.builds = new Dictionary<int, GameObject>();
		ResourceManager.generatorSeedOffset = 0;
		ResourceManager.globalId = 0;
	}

	public static int GetNextGenOffset()
	{
		int result = ResourceManager.generatorSeedOffset;
		ResourceManager.generatorSeedOffset++;
		return result;
	}

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

	public void AddResources(List<GameObject> trees)
	{
		for (int i = 0; i < trees.Count; i++)
		{
			GameObject gameObject = trees[i] = trees[i];
			int id = gameObject.GetComponentInChildren<SharedObject>().GetId();
			this.AddObject(id, gameObject);
		}
	}

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

	public int GetNextId()
	{
		return ResourceManager.globalId++;
	}

	public static int globalId;

	public static int generatorSeedOffset;

	public Dictionary<int, GameObject> list;

	public Dictionary<int, GameObject> builds;

	public GameObject debug;

	public bool attatchDebug;

	public static ResourceManager Instance;
}
