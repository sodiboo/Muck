using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A8 RID: 168
public class ChestManager : MonoBehaviour
{
	// Token: 0x060003DD RID: 989 RVA: 0x00004B7F File Offset: 0x00002D7F
	private void Awake()
	{
		ChestManager.Instance = this;
		this.chests = new Dictionary<int, Chest>();
		this.chestId = (int)IdOffsets.chestIdRange.x;
	}

	// Token: 0x060003DE RID: 990 RVA: 0x00004BA3 File Offset: 0x00002DA3
	public void AddChest(Chest c, int id)
	{
		c.id = id;
		this.chests.Add(id, c);
	}

	// Token: 0x060003DF RID: 991 RVA: 0x0001628C File Offset: 0x0001448C
	public int GetNextId()
	{
		int num = this.chestId;
		this.chestId = num + 1;
		return num;
	}

	// Token: 0x060003E0 RID: 992 RVA: 0x00004BB9 File Offset: 0x00002DB9
	public void UseChest(int chestId, bool inUse)
	{
		this.chests[chestId].Use(inUse);
	}

	// Token: 0x060003E1 RID: 993 RVA: 0x00004BCD File Offset: 0x00002DCD
	public void SendChestUpdate(int chestId, int cellId)
	{
		this.chests[chestId].locked[cellId] = true;
	}

	// Token: 0x060003E2 RID: 994 RVA: 0x000162AC File Offset: 0x000144AC
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

	// Token: 0x060003E3 RID: 995 RVA: 0x00004BE3 File Offset: 0x00002DE3
	public bool IsChestOpen(int chestId)
	{
		return this.chests[chestId].IsUsed();
	}

	// Token: 0x060003E4 RID: 996 RVA: 0x00016318 File Offset: 0x00014518
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

	// Token: 0x060003E5 RID: 997 RVA: 0x00016380 File Offset: 0x00014580
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

	// Token: 0x040003DD RID: 989
	public Dictionary<int, Chest> chests;

	// Token: 0x040003DE RID: 990
	private int chestId;

	// Token: 0x040003DF RID: 991
	public static ChestManager Instance;
}
