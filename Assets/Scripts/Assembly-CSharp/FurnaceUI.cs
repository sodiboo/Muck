
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000BA RID: 186
public class FurnaceUI : InventoryExtensions
{
	// Token: 0x060005F1 RID: 1521 RVA: 0x0001E6F2 File Offset: 0x0001C8F2
	private void Awake()
	{
		FurnaceUI.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x060005F2 RID: 1522 RVA: 0x0000276E File Offset: 0x0000096E
	public override void UpdateCraftables()
	{
	}

	// Token: 0x060005F3 RID: 1523 RVA: 0x0001E708 File Offset: 0x0001C908
	private void StartProcessing()
	{
	}

	// Token: 0x060005F4 RID: 1524 RVA: 0x0000276E File Offset: 0x0000096E
	private void OnDisable()
	{
	}

	// Token: 0x060005F5 RID: 1525 RVA: 0x0001E718 File Offset: 0x0001C918
	private void OnEnable()
	{
	}

	// Token: 0x060005F6 RID: 1526 RVA: 0x0000276E File Offset: 0x0000096E
	private void Update()
	{
	}

	// Token: 0x060005F7 RID: 1527 RVA: 0x0000276E File Offset: 0x0000096E
	private void StopProcessing()
	{
	}

	// Token: 0x060005F8 RID: 1528 RVA: 0x0001E728 File Offset: 0x0001C928
	public void ProcessItem()
	{
	}

	// Token: 0x060005F9 RID: 1529 RVA: 0x0000276E File Offset: 0x0000096E
	private void UseMaterial(InventoryCell cell)
	{
	}

	// Token: 0x060005FA RID: 1530 RVA: 0x0001E738 File Offset: 0x0001C938
	private void UseFuel(InventoryCell cell)
	{
	}

	// Token: 0x060005FB RID: 1531 RVA: 0x0001E748 File Offset: 0x0001C948
	public void CopyChest(Chest c)
	{
		if (!base.gameObject.activeInHierarchy)
		{
			return;
		}
		InventoryItem[] cells = OtherInput.Instance.currentChest.cells;
		for (int i = 0; i < cells.Length; i++)
		{
			if (c.locked[i])
			{
				this.synchedCells[i].enabled = false;
			}
			else
			{
				this.synchedCells[i].enabled = true;
			}
			if (i < this.synchedCells.Length)
			{
				if (cells[i] != null)
				{
					this.synchedCells[i].currentItem =Instantiate<InventoryItem>(cells[i]);
				}
				else
				{
					this.synchedCells[i].currentItem = null;
				}
				this.synchedCells[i].UpdateCell();
			}
		}
		this.processBar.transform.localScale = new Vector3(((FurnaceSync)OtherInput.Instance.currentChest).ProgressRatio(), 1f, 1f);
	}

	// Token: 0x060005FC RID: 1532 RVA: 0x0000276E File Offset: 0x0000096E
	private void AddMaterial(InventoryCell cell, int processedItemId)
	{
	}

	// Token: 0x060005FD RID: 1533 RVA: 0x0001E824 File Offset: 0x0001CA24
	public bool CanProcess()
	{
		return false;
	}

	// Token: 0x04000564 RID: 1380
	public InventoryCell metalCell;

	// Token: 0x04000565 RID: 1381
	public InventoryCell fuelCell;

	// Token: 0x04000566 RID: 1382
	public InventoryCell resultCell;

	// Token: 0x04000567 RID: 1383
	public InventoryItem.ProcessType processType;

	// Token: 0x04000568 RID: 1384
	private bool processing;

	// Token: 0x04000569 RID: 1385
	private float currentProcessTime;

	// Token: 0x0400056A RID: 1386
	private float totalProcessTime;

	// Token: 0x0400056B RID: 1387
	private float timeToProcess;

	// Token: 0x0400056C RID: 1388
	public RawImage processBar;

	// Token: 0x0400056D RID: 1389
	private InventoryItem currentFuel;

	// Token: 0x0400056E RID: 1390
	private InventoryItem currentMetal;

	// Token: 0x0400056F RID: 1391
	public static FurnaceUI Instance;

	// Token: 0x04000570 RID: 1392
	private float closedTime;

	// Token: 0x04000571 RID: 1393
	private float closedProgress;

	// Token: 0x04000572 RID: 1394
	public InventoryCell[] synchedCells;
}
