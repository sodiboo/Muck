using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000090 RID: 144
public class CauldronSync : Chest
{
	// Token: 0x06000369 RID: 873 RVA: 0x0001287A File Offset: 0x00010A7A
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

	// Token: 0x0600036A RID: 874 RVA: 0x0001288C File Offset: 0x00010A8C
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

	// Token: 0x0600036B RID: 875 RVA: 0x00012958 File Offset: 0x00010B58
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

	// Token: 0x0600036C RID: 876 RVA: 0x00012A13 File Offset: 0x00010C13
	private void StopProcessing()
	{
		this.processing = false;
		if (CauldronUI.Instance)
		{
			CauldronUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

	// Token: 0x0600036D RID: 877 RVA: 0x00012A44 File Offset: 0x00010C44
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

	// Token: 0x0600036E RID: 878 RVA: 0x00012B38 File Offset: 0x00010D38
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

	// Token: 0x0600036F RID: 879 RVA: 0x00012B88 File Offset: 0x00010D88
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

	// Token: 0x06000370 RID: 880 RVA: 0x00012C00 File Offset: 0x00010E00
	private void AddMaterial(InventoryItem item, int processedItemId)
	{
		if (this.cells[this.resultCellId] == null)
		{
			this.cells[this.resultCellId] = Instantiate<InventoryItem>(ItemManager.Instance.allItems[processedItemId]);
			this.cells[this.resultCellId].amount = 1;
		}
		else
		{
			this.cells[this.resultCellId].amount++;
		}
		ClientSend.ChestUpdate(base.id, this.resultCellId, processedItemId, this.cells[this.resultCellId].amount);
	}

	// Token: 0x06000371 RID: 881 RVA: 0x00012C98 File Offset: 0x00010E98
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

	// Token: 0x06000372 RID: 882 RVA: 0x00012D54 File Offset: 0x00010F54
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

	// Token: 0x06000373 RID: 883 RVA: 0x00012E80 File Offset: 0x00011080
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

	// Token: 0x04000371 RID: 881
	private int fuelCellId;

	// Token: 0x04000372 RID: 882
	private int resultCellId = 5;

	// Token: 0x04000373 RID: 883
	private int[] ingredientCells = new int[]
	{
		1,
		2,
		3,
		4
	};

	// Token: 0x04000374 RID: 884
	private bool processing;

	// Token: 0x04000375 RID: 885
	private float currentProcessTime;

	// Token: 0x04000376 RID: 886
	private float totalProcessTime;

	// Token: 0x04000377 RID: 887
	private float timeToProcess = 1f;
}
