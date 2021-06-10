
using UnityEngine;

// Token: 0x02000055 RID: 85
public class OtherInput : MonoBehaviour
{
	// Token: 0x060001D7 RID: 471 RVA: 0x0000AC91 File Offset: 0x00008E91
	private void Awake()
	{
		OtherInput.Instance = this;
	}

	// Token: 0x060001D8 RID: 472 RVA: 0x0000AC99 File Offset: 0x00008E99
	public void Unpause()
	{
		Cursor.visible = false;
		Cursor.lockState = CursorLockMode.Locked;
		this.paused = false;
		this.pauseUi.SetActive(false);
	}

	// Token: 0x060001D9 RID: 473 RVA: 0x0000ACBA File Offset: 0x00008EBA
	public void Pause()
	{
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
		this.paused = true;
		this.pauseUi.SetActive(true);
	}

	// Token: 0x1700000E RID: 14
	// (get) Token: 0x060001DA RID: 474 RVA: 0x0000ACDB File Offset: 0x00008EDB
	// (set) Token: 0x060001DB RID: 475 RVA: 0x0000ACE3 File Offset: 0x00008EE3
	public bool paused { get; set; }

	// Token: 0x060001DC RID: 476 RVA: 0x0000ACEC File Offset: 0x00008EEC
	public bool OtherUiActive()
	{
		return this.pauseUi.activeInHierarchy || this.settingsUi.activeInHierarchy || ChatBox.Instance.typing || Map.Instance.active || RespawnTotemUI.Instance.root.activeInHierarchy || (InventoryUI.Instance.gameObject.activeInHierarchy && this.craftingState != OtherInput.CraftingState.Inventory);
	}

