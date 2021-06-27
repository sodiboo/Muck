using System;
using System.Collections.Generic;
using UnityEngine;

public class ChestManager : MonoBehaviour
{
	private void Awake()
	{
		ChestManager.Instance = this;
		this.chests = new Dictionary<int, Chest>();
		this.chestId = (int)IdOffsets.chestIdRange.x;
	}

	public void AddChest(Chest c, int id)
	{
		c.id = id;
		this.chests.Add(id, c);
	}

	public int GetNextId()
	{
		int num = this.chestId;
		this.chestId = num + 1;
		return num;
	}

	public void UseChest(int chestId, bool inUse)
	{
		this.chests[chestId].Use(inUse);
	}

	public void SendChestUpdate(int chestId, int cellId)
	{
		this.chests[chestId].locked[cellId] = true;
	}

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

	public bool IsChestOpen(int chestId)
	{
		return this.chests[chestId].IsUsed();
	}

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

	public Dictionary<int, Chest> chests;

	private int chestId;

	public static ChestManager Instance;
}
