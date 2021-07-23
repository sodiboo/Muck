using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu]
public class WoodmanTrades : ScriptableObject
{
    [Serializable]
    public class Trade : IComparable
    {
        public InventoryItem item;

        public int price;

        public int amount;

        public int CompareTo(object obj)
        {
            Trade trade = (Trade)obj;
            if (item.id > trade.item.id)
            {
                return 1;
            }
            if (item.id < trade.item.id)
            {
                return -1;
            }
            return 0;
        }
    }

    public Trade[] trades;

    public List<Trade> GetTrades(int min, int max, ConsistentRandom rand, float priceMultiplier = 1f)
    {
        List<Trade> list = new List<Trade>();
        List<Trade> list2 = new List<Trade>();
        Trade[] array = trades;
        foreach (Trade item in array)
        {
            list2.Add(item);
        }
        int num = rand.Next(min, max);
        for (int j = 0; j < num && j < trades.Length; j++)
        {
            Trade trade = list2[rand.Next(0, list2.Count)];
            Trade trade2 = new Trade();
            trade2.amount = trade.amount;
            trade2.item = trade.item;
            trade2.price = trade.price;
            trade2.price = (int)(priceMultiplier * (float)trade.price);
            list.Add(trade2);
            list2.Remove(trade);
        }
        list.Sort();
        return list;
    }
}
