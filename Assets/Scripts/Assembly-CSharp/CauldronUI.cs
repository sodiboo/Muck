using System;
using UnityEngine;
using UnityEngine.UI;

// Token: 0x02000012 RID: 18
public class CauldronUI : InventoryExtensions
{
	// Token: 0x06000066 RID: 102 RVA: 0x000042DF File Offset: 0x000024DF
	private void Awake()
	{
		CauldronUI.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x06000067 RID: 103 RVA: 0x000042F4 File Offset: 0x000024F4
	public void CopyChest(Chest c)
	{
		if (!base.gameObject.activeInHierarchy)
		{
			return;
		}
		InventoryItem[] cells = OtherInput.Instance.currentChest.cells;
		for (int i = 0; i < cells.Length; i++)
		{
			if (i < this.synchedCells.Length)
			{
				if (c.locked[i])
				{
					this.synchedCells[i].enabled = false;
				}
				else
				{
					this.synchedCells[i].enabled = true;
				}
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
		this.processBar.transform.localScale = new Vector3(((CauldronSync)OtherInput.Instance.currentChest).ProgressRatio(), 1f, 1f);
	}

	// Token: 0x06000068 RID: 104 RVA: 0x000043D0 File Offset: 0x000025D0
	public override void UpdateCraftables()
	{
	}

	// Token: 0x06000069 RID: 105 RVA: 0x000030D7 File Offset: 0x000012D7
	private void OnDisable()
	{
	}

	// Token: 0x0600006A RID: 106 RVA: 0x000043E0 File Offset: 0x000025E0
	private void OnEnable()
	{
	}

	// Token: 0x0600006B RID: 107 RVA: 0x000030D7 File Offset: 0x000012D7
	private void Update()
	{
	}

	// Token: 0x0600006C RID: 108 RVA: 0x000030D7 File Offset: 0x000012D7
	private void StopProcessing()
	{
	}

	// Token: 0x0600006D RID: 109 RVA: 0x000043F0 File Offset: 0x000025F0
	public void ProcessItem()
	{
	}

	// Token: 0x0600006E RID: 110 RVA: 0x000030D7 File Offset: 0x000012D7
	private void UseMaterial(InventoryCell cell)
	{
	}

	// Token: 0x0600006F RID: 111 RVA: 0x00004400 File Offset: 0x00002600
	private void UseFuel(InventoryCell cell)
	{
	}

	// Token: 0x06000070 RID: 112 RVA: 0x000030D7 File Offset: 0x000012D7
	private void AddMaterial(InventoryCell cell, InventoryItem processedItem)
	{
	}

	// Token: 0x06000071 RID: 113 RVA: 0x00004410 File Offset: 0x00002610
	public InventoryItem CanProcess()
	{
		return null;
	}

	// Token: 0x06000072 RID: 114 RVA: 0x00004420 File Offset: 0x00002620
	public InventoryItem FindItemByIngredients(InventoryCell[] iCells)
	{
		return null;
	}

	// Token: 0x06000073 RID: 115 RVA: 0x00004430 File Offset: 0x00002630
	private bool NoIngredients()
	{
		return false;
	}

	// Token: 0x04000065 RID: 101
	public InventoryCell[] ingredientCells;

	// Token: 0x04000066 RID: 102
	public InventoryCell fuelCell;

	// Token: 0x04000067 RID: 103
	public InventoryCell resultCell;

	// Token: 0x04000068 RID: 104
	public InventoryItem.ProcessType processType;

	// Token: 0x04000069 RID: 105
	public InventoryItem[] processableFood;

	// Token: 0x0400006A RID: 106
	private bool processing;

	// Token: 0x0400006B RID: 107
	private float currentProcessTime;

	// Token: 0x0400006C RID: 108
	private float totalProcessTime;

	// Token: 0x0400006D RID: 109
	private float timeToProcess;

	// Token: 0x0400006E RID: 110
	public RawImage processBar;

	// Token: 0x0400006F RID: 111
	public static CauldronUI Instance;

	// Token: 0x04000070 RID: 112
	public InventoryCell[] synchedCells;

	// Token: 0x04000071 RID: 113
	private float closedTime;

	// Token: 0x04000072 RID: 114
	private float closedProgress;
}
