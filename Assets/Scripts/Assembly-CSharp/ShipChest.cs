using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000107 RID: 263
public class ShipChest : MonoBehaviour
{
	// Token: 0x060007B5 RID: 1973 RVA: 0x00027968 File Offset: 0x00025B68
	private void Start()
	{
		this.rand = new ConsistentRandom(GameManager.GetSeed());
		Chest componentInChildren = base.GetComponentInChildren<Chest>();
		List<InventoryItem> list = new List<InventoryItem>();
		foreach (InventoryItem item in this.spawnLoot)
		{
			list.Add(item);
		}
		componentInChildren.InitChest(list, this.rand);
	}

	// Token: 0x04000771 RID: 1905
	public InventoryItem[] spawnLoot;

	// Token: 0x04000772 RID: 1906
	private ConsistentRandom rand;
}
