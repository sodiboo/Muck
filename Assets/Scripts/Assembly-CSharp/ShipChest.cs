using System;
using System.Collections.Generic;
using UnityEngine;

public class ShipChest : MonoBehaviour
{
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

	public InventoryItem[] spawnLoot;

	private ConsistentRandom rand;
}
