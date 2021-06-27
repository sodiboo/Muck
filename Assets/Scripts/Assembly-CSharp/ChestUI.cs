using System;
using UnityEngine;

// Token: 0x020000E1 RID: 225
public class ChestUI : InventoryExtensions
{
	// Token: 0x06000702 RID: 1794 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Awake()
	{
	}

	// Token: 0x06000703 RID: 1795 RVA: 0x000244D4 File Offset: 0x000226D4
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

	// Token: 0x06000704 RID: 1796 RVA: 0x00024594 File Offset: 0x00022794
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

	// Token: 0x06000705 RID: 1797 RVA: 0x000030D7 File Offset: 0x000012D7
	public override void UpdateCraftables()
	{
	}

	// Token: 0x04000684 RID: 1668
	public InventoryCell[] cells;
}
