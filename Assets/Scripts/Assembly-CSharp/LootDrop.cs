using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000AA RID: 170
[CreateAssetMenu]
public class LootDrop : ScriptableObject
{
	// Token: 0x1700002C RID: 44
	// (get) Token: 0x0600046D RID: 1133 RVA: 0x00017158 File Offset: 0x00015358
	// (set) Token: 0x0600046E RID: 1134 RVA: 0x00017160 File Offset: 0x00015360
	public int id { get; set; }

	// Token: 0x0600046F RID: 1135 RVA: 0x0001716C File Offset: 0x0001536C
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

	// Token: 0x06000470 RID: 1136 RVA: 0x000171E4 File Offset: 0x000153E4
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

	// Token: 0x04000438 RID: 1080
	[Header("Loot Table")]
	public LootDrop.LootItems[] loot;

	// Token: 0x04000439 RID: 1081
	public bool dropOne;

	// Token: 0x02000157 RID: 343
	[System.Serializable]
	public class LootItems
	{
		// Token: 0x040008EB RID: 2283
		public InventoryItem item;

		// Token: 0x040008EC RID: 2284
		public int amountMin;

		// Token: 0x040008ED RID: 2285
		public int amountMax;

		// Token: 0x040008EE RID: 2286
		public float dropChance;
	}
}
