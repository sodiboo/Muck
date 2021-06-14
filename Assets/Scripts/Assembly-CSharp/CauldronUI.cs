using UnityEngine.UI;

public class CauldronUI : InventoryExtensions
{
	public InventoryCell[] ingredientCells;
	public InventoryCell fuelCell;
	public InventoryCell resultCell;
	public InventoryItem.ProcessType processType;
	public InventoryItem[] processableFood;
	public RawImage processBar;
	public InventoryCell[] synchedCells;
}
