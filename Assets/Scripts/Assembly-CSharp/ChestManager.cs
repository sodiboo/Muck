using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000AD RID: 173
public class ChestManager : MonoBehaviour
{
	// Token: 0x0600047C RID: 1148 RVA: 0x000174CB File Offset: 0x000156CB
	private void Awake()
	{
		ChestManager.Instance = this;
		this.chests = new Dictionary<int, Chest>();
		this.chestId = (int)IdOffsets.chestIdRange.x;
	}

	// Token: 0x0600047D RID: 1149 RVA: 0x000174EF File Offset: 0x000156EF
	public void AddChest(Chest c, int id)
	{
		c.id = id;
		this.chests.Add(id, c);
	}

	// Token: 0x0600047E RID: 1150 RVA: 0x00017508 File Offset: 0x00015708
	public int GetNextId()
	{
		int num = this.chestId;
		this.chestId = num + 1;
		return num;
	}

	// Token: 0x0600047F RID: 1151 RVA: 0x00017526 File Offset: 0x00015726
	public void UseChest(int chestId, bool inUse)
	{
		this.chests[chestId].Use(inUse);
	}

	// Token: 0x06000480 RID: 1152 RVA: 0x0001753A File Offset: 0x0001573A
	public void SendChestUpdate(int chestId, int cellId)
	{
		this.chests[chestId].locked[cellId] = true;
	}

	// Token: 0x06000481 RID: 1153 RVA: 0x00017550 File Offset: 0x00015750
	public void UpdateChest(int chestId, int cellId, int itemId, int amount)
	{
		InventoryItem inventoryItem = null;
		if (itemId != -1)
		{
			inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem.Copy(ItemManager.Instance.allItems[itemId], amount);
		}
		this.chests[chestId].cells[cellId] = inventoryItem;
		this.chests[chestId].locked[cellId] = false;
		this.chests[chestId].UpdateCraftables();
	}

	// Token: 0x06000482 RID: 1154 RVA: 0x000175BA File Offset: 0x000157BA
	public bool IsChestOpen(int chestId)
	{
		return this.chests[chestId].IsUsed();
	}

	// Token: 0x06000483 RID: 1155 RVA: 0x000175D0 File Offset: 0x000157D0
	public void RemoveChest(int chestId)
	{
		Chest chest = this.chests[chestId];
		this.chests.Remove(chestId);
		Destroy(chest.transform.parent.gameObject);
		if (OtherInput.Instance.currentChest == chest)
		{
			OtherInput.Instance.ToggleInventory(OtherInput.CraftingState.Inventory);
		}
		if (LocalClient.serverOwner)
		{
			this.DropChest(chest);
		}
	}

	// Token: 0x06000484 RID: 1156 RVA: 0x00017638 File Offset: 0x00015838
	private void DropChest(Chest chest)
	{
		Vector3 vector = chest.transform.position;
		foreach (InventoryItem inventoryItem in chest.cells)
		{
			if (inventoryItem != null)
			{
				vector += Vector3.up * (inventoryItem.mesh.bounds.extents.y * 2f);
				int nextId = ItemManager.Instance.GetNextId();
				ItemManager.Instance.DropItemAtPosition(inventoryItem.id, inventoryItem.amount, vector, nextId);
				ServerSend.DropItemAtPosition(inventoryItem.id, inventoryItem.amount, nextId, vector);
			}
		}
	}

	// Token: 0x04000440 RID: 1088
	public Dictionary<int, Chest> chests;

	// Token: 0x04000441 RID: 1089
	private int chestId;

	// Token: 0x04000442 RID: 1090
	public static ChestManager Instance;
}
