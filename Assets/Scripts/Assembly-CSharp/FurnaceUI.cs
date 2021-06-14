using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000F7 RID: 247
public class FurnaceUI : InventoryExtensions
{
	// Token: 0x06000684 RID: 1668 RVA: 0x000062A4 File Offset: 0x000044A4
	private void Awake()
	{
		FurnaceUI.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x06000685 RID: 1669 RVA: 0x00002147 File Offset: 0x00000347
	public override void UpdateCraftables()
	{
	}

	// Token: 0x06000686 RID: 1670 RVA: 0x00022264 File Offset: 0x00020464
	private void StartProcessing()
	{
	}

	// Token: 0x06000687 RID: 1671 RVA: 0x00002147 File Offset: 0x00000347
	private void OnDisable()
	{
	}

	// Token: 0x06000688 RID: 1672 RVA: 0x00008A38 File Offset: 0x00006C38
	private void OnEnable()
	{
	}

	// Token: 0x06000689 RID: 1673 RVA: 0x00002147 File Offset: 0x00000347
	private void Update()
	{
	}

	// Token: 0x0600068A RID: 1674 RVA: 0x00002147 File Offset: 0x00000347
	private void StopProcessing()
	{
	}

	// Token: 0x0600068B RID: 1675 RVA: 0x00022274 File Offset: 0x00020474
	public void ProcessItem()
	{
	}

	// Token: 0x0600068C RID: 1676 RVA: 0x00002147 File Offset: 0x00000347
	private void UseMaterial(InventoryCell cell)
	{
	}

	// Token: 0x0600068D RID: 1677 RVA: 0x00008A28 File Offset: 0x00006C28
	private void UseFuel(InventoryCell cell)
	{
	}

	// Token: 0x0600068E RID: 1678 RVA: 0x00022284 File Offset: 0x00020484
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

	// Token: 0x0600068F RID: 1679 RVA: 0x00002147 File Offset: 0x00000347
	private void AddMaterial(InventoryCell cell, int processedItemId)
	{
	}

	// Token: 0x06000690 RID: 1680 RVA: 0x00022360 File Offset: 0x00020560
	public bool CanProcess()
	{
		return false;
	}

	// Token: 0x0400066B RID: 1643
	public InventoryCell metalCell;

	// Token: 0x0400066C RID: 1644
	public InventoryCell fuelCell;

	// Token: 0x0400066D RID: 1645
	public InventoryCell resultCell;

	// Token: 0x0400066E RID: 1646
	public InventoryItem.ProcessType processType;

	// Token: 0x0400066F RID: 1647
	private bool processing;

	// Token: 0x04000670 RID: 1648
	private float currentProcessTime;

	// Token: 0x04000671 RID: 1649
	private float totalProcessTime;

	// Token: 0x04000672 RID: 1650
	private float timeToProcess;

	// Token: 0x04000673 RID: 1651
	public RawImage processBar;

	// Token: 0x04000674 RID: 1652
	private InventoryItem currentFuel;

	// Token: 0x04000675 RID: 1653
	private InventoryItem currentMetal;

	// Token: 0x04000676 RID: 1654
	public static FurnaceUI Instance;

	// Token: 0x04000677 RID: 1655
	private float closedTime;

	// Token: 0x04000678 RID: 1656
	private float closedProgress;

	// Token: 0x04000679 RID: 1657
	public InventoryCell[] synchedCells;
}
