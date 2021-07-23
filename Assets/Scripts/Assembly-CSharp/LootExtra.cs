using System;
using System.Collections.Generic;
using UnityEngine;

public class LootExtra : MonoBehaviour
{
    public static void CheckDrop(int fromClient, HitableResource hitable)
    {
        if (hitable.dropTable == null)
        {
            return;
        }
        Vector3 pos = hitable.transform.position;
        Collider componentInChildren = hitable.GetComponentInChildren<Collider>();
        if ((bool)componentInChildren)
        {
            pos = componentInChildren.bounds.center;
        }
        LootDrop dropTable = hitable.dropTable;
        List<InventoryItem> list = dropTable.GetLoot();
        float num = PowerupInventory.Instance.GetLootMultiplier(Server.clients[fromClient].player.powerups);
        if (dropTable.dropOne)
        {
            list = new List<InventoryItem>();
            InventoryItem inventoryItem = UnityEngine.Object.Instantiate(hitable.dropItem);
            inventoryItem.amount = 1;
            num = 1f;
            list.Add(inventoryItem);
        }
        foreach (InventoryItem item in list)
        {
            int nextId = ItemManager.Instance.GetNextId();
            int id = item.id;
            item.amount = (int)((float)item.amount * num);
            if (item.amount > item.max)
            {
                item.amount = item.max;
            }
            pos += Vector3.up * (item.mesh.bounds.extents.y * 2f);
            ItemManager.Instance.DropItemAtPosition(id, item.amount, pos, nextId);
            ServerSend.DropItemAtPosition(id, item.amount, nextId, pos);
        }
    }

    public static void DropMobLoot(Transform dropTransform, LootDrop lootTable, int fromClient, float buffMultiplier)
    {
        Vector3 pos = dropTransform.position;
        Collider component = dropTransform.GetComponent<Collider>();
        if ((bool)component)
        {
            pos = component.bounds.center;
        }
        List<InventoryItem> loot = lootTable.GetLoot();
        float lootMultiplier = PowerupInventory.Instance.GetLootMultiplier(Server.clients[fromClient].player.powerups);
        lootMultiplier *= buffMultiplier;
        foreach (InventoryItem item in loot)
        {
            if (item.rarity == InventoryItem.ItemRarity.Rare)
            {
                string username = Server.clients[fromClient].player.username;
                ServerSend.SendChatMessage(-1, "", "<color=orange>" + username + " received rare drop: <color=red>" + item.name);
            }
            int nextId = ItemManager.Instance.GetNextId();
            int id = item.id;
            item.amount = (int)((float)item.amount * lootMultiplier);
            if (item.amount > item.max)
            {
                item.amount = item.max;
            }
            pos += Vector3.up * (item.mesh.bounds.extents.y * 2f);
            ItemManager.Instance.DropItemAtPosition(id, item.amount, pos, nextId);
            ServerSend.DropItemAtPosition(id, item.amount, nextId, pos);
            if (item.name == "Coin")
            {
                Server.clients[fromClient].player.stats["Gold collected"] += item.amount;
            }
        }
    }

    public static void BossLoot(Transform dropPos, Mob.BossType mobType)
    {
        GameManager.instance.GetPlayersInLobby();
        _ = 2;
        _ = dropPos.position;
        int id = ItemManager.Instance.GetRandomPowerup(0f, 0.8f, 0.2f).id;
        Vector3 position = dropPos.position;
        int nextId = ItemManager.Instance.GetNextId();
        ItemManager.Instance.DropPowerupAtPosition(id, position, nextId);
        ServerSend.DropPowerupAtPosition(id, nextId, dropPos.position);
    }

    private static Vector3 RandomCircle(Vector3 center, float radius, float angle)
    {
        Vector3 vector = center;
        vector.x = center.x + radius * Mathf.Sin(angle * ((float)Math.PI / 180f));
        vector.z = center.z + radius * Mathf.Cos(angle * ((float)Math.PI / 180f));
        if (Physics.Raycast(vector + Vector3.up * 20f, Vector3.down, out var hitInfo, 50f, GameManager.instance.whatIsGround))
        {
            vector = hitInfo.point;
        }
        vector += Vector3.up * 1.5f;
        return vector;
    }
}
