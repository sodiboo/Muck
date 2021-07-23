using System.Collections.Generic;
using UnityEngine;

public class StartChest : MonoBehaviour
{
    public LootDrop loot;

    private ConsistentRandom rand;

    private void Start()
    {
        rand = new ConsistentRandom(GameManager.GetSeed());
        Chest componentInChildren = GetComponentInChildren<Chest>();
        List<InventoryItem> list = new List<InventoryItem>();
        foreach (InventoryItem item in loot.GetLoot(rand))
        {
            list.Add(item);
        }
        componentInChildren.InitChest(list, rand);
    }
}
