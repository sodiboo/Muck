using System;
using UnityEngine;

// Token: 0x02000082 RID: 130
public class FurnaceSync : Chest
{
	// Token: 0x060002D6 RID: 726 RVA: 0x00004122 File Offset: 0x00002322
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

	// Token: 0x060002D7 RID: 727 RVA: 0x000129C8 File Offset: 0x00010BC8
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

	// Token: 0x060002D8 RID: 728 RVA: 0x00012A98 File Offset: 0x00010C98
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

	// Token: 0x060002D9 RID: 729 RVA: 0x00012B04 File Offset: 0x00010D04
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

	// Token: 0x060002DA RID: 730 RVA: 0x00004131 File Offset: 0x00002331
	private void StopProcessing()
	{
		this.processing = false;
		if (FurnaceUI.Instance)
		{
			FurnaceUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

	// Token: 0x060002DB RID: 731 RVA: 0x00012BC4 File Offset: 0x00010DC4
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

	// Token: 0x060002DC RID: 732 RVA: 0x00012C20 File Offset: 0x00010E20
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

	// Token: 0x060002DD RID: 733 RVA: 0x00012694 File Offset: 0x00010894
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

	// Token: 0x060002DE RID: 734 RVA: 0x00012C70 File Offset: 0x00010E70
	private void AddMaterial(InventoryItem item, int processedItemId)
	{
		if (this.cells[2] == null)
		{
			this.cells[2] =Instantiate<InventoryItem>(ItemManager.Instance.allItems[processedItemId]);
			this.cells[2].amount = 1;
		}
		else
		{
			this.cells[2].amount++;
		}
		ClientSend.ChestUpdate(base.id, 2, processedItemId, this.cells[2].amount);
	}

	// Token: 0x060002DF RID: 735 RVA: 0x00012CEC File Offset: 0x00010EEC
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

	// Token: 0x040002E2 RID: 738
	public InventoryItem.ProcessType processType;

	// Token: 0x040002E3 RID: 739
	private bool processing;

	// Token: 0x040002E4 RID: 740
	private float currentProcessTime;

	// Token: 0x040002E5 RID: 741
	private float totalProcessTime;

	// Token: 0x040002E6 RID: 742
	private float timeToProcess = 1f;

	// Token: 0x040002E7 RID: 743
	private InventoryItem currentFuel;

	// Token: 0x040002E8 RID: 744
	private InventoryItem currentMetal;
}
