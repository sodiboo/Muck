using System.Collections.Generic;
using UnityEngine;

public class Chest : MonoBehaviour
{
    public InventoryItem[] cells;

    public int chestSize = 21;

    public bool inUse;

    public bool[] locked;

    private Animator animator;

    public int id { get; set; }

    private void Start()
    {
        locked = new bool[chestSize];
        animator = GetComponent<Animator>();
        if (cells == null || cells.Length == 0)
        {
            cells = new InventoryItem[chestSize];
        }
    }

    public void Use(bool b)
    {
        if ((bool)animator)
        {
            animator.SetBool("Use", b);
        }
        inUse = b;
    }

    public bool IsUsed()
    {
        return inUse;
    }

    public virtual void UpdateCraftables()
    {
    }

    public void InitChest(List<InventoryItem> items, ConsistentRandom rand)
    {
        cells = new InventoryItem[chestSize];
        List<int> list = new List<int>();
        for (int i = 0; i < chestSize; i++)
        {
            list.Add(i);
        }
        foreach (InventoryItem item in items)
        {
            int num = rand.Next(0, list.Count);
            list.Remove(num);
            cells[num] = item;
        }
    }
}
