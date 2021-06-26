using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class InventoryCell : MonoBehaviour
{
	public enum CellType
	{
		Inventory = 0,
		Crafting = 1,
		Chest = 2,
	}

	public CellType cellType;
	public TextMeshProUGUI amount;
	public Image itemImage;
	public RawImage slot;
	public InventoryItem currentItem;
	public InventoryItem spawnItem;
	public int cellId;
	public Color idle;
	public Color hover;
	public InventoryItem.ItemTag[] tags;
	public RawImage overlay;
}
