using System;
using System.Collections.Generic;
using UnityEngine;

public class ResourceManagerPooled : MonoBehaviour
{
	private void Awake()
	{
		ResourceManagerPooled.Instance = this;
		this.list = new Dictionary<int, GameObject>();
	}

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

	public Dictionary<int, GameObject> list;

	public GameObject debug;

	public bool attatchDebug;

	public static ResourceManagerPooled Instance;
}
