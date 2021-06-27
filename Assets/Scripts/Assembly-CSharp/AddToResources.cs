using System;
using UnityEngine;

// Token: 0x02000002 RID: 2
public class AddToResources : MonoBehaviour
{
	// Token: 0x06000001 RID: 1 RVA: 0x00002050 File Offset: 0x00000250
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

	// Token: 0x04000001 RID: 1
	public bool chest;
}