	// Token: 0x060001DD RID: 477 RVA: 0x0000AD60 File Offset: 0x00008F60
	private void Update()
	{
		if (this.pauseUi.activeInHierarchy || this.settingsUi.activeInHierarchy)
		{
			if (Input.GetKeyDown(KeyCode.Escape))
			{
				if (this.settingsUi.activeInHierarchy)
				{
					this.settingsUi.SetActive(false);
					this.pauseUi.SetActive(true);
					return;
				}
				this.Unpause();
			}
			return;
		}
		if (RespawnTotemUI.Instance.root.activeInHierarchy)
		{
			return;
		}
		if (ChatBox.Instance.typing)
		{
			return;
		}
		if (Input.GetKeyDown(InputManager.map))
		{
			Map.Instance.ToggleMap();
		}
		if (Map.Instance.active)
		{
			return;
		}
		if (Input.GetKeyDown(InputManager.inventory) && !PlayerStatus.Instance.IsPlayerDead())
		{
			this.ToggleInventory(OtherInput.CraftingState.Inventory);
		}
		if (Input.GetButton("Cancel") && InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			this.ToggleInventory(OtherInput.CraftingState.Inventory);
			return;
		}
		if (Input.GetKeyDown(InputManager.interact))
		{
			Interactable currentInteractable = DetectInteractables.Instance.currentInteractable;
			if (currentInteractable != null)
			{
				currentInteractable.Interact();
			}
		}
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			this.Pause();
		}
	}

	// Token: 0x060001DE RID: 478 RVA: 0x0000AE74 File Offset: 0x00009074
	public void ToggleInventory(OtherInput.CraftingState state)
	{
		this.craftingState = state;
		InventoryUI.Instance.ToggleInventory();
		OtherInput.lockCamera = InventoryUI.Instance.gameObject.activeInHierarchy;
		if (InventoryUI.Instance.gameObject.activeInHierarchy)
		{
			this.UiSfx.PlayInventory(true);
			Cursor.visible = true;
			Cursor.lockState = CursorLockMode.None;
			this.crosshair.SetActive(false);
			this.hotbar.SetActive(false);
			this.FindCurrentCraftingState();
			InventoryUI.Instance.CraftingUi = this._currentCraftingUiMenu;
			this._currentCraftingUiMenu.gameObject.SetActive(true);
			this._currentCraftingUiMenu.UpdateCraftables();
			this.CheckStationUnlock();
			this.CenterInventory();
		}
		else
		{
			this.UiSfx.PlayInventory(false);
			Cursor.visible = false;
			Cursor.lockState = CursorLockMode.Locked;
			this.crosshair.SetActive(true);
			this.hotbar.SetActive(true);
			InventoryUI.Instance.CraftingUi = null;
			this._currentCraftingUiMenu.gameObject.SetActive(false);
			this._currentCraftingUiMenu = null;
			if (this.currentChest)
			{
				MonoBehaviour.print("closing chest");
				ClientSend.RequestChest(this.currentChest.id, false);
				state = OtherInput.CraftingState.Inventory;
				this.currentChest = null;
			}
			ItemInfo.Instance.Fade(0f, 0f);
		}
		if (state == OtherInput.CraftingState.Chest)
		{
			((ChestUI)this.chest).CopyChest(this.currentChest);
			return;
		}
		if (state == OtherInput.CraftingState.Furnace)
		{
			((FurnaceUI)this.furnace).CopyChest(this.currentChest);
			return;
		}
		if (state == OtherInput.CraftingState.Cauldron)
		{
			((CauldronUI)this.cauldron).CopyChest(this.currentChest);
		}
	}

	// Token: 0x060001DF RID: 479 RVA: 0x0000B014 File Offset: 0x00009214
	private void CenterInventory()
	{
		if (!this._currentCraftingUiMenu)
		{
			Debug.LogError("no current ui menu");
			return;
		}
		float y = this._currentCraftingUiMenu.GetComponent<RectTransform>().sizeDelta.y;
		float num = 400f - y;
		this.craftingOverlay.offsetMax = new Vector2(0f, -num);
	}

	// Token: 0x060001E0 RID: 480 RVA: 0x0000B06E File Offset: 0x0000926E
	public bool IsAnyMenuOpen()
	{
		return InventoryUI.Instance.gameObject.activeInHierarchy;
	}

	// Token: 0x060001E1 RID: 481 RVA: 0x0000B084 File Offset: 0x00009284
	private void CheckStationUnlock()
	{
		int stationId = this.GetStationId();
		if (stationId == -1)
		{
			return;
		}
		UiEvents.Instance.StationUnlock(stationId);
	}

	// Token: 0x060001E2 RID: 482 RVA: 0x0000B0A8 File Offset: 0x000092A8
	private int GetStationId()
	{
		switch (this.craftingState)
		{
		case OtherInput.CraftingState.Workbench:
			return ItemManager.Instance.GetItemByName("Workbench").id;
		case OtherInput.CraftingState.Anvil:
			return ItemManager.Instance.GetItemByName("Anvil").id;
		case OtherInput.CraftingState.Cauldron:
			return ItemManager.Instance.GetItemByName("Cauldron").id;
		case OtherInput.CraftingState.Fletch:
			return ItemManager.Instance.GetItemByName("Fletching Table").id;
		case OtherInput.CraftingState.Furnace:
			return ItemManager.Instance.GetItemByName("Furnace").id;
		default:
			return -1;
		}
	}

	// Token: 0x060001E3 RID: 483 RVA: 0x0000B144 File Offset: 0x00009344
	private void FindCurrentCraftingState()
	{
		switch (this.craftingState)
		{
		case OtherInput.CraftingState.Inventory:
			this._currentCraftingUiMenu = this.handcrafts;
			return;
		case OtherInput.CraftingState.Workbench:
			this._currentCraftingUiMenu = this.workbench;
			return;
		case OtherInput.CraftingState.Anvil:
			this._currentCraftingUiMenu = this.anvil;
			return;
		case OtherInput.CraftingState.Cauldron:
			this._currentCraftingUiMenu = this.cauldron;
			return;
		case OtherInput.CraftingState.Fletch:
			this._currentCraftingUiMenu = this.fletch;
			return;
		case OtherInput.CraftingState.Furnace:
			this._currentCraftingUiMenu = this.furnace;
			return;
		case OtherInput.CraftingState.Chest:
			this._currentCraftingUiMenu = this.chest;
			return;
		default:
			return;
		}
	}

	// Token: 0x040001D7 RID: 471
	private OtherInput.CraftingState craftingState;

	// Token: 0x040001D8 RID: 472
	public InventoryExtensions handcrafts;

	// Token: 0x040001D9 RID: 473
	public InventoryExtensions furnace;

	// Token: 0x040001DA RID: 474
	public InventoryExtensions workbench;

	// Token: 0x040001DB RID: 475
	public InventoryExtensions anvil;

	// Token: 0x040001DC RID: 476
	public InventoryExtensions fletch;

	// Token: 0x040001DD RID: 477
	public InventoryExtensions chest;

	// Token: 0x040001DE RID: 478
	public InventoryExtensions cauldron;

	// Token: 0x040001DF RID: 479
	public GameObject hotbar;

	// Token: 0x040001E0 RID: 480
	public GameObject crosshair;

	// Token: 0x040001E1 RID: 481
	public static bool lockCamera;

	// Token: 0x040001E2 RID: 482
	private InventoryExtensions _currentCraftingUiMenu;

	// Token: 0x040001E3 RID: 483
	public Chest currentChest;

	// Token: 0x040001E4 RID: 484
	public static OtherInput Instance;

	// Token: 0x040001E6 RID: 486
	public GameObject pauseUi;

	// Token: 0x040001E7 RID: 487
	public GameObject settingsUi;

	// Token: 0x040001E8 RID: 488
	public UiSfx UiSfx;

	// Token: 0x040001E9 RID: 489
	public RectTransform craftingOverlay;

	// Token: 0x02000110 RID: 272
	public enum CraftingState
	{
		// Token: 0x04000741 RID: 1857
		Inventory,
		// Token: 0x04000742 RID: 1858
		Workbench,
		// Token: 0x04000743 RID: 1859
		Anvil,
		// Token: 0x04000744 RID: 1860
		Cauldron,
		// Token: 0x04000745 RID: 1861
		Fletch,
		// Token: 0x04000746 RID: 1862
		Furnace,
		// Token: 0x04000747 RID: 1863
		Chest
	}
}
