using System.Collections.Generic;
using UnityEngine;

public class ChestManager : MonoBehaviour
{
    public Dictionary<int, Chest> chests;

    private int chestId;

    public static ChestManager Instance;

    private void Awake()
    {
        Instance = this;
        chests = new Dictionary<int, Chest>();
        chestId = (int)IdOffsets.chestIdRange.x;
    }

    public void AddChest(Chest c, int id)
    {
        c.id = id;
        chests.Add(id, c);
    }

    public int GetNextId()
    {
        return chestId++;
    }

    public void UseChest(int chestId, bool inUse)
    {
        chests[chestId].Use(inUse);
    }

    public void SendChestUpdate(int chestId, int cellId)
    {
        chests[chestId].locked[cellId] = true;
    }

    public void UpdateChest(int chestId, int cellId, int itemId, int amount)
    {
        InventoryItem inventoryItem = null;
        if (itemId != -1)
        {
            inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem.Copy(ItemManager.Instance.allItems[itemId], amount);
        }
        chests[chestId].cells[cellId] = inventoryItem;
        chests[chestId].locked[cellId] = false;
        chests[chestId].UpdateCraftables();
    }

    public bool IsChestOpen(int chestId)
    {
        return chests[chestId].IsUsed();
    }

    public void RemoveChest(int chestId)
    {
        Chest chest = chests[chestId];
        chests.Remove(chestId);
        Object.Destroy(chest.transform.parent.gameObject);
        if (OtherInput.Instance.currentChest == chest)
        {
            OtherInput.Instance.ToggleInventory(OtherInput.CraftingState.Inventory);
        }
        if (LocalClient.serverOwner)
        {
            DropChest(chest);
        }
    }

    private void DropChest(Chest chest)
    {
        Vector3 position = chest.transform.position;
        InventoryItem[] cells = chest.cells;
        foreach (InventoryItem inventoryItem in cells)
        {
            if (inventoryItem != null)
            {
                position += Vector3.up * (inventoryItem.mesh.bounds.extents.y * 2f);
                int nextId = ItemManager.Instance.GetNextId();
                ItemManager.Instance.DropItemAtPosition(inventoryItem.id, inventoryItem.amount, position, nextId);
                ServerSend.DropItemAtPosition(inventoryItem.id, inventoryItem.amount, nextId, position);
            }
        }
    }
}
