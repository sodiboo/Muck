using System;
using UnityEngine;


public class ChestUI : InventoryExtensions
{

	private void Awake()
	{
	}


	public void CopyChest(Chest c)
	{
		InventoryItem[] array = c.cells;
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


	public override void UpdateCraftables()
	{
	}


	public InventoryCell[] cells;
}
