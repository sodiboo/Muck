using System;
using System.Collections.Generic;
using UnityEngine;

public class LootExtra : MonoBehaviour
{
	public static void CheckDrop(int fromClient, HitableResource hitable)
	{
		if (GameManager.gameSettings.gameMode == GameSettings.GameMode.Creative) return;
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
			InventoryItem inventoryItem = Instantiate<InventoryItem>(hitable.dropItem);
			inventoryItem.amount = 1;
			num = 1f;
			list.Add(inventoryItem);
		}
		foreach (InventoryItem inventoryItem2 in list)
		{
			int nextId = ItemManager.Instance.GetNextId();
			int id = inventoryItem2.id;
			inventoryItem2.amount = (int)((float)inventoryItem2.amount * num);
			if (inventoryItem2.amount > inventoryItem2.max)
			{
				inventoryItem2.amount = inventoryItem2.max;
			}
			vector += Vector3.up * (inventoryItem2.mesh.bounds.extents.y * 2f);
			ItemManager.Instance.DropItemAtPosition(id, inventoryItem2.amount, vector, nextId);
			ServerSend.DropItemAtPosition(id, inventoryItem2.amount, nextId, vector);
		}
	}

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
			if (inventoryItem.amount > inventoryItem.max)
			{
				inventoryItem.amount = inventoryItem.max;
			}
			vector += Vector3.up * (inventoryItem.mesh.bounds.extents.y * 2f);
			ItemManager.Instance.DropItemAtPosition(id, inventoryItem.amount, vector, nextId);
			ServerSend.DropItemAtPosition(id, inventoryItem.amount, nextId, vector);
		}
	}

	public static void BossLoot(Transform dropPos, Mob.BossType mobType)
	{
		GameManager.instance.GetPlayersInLobby();
		Vector3 position = dropPos.position;
		int id = ItemManager.Instance.GetRandomPowerup(0f, 0.8f, 0.2f).id;
		Vector3 position2 = dropPos.position;
		int nextId = ItemManager.Instance.GetNextId();
		ItemManager.Instance.DropPowerupAtPosition(id, position2, nextId);
		ServerSend.DropPowerupAtPosition(id, nextId, dropPos.position);
	}

	private static Vector3 RandomCircle(Vector3 center, float radius, float angle)
	{
		Vector3 a = center;
		a.x = center.x + radius * Mathf.Sin(angle * 0.017453292f);
		a.z = center.z + radius * Mathf.Cos(angle * 0.017453292f);
		RaycastHit raycastHit;
		if (Physics.Raycast(a + Vector3.up * 20f, Vector3.down, out raycastHit, 50f, GameManager.instance.whatIsGround))
		{
			a = raycastHit.point;
		}
		return a + Vector3.up * 1.5f;
	}
}
