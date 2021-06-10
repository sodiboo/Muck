using UnityEngine;
using UnityEngine.UI;

// Token: 0x0200000E RID: 14
public class CauldronUI : InventoryExtensions
{
	// Token: 0x0600003B RID: 59 RVA: 0x00003A5F File Offset: 0x00001C5F
	private void Awake()
	{
		CauldronUI.Instance = this;
		base.gameObject.SetActive(false);
	}

	// Token: 0x0600003C RID: 60 RVA: 0x00003A74 File Offset: 0x00001C74
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
					this.synchedCells[i].currentItem =Instantiate<InventoryItem>(cells[i]);
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

	// Token: 0x0600003D RID: 61 RVA: 0x00003B50 File Offset: 0x00001D50
	public override void UpdateCraftables()
	{
	}

	// Token: 0x0600003E RID: 62 RVA: 0x0000276E File Offset: 0x0000096E
	private void OnDisable()
	{
	}

	// Token: 0x0600003F RID: 63 RVA: 0x00003B60 File Offset: 0x00001D60
	private void OnEnable()
	{
	}

	// Token: 0x06000040 RID: 64 RVA: 0x0000276E File Offset: 0x0000096E
	private void Update()
	{
	}

	// Token: 0x06000041 RID: 65 RVA: 0x0000276E File Offset: 0x0000096E
	private void StopProcessing()
	{
	}

	// Token: 0x06000042 RID: 66 RVA: 0x00003B70 File Offset: 0x00001D70
	public void ProcessItem()
	{
	}

	// Token: 0x06000043 RID: 67 RVA: 0x0000276E File Offset: 0x0000096E
	private void UseMaterial(InventoryCell cell)
	{
	}

	// Token: 0x06000044 RID: 68 RVA: 0x00003B80 File Offset: 0x00001D80
	private void UseFuel(InventoryCell cell)
	{
	}

	// Token: 0x06000045 RID: 69 RVA: 0x0000276E File Offset: 0x0000096E
	private void AddMaterial(InventoryCell cell, InventoryItem processedItem)
	{
	}

	// Token: 0x06000046 RID: 70 RVA: 0x00003B90 File Offset: 0x00001D90
	public InventoryItem CanProcess()
	{
		return null;
	}

	// Token: 0x06000047 RID: 71 RVA: 0x00003BA0 File Offset: 0x00001DA0
	public InventoryItem FindItemByIngredients(InventoryCell[] iCells)
	{
		return null;
	}

	// Token: 0x06000048 RID: 72 RVA: 0x00003BB0 File Offset: 0x00001DB0
	private bool NoIngredients()
	{
		return false;
	}

	// Token: 0x0400003C RID: 60
	public InventoryCell[] ingredientCells;

	// Token: 0x0400003D RID: 61
	public InventoryCell fuelCell;

	// Token: 0x0400003E RID: 62
	public InventoryCell resultCell;

	// Token: 0x0400003F RID: 63
	public InventoryItem.ProcessType processType;

	// Token: 0x04000040 RID: 64
	public InventoryItem[] processableFood;

	// Token: 0x04000041 RID: 65
	private bool processing;

	// Token: 0x04000042 RID: 66
	private float currentProcessTime;

	// Token: 0x04000043 RID: 67
	private float totalProcessTime;

	// Token: 0x04000044 RID: 68
	private float timeToProcess;

	// Token: 0x04000045 RID: 69
	public RawImage processBar;

	// Token: 0x04000046 RID: 70
	public static CauldronUI Instance;

	// Token: 0x04000047 RID: 71
	public InventoryCell[] synchedCells;

	// Token: 0x04000048 RID: 72
	private float closedTime;

	// Token: 0x04000049 RID: 73
	private float closedProgress;
}
