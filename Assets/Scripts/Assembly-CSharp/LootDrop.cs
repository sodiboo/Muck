using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class LootDrop : ScriptableObject
{
    [Serializable]
    public class LootItems
    {
        public InventoryItem item;

        public int amountMin;

        public int amountMax;

        public float dropChance;
    }

    [Header("Loot Table")]
    public LootItems[] loot;

    public bool dropOne;

    public int id { get; set; }

    public List<InventoryItem> GetLoot()
    {
        List<InventoryItem> list = new List<InventoryItem>();
        LootItems[] array = loot;
        foreach (LootItems lootItems in array)
        {
            if (UnityEngine.Random.Range(0f, 1f) < lootItems.dropChance)
            {
                int amount = UnityEngine.Random.Range(lootItems.amountMin, lootItems.amountMax + 1);
                InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
                inventoryItem.Copy(lootItems.item, amount);
                list.Add(inventoryItem);
            }
        }
        return list;
    }

    public List<InventoryItem> GetLoot(ConsistentRandom rand)
    {
        List<InventoryItem> list = new List<InventoryItem>();
        LootItems[] array = loot;
        foreach (LootItems lootItems in array)
        {
            if (rand.NextDouble() < (double)lootItems.dropChance)
            {
                int amount = UnityEngine.Random.Range(lootItems.amountMin, lootItems.amountMax + 1);
                InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
                inventoryItem.Copy(lootItems.item, amount);
                list.Add(inventoryItem);
            }
        }
        return list;
    }
}
