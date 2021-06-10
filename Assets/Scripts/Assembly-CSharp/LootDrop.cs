using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000084 RID: 132
[CreateAssetMenu]
public class LootDrop : ScriptableObject
{
	// Token: 0x17000021 RID: 33
	// (get) Token: 0x06000380 RID: 896 RVA: 0x00012328 File Offset: 0x00010528
	// (set) Token: 0x06000381 RID: 897 RVA: 0x00012330 File Offset: 0x00010530
	public int id { get; set; }

	// Token: 0x06000382 RID: 898 RVA: 0x0001233C File Offset: 0x0001053C
	public List<InventoryItem> GetLoot()
	{
		List<InventoryItem> list = new List<InventoryItem>();
		foreach (LootDrop.LootItems lootItems in this.loot)
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

	// Token: 0x06000383 RID: 899 RVA: 0x000123B4 File Offset: 0x000105B4
	public List<InventoryItem> GetLoot(ConsistentRandom rand)
	{
		List<InventoryItem> list = new List<InventoryItem>();
		foreach (LootDrop.LootItems lootItems in this.loot)
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

	// Token: 0x0400033B RID: 827
	[Header("Loot Table")]
	public LootDrop.LootItems[] loot;

	// Token: 0x0400033C RID: 828
	public bool dropOne;

	// Token: 0x0200011D RID: 285
	[Serializable]
	public class LootItems
	{
		// Token: 0x04000780 RID: 1920
		public InventoryItem item;

		// Token: 0x04000781 RID: 1921
		public int amountMin;

		// Token: 0x04000782 RID: 1922
		public int amountMax;

		// Token: 0x04000783 RID: 1923
		public float dropChance;
	}
}
