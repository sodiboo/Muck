using UnityEngine;
using System;

public class WoodmanTrades : ScriptableObject
{
	[Serializable]
	public class Trade
	{
		public InventoryItem item;
		public int price;
		public int amount;
	}

	public Trade[] trades;
}
