using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x020000E2 RID: 226
public class FurnaceUI : InventoryExtensions
{
	// Token: 0x06000707 RID: 1799 RVA: 0x000245CA File Offset: 0x000227CA
	private void Awake()
	{
		FurnaceUI.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x06000708 RID: 1800 RVA: 0x000030D7 File Offset: 0x000012D7
	public override void UpdateCraftables()
	{
	}

	// Token: 0x06000709 RID: 1801 RVA: 0x000245E0 File Offset: 0x000227E0
	private void StartProcessing()
	{
	}

	// Token: 0x0600070A RID: 1802 RVA: 0x000030D7 File Offset: 0x000012D7
	private void OnDisable()
	{
	}

	// Token: 0x0600070B RID: 1803 RVA: 0x000245F0 File Offset: 0x000227F0
	private void OnEnable()
	{
	}

	// Token: 0x0600070C RID: 1804 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Update()
	{
	}

	// Token: 0x0600070D RID: 1805 RVA: 0x000030D7 File Offset: 0x000012D7
	private void StopProcessing()
	{
	}

	// Token: 0x0600070E RID: 1806 RVA: 0x00024600 File Offset: 0x00022800
	public void ProcessItem()
	{
	}

	// Token: 0x0600070F RID: 1807 RVA: 0x000030D7 File Offset: 0x000012D7
	private void UseMaterial(InventoryCell cell)
	{
	}

	// Token: 0x06000710 RID: 1808 RVA: 0x00024610 File Offset: 0x00022810
	private void UseFuel(InventoryCell cell)
	{
	}

	// Token: 0x06000711 RID: 1809 RVA: 0x00024620 File Offset: 0x00022820
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
					this.synchedCells[i].currentItem = Instantiate<InventoryItem>(cells[i]);
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

	// Token: 0x06000712 RID: 1810 RVA: 0x000030D7 File Offset: 0x000012D7
	private void AddMaterial(InventoryCell cell, int processedItemId)
	{
	}

	// Token: 0x06000713 RID: 1811 RVA: 0x000246FC File Offset: 0x000228FC
	public bool CanProcess()
	{
		return false;
	}

	// Token: 0x04000685 RID: 1669
	public InventoryCell metalCell;

	// Token: 0x04000686 RID: 1670
	public InventoryCell fuelCell;

	// Token: 0x04000687 RID: 1671
	public InventoryCell resultCell;

	// Token: 0x04000688 RID: 1672
	public InventoryItem.ProcessType processType;

	// Token: 0x04000689 RID: 1673
	private bool processing;

	// Token: 0x0400068A RID: 1674
	private float currentProcessTime;

	// Token: 0x0400068B RID: 1675
	private float totalProcessTime;

	// Token: 0x0400068C RID: 1676
	private float timeToProcess;

	// Token: 0x0400068D RID: 1677
	public RawImage processBar;

	// Token: 0x0400068E RID: 1678
	private InventoryItem currentFuel;

	// Token: 0x0400068F RID: 1679
	private InventoryItem currentMetal;

	// Token: 0x04000690 RID: 1680
	public static FurnaceUI Instance;

	// Token: 0x04000691 RID: 1681
	private float closedTime;

	// Token: 0x04000692 RID: 1682
	private float closedProgress;

	// Token: 0x04000693 RID: 1683
	public InventoryCell[] synchedCells;
}
