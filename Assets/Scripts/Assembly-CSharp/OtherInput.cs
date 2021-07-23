using UnityEngine;

public class OtherInput : MonoBehaviour
{
	public enum CraftingState
	{
		Inventory = 0,
		Workbench = 1,
		Anvil = 2,
		Cauldron = 3,
		Fletch = 4,
		Furnace = 5,
		Chest = 6,
	}

	public InventoryExtensions handcrafts;
	public InventoryExtensions furnace;
	public InventoryExtensions workbench;
	public InventoryExtensions anvil;
	public InventoryExtensions fletch;
	public InventoryExtensions chest;
	public InventoryExtensions cauldron;
	public GameObject hotbar;
	public GameObject crosshair;
	public Chest currentChest;
	public GameObject pauseUi;
	public GameObject settingsUi;
	public UiSfx UiSfx;
	public RectTransform craftingOverlay;
}
