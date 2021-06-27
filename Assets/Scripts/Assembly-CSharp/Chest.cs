using System;
using System.Collections.Generic;
using UnityEngine;

public class Chest : MonoBehaviour
{
	public int id { get; set; }

	private void Start()
	{
		this.locked = new bool[this.chestSize];
		this.animator = base.GetComponent<Animator>();
		if (this.cells == null || this.cells.Length == 0)
		{
			this.cells = new InventoryItem[this.chestSize];
		}
	}

	public void Use(bool b)
	{
		if (this.animator)
		{
			this.animator.SetBool("Use", b);
		}
		this.inUse = b;
	}

	public bool IsUsed()
	{
		return this.inUse;
	}

	public virtual void UpdateCraftables()
	{
	}

	public void InitChest(List<InventoryItem> items, ConsistentRandom rand)
	{
		this.cells = new InventoryItem[this.chestSize];
		List<int> list = new List<int>();
		for (int i = 0; i < this.chestSize; i++)
		{
			list.Add(i);
		}
		foreach (InventoryItem inventoryItem in items)
		{
			int num = rand.Next(0, list.Count);
			list.Remove(num);
			this.cells[num] = inventoryItem;
		}
	}

	public InventoryItem[] cells;

	public int chestSize = 21;

	public bool inUse;

	public bool[] locked;

	private Animator animator;
}
