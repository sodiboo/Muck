
using UnityEngine;

// Token: 0x0200006B RID: 107
public class FurnaceSync : Chest
{
	// Token: 0x0600029C RID: 668 RVA: 0x0000E72E File Offset: 0x0000C92E
	public float ProgressRatio()
	{
		return this.currentProcessTime / this.timeToProcess;
	}

	// Token: 0x0600029D RID: 669 RVA: 0x0000E740 File Offset: 0x0000C940
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

	// Token: 0x0600029E RID: 670 RVA: 0x0000E810 File Offset: 0x0000CA10
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

	// Token: 0x0600029F RID: 671 RVA: 0x0000E87C File Offset: 0x0000CA7C
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

	// Token: 0x060002A0 RID: 672 RVA: 0x0000E93C File Offset: 0x0000CB3C
	private void StopProcessing()
	{
		this.processing = false;
		if (FurnaceUI.Instance)
		{
			FurnaceUI.Instance.processBar.transform.localScale = Vector3.zero;
		}
	}

	// Token: 0x060002A1 RID: 673 RVA: 0x0000E96C File Offset: 0x0000CB6C
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

	// Token: 0x060002A2 RID: 674 RVA: 0x0000E9C8 File Offset: 0x0000CBC8
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

	// Token: 0x060002A3 RID: 675 RVA: 0x0000EA18 File Offset: 0x0000CC18
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

	// Token: 0x060002A4 RID: 676 RVA: 0x0000EA90 File Offset: 0x0000CC90
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

	// Token: 0x060002A5 RID: 677 RVA: 0x0000EB0C File Offset: 0x0000CD0C
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

	// Token: 0x04000282 RID: 642
	public InventoryItem.ProcessType processType;

	// Token: 0x04000283 RID: 643
	private bool processing;

	// Token: 0x04000284 RID: 644
	private float currentProcessTime;

	// Token: 0x04000285 RID: 645
	private float totalProcessTime;

	// Token: 0x04000286 RID: 646
	private float timeToProcess = 1f;

	// Token: 0x04000287 RID: 647
	private InventoryItem currentFuel;

	// Token: 0x04000288 RID: 648
	private InventoryItem currentMetal;
}
