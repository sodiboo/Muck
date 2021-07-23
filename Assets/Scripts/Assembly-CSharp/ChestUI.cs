using UnityEngine;

public class ChestUI : InventoryExtensions
{
    public InventoryCell[] cells;

    private void Awake()
    {
    }

    public void CopyChest(Chest c, bool addMap = false)
    {
        InventoryItem[] array = c.cells;
        if (addMap)
        {
            array = AddMapToCells(array);
        }
        Debug.Log("Checking loot, cells: " + cells.Length);
        for (int i = 0; i < cells.Length; i++)
        {
            if (c.locked[i])
            {
                cells[i].gameObject.SetActive(value: false);
            }
            else
            {
                cells[i].gameObject.SetActive(value: true);
            }
            if (array[i] != null)
            {
                cells[i].currentItem = Object.Instantiate(array[i]);
            }
            else
            {
                cells[i].currentItem = null;
            }
            cells[i].UpdateCell();
        }
    }

    private InventoryItem[] AddMapToCells(InventoryItem[] cells)
    {
        for (int i = 0; i < cells.Length; i++)
        {
            if (cells[i] == null)
            {
                cells[i] = Boat.Instance.mapItem;
                break;
            }
        }
        return cells;
    }

    public override void UpdateCraftables()
    {
    }
}
