using UnityEngine.UI;

public class FurnaceUI : InventoryExtensions
{
	public InventoryCell metalCell;
	public InventoryCell fuelCell;
	public InventoryCell resultCell;
	public InventoryItem.ProcessType processType;
	public RawImage processBar;
	public InventoryCell[] synchedCells;
}
