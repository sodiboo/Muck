using UnityEngine;
using System;

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

	public LootItems[] loot;
	public bool dropOne;
}
