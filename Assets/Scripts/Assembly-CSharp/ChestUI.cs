using System;
using UnityEngine;

// Token: 0x020000F6 RID: 246
public class ChestUI : InventoryExtensions
{
	// Token: 0x06000680 RID: 1664 RVA: 0x00002147 File Offset: 0x00000347
	private void Awake()
	{
	}

	// Token: 0x06000681 RID: 1665 RVA: 0x000221CC File Offset: 0x000203CC
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
				this.cells[i].currentItem =Instantiate<InventoryItem>(array[i]);
			}
			else
			{
				this.cells[i].currentItem = null;
			}
			this.cells[i].UpdateCell();
		}
	}

	// Token: 0x06000682 RID: 1666 RVA: 0x00002147 File Offset: 0x00000347
	public override void UpdateCraftables()
	{
	}

	// Token: 0x0400066A RID: 1642
	public InventoryCell[] cells;
}
