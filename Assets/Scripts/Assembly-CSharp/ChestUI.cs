
using UnityEngine;

// Token: 0x020000B9 RID: 185
public class ChestUI : InventoryExtensions
{
	// Token: 0x060005ED RID: 1517 RVA: 0x0000276E File Offset: 0x0000096E
	private void Awake()
	{
	}

	// Token: 0x060005EE RID: 1518 RVA: 0x0001E65C File Offset: 0x0001C85C
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

	// Token: 0x060005EF RID: 1519 RVA: 0x0000276E File Offset: 0x0000096E
	public override void UpdateCraftables()
	{
	}

	// Token: 0x04000563 RID: 1379
	public InventoryCell[] cells;
}
