using System.Collections.Generic;
using UnityEngine;

public class ShipChest : MonoBehaviour
{
    public InventoryItem[] spawnLoot;

    private ConsistentRandom rand;

    private void Start()
    {
        rand = new ConsistentRandom(GameManager.GetSeed());
        Chest componentInChildren = GetComponentInChildren<Chest>();
        List<InventoryItem> list = new List<InventoryItem>();
        InventoryItem[] array = spawnLoot;
        foreach (InventoryItem item in array)
        {
            list.Add(item);
        }
        componentInChildren.InitChest(list, rand);
    }
}
