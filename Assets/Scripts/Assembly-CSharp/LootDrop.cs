using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class LootDrop : ScriptableObject
{
	public int id { get; set; }

	public List<InventoryItem> GetLoot()
	{
		List<InventoryItem> list = new List<InventoryItem>();
		foreach (LootDrop.LootItems lootItems in this.loot)
		{
			if (Random.Range(0f, 1f) < lootItems.dropChance)
			{
				int amount = Random.Range(lootItems.amountMin, lootItems.amountMax + 1);
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
		foreach (LootDrop.LootItems lootItems in this.loot)
		{
			if (rand.NextDouble() < (double)lootItems.dropChance)
			{
				int amount = Random.Range(lootItems.amountMin, lootItems.amountMax + 1);
				InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
				inventoryItem.Copy(lootItems.item, amount);
				list.Add(inventoryItem);
			}
		}
		return list;
	}

	[Header("Loot Table")]
	public LootDrop.LootItems[] loot;

	public bool dropOne;

	[System.Serializable]
	public class LootItems
	{
		public InventoryItem item;

		public int amountMin;

		public int amountMax;

		public float dropChance;
	}
}
