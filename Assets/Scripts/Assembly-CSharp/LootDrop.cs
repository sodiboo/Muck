using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A3 RID: 163
[CreateAssetMenu]
public class LootDrop : ScriptableObject
{
	// Token: 0x17000026 RID: 38
	// (get) Token: 0x060003CC RID: 972 RVA: 0x00004AED File Offset: 0x00002CED
	// (set) Token: 0x060003CD RID: 973 RVA: 0x00004AF5 File Offset: 0x00002CF5
	public int id { get; set; }

	// Token: 0x060003CE RID: 974 RVA: 0x00015F78 File Offset: 0x00014178
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

	// Token: 0x060003CF RID: 975 RVA: 0x00015FF0 File Offset: 0x000141F0
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

	// Token: 0x040003CB RID: 971
	[Header("Loot Table")]
	public LootDrop.LootItems[] loot;

	// Token: 0x040003CC RID: 972
	public bool dropOne;

	// Token: 0x020000A4 RID: 164
	[System.Serializable]
	public class LootItems
	{
		// Token: 0x040003CE RID: 974
		public InventoryItem item;

		// Token: 0x040003CF RID: 975
		public int amountMin;

		// Token: 0x040003D0 RID: 976
		public int amountMax;

		// Token: 0x040003D1 RID: 977
		public float dropChance;
	}
}
