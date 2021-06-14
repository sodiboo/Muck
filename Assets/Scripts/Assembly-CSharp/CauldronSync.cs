using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000081 RID: 129
public class CauldronSync : Chest
{
	// Token: 0x060002CA RID: 714 RVA: 0x000040B4 File Offset: 0x000022B4
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

	// Token: 0x060002CB RID: 715 RVA: 0x000123C8 File Offset: 0x000105C8
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

	// Token: 0x060002CC RID: 716 RVA: 0x00012494 File Offset: 0x00010694
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

	// Token: 0x060002CD RID: 717 RVA: 0x000040C3 File Offset: 0x000022C3
	private void StopProcessing()
	{
		this.processing = false;
		if (CauldronUI.Instance)
		{
			CauldronUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

	// Token: 0x060002CE RID: 718 RVA: 0x00012550 File Offset: 0x00010750
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

	// Token: 0x060002CF RID: 719 RVA: 0x00012644 File Offset: 0x00010844
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

	// Token: 0x060002D0 RID: 720 RVA: 0x00012694 File Offset: 0x00010894
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

	// Token: 0x060002D1 RID: 721 RVA: 0x0001270C File Offset: 0x0001090C
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

	// Token: 0x060002D2 RID: 722 RVA: 0x000127A4 File Offset: 0x000109A4
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

	// Token: 0x060002D3 RID: 723 RVA: 0x00012860 File Offset: 0x00010A60
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

	// Token: 0x060002D4 RID: 724 RVA: 0x0001298C File Offset: 0x00010B8C
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

	// Token: 0x040002DB RID: 731
	private int fuelCellId;

	// Token: 0x040002DC RID: 732
	private int resultCellId = 5;

	// Token: 0x040002DD RID: 733
	private int[] ingredientCells = new int[]
	{
		1,
		2,
		3,
		4
	};

	// Token: 0x040002DE RID: 734
	private bool processing;

	// Token: 0x040002DF RID: 735
	private float currentProcessTime;

	// Token: 0x040002E0 RID: 736
	private float totalProcessTime;

	// Token: 0x040002E1 RID: 737
	private float timeToProcess = 1f;
}
