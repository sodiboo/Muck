using System;
using System.Collections.Generic;
using UnityEngine;

public class CauldronSync : Chest
{
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

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

	private void StopProcessing()
	{
		this.processing = false;
		if (CauldronUI.Instance)
		{
			CauldronUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

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

	private int fuelCellId;

	private int resultCellId = 5;

	private int[] ingredientCells = new int[]
	{
		1,
		2,
		3,
		4
	};

	private bool processing;

	private float currentProcessTime;

	private float totalProcessTime;

	private float timeToProcess = 1f;
}
