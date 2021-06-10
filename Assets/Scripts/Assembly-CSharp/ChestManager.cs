
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000087 RID: 135
public class ChestManager : MonoBehaviour
{
	// Token: 0x0600038F RID: 911 RVA: 0x000126A7 File Offset: 0x000108A7
	private void Awake()
	{
		ChestManager.Instance = this;
		this.chests = new Dictionary<int, Chest>();
		this.chestId = (int)IdOffsets.chestIdRange.x;
	}

	// Token: 0x06000390 RID: 912 RVA: 0x000126CB File Offset: 0x000108CB
	public void AddChest(Chest c, int id)
	{
		c.id = id;
		this.chests.Add(id, c);
	}

	// Token: 0x06000391 RID: 913 RVA: 0x000126E4 File Offset: 0x000108E4
	public int GetNextId()
	{
		int num = this.chestId;
		this.chestId = num + 1;
		return num;
	}

	// Token: 0x06000392 RID: 914 RVA: 0x00012702 File Offset: 0x00010902
	public void UseChest(int chestId, bool inUse)
	{
		this.chests[chestId].Use(inUse);
	}

	// Token: 0x06000393 RID: 915 RVA: 0x00012716 File Offset: 0x00010916
	public void SendChestUpdate(int chestId, int cellId)
	{
		this.chests[chestId].locked[cellId] = true;
	}

	// Token: 0x06000394 RID: 916 RVA: 0x0001272C File Offset: 0x0001092C
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

	// Token: 0x06000395 RID: 917 RVA: 0x00012796 File Offset: 0x00010996
	public bool IsChestOpen(int chestId)
	{
		return this.chests[chestId].IsUsed();
	}

	// Token: 0x06000396 RID: 918 RVA: 0x000127AC File Offset: 0x000109AC
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

	// Token: 0x06000397 RID: 919 RVA: 0x00012814 File Offset: 0x00010A14
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

	// Token: 0x04000343 RID: 835
	public Dictionary<int, Chest> chests;

	// Token: 0x04000344 RID: 836
	private int chestId;

	// Token: 0x04000345 RID: 837
	public static ChestManager Instance;
}
