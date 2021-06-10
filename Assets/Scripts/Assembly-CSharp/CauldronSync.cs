
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200006A RID: 106
public class CauldronSync : Chest
{
	// Token: 0x06000290 RID: 656 RVA: 0x0000E0BE File Offset: 0x0000C2BE
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

	// Token: 0x06000291 RID: 657 RVA: 0x0000E0D0 File Offset: 0x0000C2D0
	public override void UpdateCraftables()
	{
		InventoryItem inventoryItem = this.CanProcess();
		if (!this.processing && inventoryItem != null)
		{
			ItemFuel fuel = this.cells[this.fuelCellId].fuel;
			this.totalProcessTime = 0f;
			this.currentProcessTime = 0f;
			this.timeToProcess = inventoryItem.processTime / fuel.speedMultiplier;
			this.processing = true;
		}
		if (CauldronUI.Instance && OtherInput.Instance.currentChest == this)
		{
			CauldronUI.Instance.CopyChest(OtherInput.Instance.currentChest);
			CauldronUI.Instance.processBar.transform.localScale = new Vector3(this.currentProcessTime / this.timeToProcess, 1f, 1f);
		}
	}

	// Token: 0x06000292 RID: 658 RVA: 0x0000E19C File Offset: 0x0000C39C
	private void Update()
	{
		if (!this.processing)
		{
			return;
		}
		if (!this.CanProcess())
		{
			this.StopProcessing();
			return;
		}
		this.currentProcessTime += Time.deltaTime;
		this.totalProcessTime += Time.deltaTime;
		if (CauldronUI.Instance && OtherInput.Instance.currentChest == this)
		{
			CauldronUI.Instance.processBar.transform.localScale = new Vector3(this.currentProcessTime / this.timeToProcess, 1f, 1f);
		}
		if (this.currentProcessTime >= this.timeToProcess)
		{
			this.ProcessItem();
			this.currentProcessTime = 0f;
		}
	}

