using System;
using UnityEngine;

// Token: 0x02000091 RID: 145
public class FurnaceSync : Chest
{
	// Token: 0x06000375 RID: 885 RVA: 0x00012EEA File Offset: 0x000110EA
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

	// Token: 0x06000376 RID: 886 RVA: 0x00012EFC File Offset: 0x000110FC
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

	// Token: 0x06000377 RID: 887 RVA: 0x00012FCC File Offset: 0x000111CC
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

	// Token: 0x06000378 RID: 888 RVA: 0x00013038 File Offset: 0x00011238
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

	// Token: 0x06000379 RID: 889 RVA: 0x000130F8 File Offset: 0x000112F8
	private void StopProcessing()
	{
		this.processing = false;
		if (FurnaceUI.Instance)
		{
			FurnaceUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

	// Token: 0x0600037A RID: 890 RVA: 0x00013128 File Offset: 0x00011328
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

	// Token: 0x0600037B RID: 891 RVA: 0x00013184 File Offset: 0x00011384
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

	// Token: 0x0600037C RID: 892 RVA: 0x000131D4 File Offset: 0x000113D4
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

	// Token: 0x0600037D RID: 893 RVA: 0x0001324C File Offset: 0x0001144C
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

	// Token: 0x0600037E RID: 894 RVA: 0x000132C8 File Offset: 0x000114C8
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

	// Token: 0x04000378 RID: 888
	public InventoryItem.ProcessType processType;

	// Token: 0x04000379 RID: 889
	private bool processing;

	// Token: 0x0400037A RID: 890
	private float currentProcessTime;

	// Token: 0x0400037B RID: 891
	private float totalProcessTime;

	// Token: 0x0400037C RID: 892
	private float timeToProcess = 1f;

	// Token: 0x0400037D RID: 893
	private InventoryItem currentFuel;

	// Token: 0x0400037E RID: 894
	private InventoryItem currentMetal;
}
