using System;
using UnityEngine;

public class ChestUI : InventoryExtensions
{
	private void Awake()
	{
	}

	public void CopyChest(Chest c, bool addMap = false)
	{
		InventoryItem[] array = c.cells;
		if (addMap)
		{
			array = this.AddMapToCells(array);
		}
		Debug.Log("Checking loot, cells: " + this.cells.Length);
		for (int i = 0; i < this.cells.Length; i++)
		{
			if (c.locked[i])
			{
				this.cells[i].gameObject.SetActive(false);
			}
			else
			{
				this.cells[i].gameObject.SetActive(true);
			}
			if (array[i] != null)
			{
				this.cells[i].currentItem = Instantiate<InventoryItem>(array[i]);
			}
			else
			{
				this.cells[i].currentItem = null;
			}
			this.cells[i].UpdateCell();
		}
	}

	private InventoryItem[] AddMapToCells(InventoryItem[] cells)
	{
		for (int i = 0; i < cells.Length; i++)
		{
			if (cells[i] == null)
			{
				cells[i] = Boat.Instance.mapItem;
				break;
			}
		}
		return cells;
	}

	public override void UpdateCraftables()
	{
	}

	public InventoryCell[] cells;
}