	// Token: 0x06000293 RID: 659 RVA: 0x0000E257 File Offset: 0x0000C457
	private void StopProcessing()
	{
		this.processing = false;
		if (CauldronUI.Instance)
		{
			CauldronUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

	// Token: 0x06000294 RID: 660 RVA: 0x0000E288 File Offset: 0x0000C488
	public void ProcessItem()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		InventoryItem inventoryItem = this.CanProcess();
		foreach (int num in this.ingredientCells)
		{
			if (!(this.cells[num] == null))
			{
				InventoryItem.CraftRequirement[] requirements = inventoryItem.requirements;
				for (int j = 0; j < requirements.Length; j++)
				{
					if (requirements[j].item.id == this.cells[num].id)
					{
						this.UseMaterial(this.cells[num], num);
						break;
					}
				}
			}
		}
		this.UseFuel(this.cells[this.fuelCellId]);
		this.AddMaterial(this.cells[this.resultCellId], inventoryItem.id);
		this.UpdateCraftables();
		if (CauldronUI.Instance && OtherInput.Instance.currentChest == this)
		{
			CauldronUI.Instance.CopyChest(OtherInput.Instance.currentChest);
		}
	}

	// Token: 0x06000295 RID: 661 RVA: 0x0000E37C File Offset: 0x0000C57C
	private void UseMaterial(InventoryItem materialItem, int cellId)
	{
		materialItem.amount--;
		if (materialItem.amount <= 0)
		{
			materialItem = null;
			ClientSend.ChestUpdate(base.id, cellId, -1, 0);
			return;
		}
		ClientSend.ChestUpdate(base.id, cellId, materialItem.id, materialItem.amount);
	}

	// Token: 0x06000296 RID: 662 RVA: 0x0000E3CC File Offset: 0x0000C5CC
	private void UseFuel(InventoryItem fuelItem)
	{
		ItemFuel fuel = fuelItem.fuel;
		fuel.currentUses--;
		if (fuel.currentUses <= 0)
		{
			fuelItem.amount--;
			fuel.currentUses = fuel.maxUses;
			ClientSend.ChestUpdate(base.id, 0, fuelItem.id, fuelItem.amount);
		}
		if (fuelItem.amount <= 0)
		{
			fuelItem = null;
			ClientSend.ChestUpdate(base.id, 0, -1, 0);
		}
	}

	// Token: 0x06000297 RID: 663 RVA: 0x0000E444 File Offset: 0x0000C644
	private void AddMaterial(InventoryItem item, int processedItemId)
	{
		if (this.cells[this.resultCellId] == null)
		{
			this.cells[this.resultCellId] =Instantiate<InventoryItem>(ItemManager.Instance.allItems[processedItemId]);
			this.cells[this.resultCellId].amount = 1;
		}
		else
		{
			this.cells[this.resultCellId].amount++;
		}
		ClientSend.ChestUpdate(base.id, this.resultCellId, processedItemId, this.cells[this.resultCellId].amount);
	}

	// Token: 0x06000298 RID: 664 RVA: 0x0000E4DC File Offset: 0x0000C6DC
	public InventoryItem CanProcess()
	{
		if (this.NoIngredients() || !this.cells[this.fuelCellId])
		{
			return null;
		}
		InventoryItem inventoryItem = this.FindItemByIngredients(this.ingredientCells);
		if (inventoryItem == null)
		{
			return null;
		}
		if (this.cells[this.resultCellId] != null)
		{
			if (inventoryItem.id != this.cells[this.resultCellId].id)
			{
				return null;
			}
			if (this.cells[this.resultCellId].amount + inventoryItem.craftAmount > this.cells[this.resultCellId].max)
			{
				return null;
			}
		}
		if (this.cells[this.fuelCellId].tag == InventoryItem.ItemTag.Fuel)
		{
			return inventoryItem;
		}
		return null;
	}

	// Token: 0x06000299 RID: 665 RVA: 0x0000E598 File Offset: 0x0000C798
	public InventoryItem FindItemByIngredients(int[] iCells)
	{
		List<InventoryItem> list = new List<InventoryItem>();
		foreach (int num in iCells)
		{
			if (this.cells[num] != null)
			{
				list.Add(this.cells[num]);
			}
		}
		foreach (InventoryItem inventoryItem in CauldronUI.Instance.processableFood)
		{
			int count = list.Count;
			int num2 = 0;
			if (inventoryItem.requirements.Length == count)
			{
				bool flag = false;
				foreach (InventoryItem.CraftRequirement craftRequirement in inventoryItem.requirements)
				{
					foreach (InventoryItem inventoryItem2 in list)
					{
						if (inventoryItem2.id == craftRequirement.item.id)
						{
							if (inventoryItem2.amount < craftRequirement.amount)
							{
								flag = true;
								break;
							}
							num2++;
							break;
						}
					}
				}
				if (!flag && num2 == count)
				{
					return inventoryItem;
				}
			}
		}
		return null;
	}

	// Token: 0x0600029A RID: 666 RVA: 0x0000E6C4 File Offset: 0x0000C8C4
	private bool NoIngredients()
	{
		foreach (int num in this.ingredientCells)
		{
			if (this.cells[num] != null)
			{
				return false;
			}
		}
		return true;
	}

	// Token: 0x0400027B RID: 635
	private int fuelCellId;

	// Token: 0x0400027C RID: 636
	private int resultCellId = 5;

	// Token: 0x0400027D RID: 637
	private int[] ingredientCells = new int[]
	{
		1,
		2,
		3,
		4
	};

	// Token: 0x0400027E RID: 638
	private bool processing;

	// Token: 0x0400027F RID: 639
	private float currentProcessTime;

	// Token: 0x04000280 RID: 640
	private float totalProcessTime;

	// Token: 0x04000281 RID: 641
	private float timeToProcess = 1f;
}
