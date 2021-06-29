using UnityEngine;
using UnityEngine.UIElements;

public class CreativeUI : InventoryExtensions
{
    private void Awake() {
        var cells = new InventoryCell[ItemManager.Instance.allItems.Count];
        for (var i = 0; i < ItemManager.Instance.allItems.Count; i++) {
            var cell = Instantiate(cellPrefab).GetComponent<InventoryCell>();
            cell.transform.SetParent(cellsParent, false);
            var item = ScriptableObject.CreateInstance<InventoryItem>();
            item.Copy(ItemManager.Instance.allItems[i], 0);
            cell.currentItem = item;
            cell.UpdateCell();
            cells[i] = cell;
        }
    }
    public override void UpdateCraftables() { }
    public GameObject cellPrefab;
    public RectTransform cellsParent;
    InventoryCell[] cells;
}
