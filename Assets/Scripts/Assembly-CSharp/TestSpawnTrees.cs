using System;
using System.Collections.Generic;
using UnityEngine;

public class TestSpawnTrees : MonoBehaviour
{
	private void Start()
	{
		GameObject item = this.SpawnTree(base.transform.position);
		this.resources.Add(item);
		if (ResourceManager.Instance)
		{
			ResourceManager.Instance.AddResources(this.resources);
		}
	}

	private GameObject SpawnTree(Vector3 pos)
	{
		GameObject gameObject = Instantiate<GameObject>(this.resourcePrefab, pos, Quaternion.identity);
		gameObject.GetComponentInChildren<SharedObject>().SetId(ResourceManager.Instance.GetNextId());
		gameObject.SetActive(true);
		return gameObject;
	}

	public GameObject resourcePrefab;

	public List<GameObject> resources;
}
