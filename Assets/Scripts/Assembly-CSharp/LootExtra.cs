
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200009D RID: 157
public class LootExtra : MonoBehaviour
{
	// Token: 0x060004AB RID: 1195 RVA: 0x00017834 File Offset: 0x00015A34
	public static void CheckDrop(int fromClient, HitableResource hitable)
	{
		if (hitable.dropTable == null)
		{
			return;
		}
		Vector3 vector = hitable.transform.position;
		Collider componentInChildren = hitable.GetComponentInChildren<Collider>();
		if (componentInChildren)
		{
			vector = componentInChildren.bounds.center;
		}
		LootDrop dropTable = hitable.dropTable;
		List<InventoryItem> list = dropTable.GetLoot();
		float num = PowerupInventory.Instance.GetLootMultiplier(Server.clients[fromClient].player.powerups);
		if (dropTable.dropOne)
		{
			list = new List<InventoryItem>();
			InventoryItem inventoryItem =Instantiate<InventoryItem>(hitable.dropItem);
			inventoryItem.amount = 1;
			num = 1f;
			list.Add(inventoryItem);
		}
		foreach (InventoryItem inventoryItem2 in list)
		{
			int nextId = ItemManager.Instance.GetNextId();
			int id = inventoryItem2.id;
			inventoryItem2.amount = (int)((float)inventoryItem2.amount * num);
			vector += Vector3.up * (inventoryItem2.mesh.bounds.extents.y * 2f);
			ItemManager.Instance.DropItemAtPosition(id, inventoryItem2.amount, vector, nextId);
			ServerSend.DropItemAtPosition(id, inventoryItem2.amount, nextId, vector);
		}
	}

	// Token: 0x060004AC RID: 1196 RVA: 0x0001799C File Offset: 0x00015B9C
	public static void DropMobLoot(Transform dropTransform, LootDrop lootTable, int fromClient, float buffMultiplier)
	{
		Vector3 vector = dropTransform.position;
		Collider component = dropTransform.GetComponent<Collider>();
		if (component)
		{
			vector = component.bounds.center;
		}
		List<InventoryItem> loot = lootTable.GetLoot();
		float num = PowerupInventory.Instance.GetLootMultiplier(Server.clients[fromClient].player.powerups);
		num *= buffMultiplier;
		foreach (InventoryItem inventoryItem in loot)
		{
			if (inventoryItem.rarity == InventoryItem.ItemRarity.Rare)
			{
				string username = Server.clients[fromClient].player.username;
				ServerSend.SendChatMessage(-1, "", "<color=orange>" + username + " received rare drop: <color=red>" + inventoryItem.name);
			}
			int nextId = ItemManager.Instance.GetNextId();
			int id = inventoryItem.id;
			inventoryItem.amount = (int)((float)inventoryItem.amount * num);
			vector += Vector3.up * (inventoryItem.mesh.bounds.extents.y * 2f);
			ItemManager.Instance.DropItemAtPosition(id, inventoryItem.amount, vector, nextId);
			ServerSend.DropItemAtPosition(id, inventoryItem.amount, nextId, vector);
		}
	}
}
