using System;
using UnityEngine;

public class AddToResources : MonoBehaviour
{
	private void Start()
	{
		int nextId = ResourceManager.Instance.GetNextId();
		base.GetComponent<Hitable>().SetId(nextId);
		ResourceManager.Instance.AddObject(nextId, base.gameObject);
		Destroy(this);
		if (this.chest)
		{
			Chest componentInChildren = base.GetComponentInChildren<Chest>();
			ChestManager.Instance.AddChest(componentInChildren, nextId);
		}
		base.transform.SetParent(null);
	}

	public bool chest;
}
