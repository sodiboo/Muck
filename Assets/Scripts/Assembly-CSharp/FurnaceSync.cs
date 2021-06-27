using System;
using UnityEngine;

public class FurnaceSync : Chest
{
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

	public override void UpdateCraftables()
	{
		if (this.processing && this.CanProcess() && (this.currentFuel.id != this.cells[0].id || this.currentMetal.id != this.cells[1].id))
		{
			this.StartProcessing();
		}
		if (!this.processing && this.CanProcess())
		{
			this.StartProcessing();
		}
		if (FurnaceUI.Instance != null && OtherInput.Instance.currentChest == this)
		{
			FurnaceUI.Instance.CopyChest(OtherInput.Instance.currentChest);
			FurnaceUI.Instance.processBar.transform.localScale = new Vector3(this.currentProcessTime / this.timeToProcess, 1f, 1f);
		}
	}

	private void StartProcessing()
	{
		this.currentFuel = this.cells[0];
		this.currentMetal = this.cells[1];
		ItemFuel fuel = this.currentFuel.fuel;
		this.totalProcessTime = 0f;
		this.currentProcessTime = 0f;
		this.timeToProcess = this.currentMetal.processTime / fuel.speedMultiplier;
		this.processing = true;
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
			MonoBehaviour.print("stopped due to one of these conditions");
			return;
		}
		this.currentProcessTime += Time.deltaTime;
		this.totalProcessTime += Time.deltaTime;
		if (FurnaceUI.Instance && OtherInput.Instance.currentChest == this)
		{
			FurnaceUI.Instance.processBar.transform.localScale = new Vector3(this.currentProcessTime / this.timeToProcess, 1f, 1f);
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
		if (FurnaceUI.Instance)
		{
			FurnaceUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

	public void ProcessItem()
	{
		if (!LocalClient.serverOwner)
		{
			return;
		}
		int id = this.cells[1].processedItem.id;
		this.UseMaterial(this.cells[1]);
		this.UseFuel(this.cells[0]);
		this.AddMaterial(this.cells[2], id);
		this.UpdateCraftables();
	}

	private void UseMaterial(InventoryItem materialItem)
	{
		materialItem.amount--;
		if (materialItem.amount <= 0)
		{
			materialItem = null;
			ClientSend.ChestUpdate(base.id, 1, -1, 0);
			return;
		}
		ClientSend.ChestUpdate(base.id, 1, materialItem.id, materialItem.amount);
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
		if (this.cells[2] == null)
		{
			this.cells[2] = Instantiate<InventoryItem>(ItemManager.Instance.allItems[processedItemId]);
			this.cells[2].amount = 1;
		}
		else
		{
			this.cells[2].amount++;
		}
		ClientSend.ChestUpdate(base.id, 2, processedItemId, this.cells[2].amount);
	}

	public bool CanProcess()
	{
		if (!this.cells[1] || !this.cells[0])
		{
			return false;
		}
		if (this.cells[2] != null)
		{
			if (this.cells[1].processedItem == null || this.cells[1].processedItem.id != this.cells[2].id)
			{
				return false;
			}
			if (this.cells[2].amount >= this.cells[2].max)
			{
				return false;
			}
		}
		return this.cells[1].processable && this.cells[1].processType == this.processType && this.cells[0].tag == InventoryItem.ItemTag.Fuel;
	}

	public InventoryItem.ProcessType processType;

	private bool processing;

	private float currentProcessTime;

	private float totalProcessTime;

	private float timeToProcess = 1f;

	private InventoryItem currentFuel;

	private InventoryItem currentMetal;
}
