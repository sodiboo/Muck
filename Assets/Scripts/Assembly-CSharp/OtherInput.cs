using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000073 RID: 115
public class OtherInput : MonoBehaviour
{
	// Token: 0x17000017 RID: 23
	// (get) Token: 0x06000289 RID: 649 RVA: 0x0000E612 File Offset: 0x0000C812
	// (set) Token: 0x0600028A RID: 650 RVA: 0x0000E61A File Offset: 0x0000C81A
	public OtherInput.CraftingState craftingState { get; set; }

	// Token: 0x0600028B RID: 651 RVA: 0x0000E623 File Offset: 0x0000C823
	private void Awake()
	{
		OtherInput.Instance = this;
		this.chestsOpened = new Dictionary<int, bool>();
	}

	// Token: 0x0600028C RID: 652 RVA: 0x0000E636 File Offset: 0x0000C836
	public void Unpause()
	{
		if (GameManager.gameSettings.multiplayer == GameSettings.Multiplayer.Off)
		{
			Time.timeScale = 1f;
		}
		Cursor.visible = false;
		Cursor.lockState = CursorLockMode.Locked;
		this.paused = false;
		this.pauseUi.SetActive(false);
	}

	// Token: 0x0600028D RID: 653 RVA: 0x0000E66D File Offset: 0x0000C86D
	public void Pause()
	{
		if (GameManager.gameSettings.multiplayer == GameSettings.Multiplayer.Off)
		{
			Time.timeScale = 0f;
		}
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.None;
		this.paused = true;
		this.pauseUi.SetActive(true);
	}

	// Token: 0x17000018 RID: 24
	// (get) Token: 0x0600028E RID: 654 RVA: 0x0000E6A4 File Offset: 0x0000C8A4
	// (set) Token: 0x0600028F RID: 655 RVA: 0x0000E6AC File Offset: 0x0000C8AC
	public bool paused { get; set; }

	// Token: 0x06000290 RID: 656 RVA: 0x0000E6B8 File Offset: 0x0000C8B8
	public bool OtherUiActive()
	{
		return this.pauseUi.activeInHierarchy || this.settingsUi.activeInHierarchy || ChatBox.Instance.typing || Map.Instance.active || RespawnTotemUI.Instance.root.activeInHierarchy || (InventoryUI.Instance.gameObject.activeInHierarchy && this.craftingState != OtherInput.CraftingState.Inventory);
	}

	// Token: 0x06000291 RID: 657 RVA: 0x0000E72C File Offset: 0x0000C92C
	private void Update()
	{
		if (GameManager.state == GameManager.GameState.GameOver)
		{
			return;
		}
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

	// Token: 0x06000292 RID: 658 RVA: 0x0000E848 File Offset: 0x0000CA48
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
			bool addMap = false;
			if (Boat.Instance && !this.chestsOpened.ContainsKey(this.currentChest.id) && Boat.Instance.status == Boat.BoatStatus.Hidden)
			{
				this.chestsOpened.Add(this.currentChest.id, true);
				if (this.currentChest.transform.root.GetComponent<BuildInfo>() == null)
				{
					addMap = true;
				}
				else
				{
					Debug.LogError("failed2");
				}
			}
			((ChestUI)this.chest).CopyChest(this.currentChest, addMap);
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

	// Token: 0x06000293 RID: 659 RVA: 0x0000EA60 File Offset: 0x0000CC60
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

	// Token: 0x06000294 RID: 660 RVA: 0x0000EABA File Offset: 0x0000CCBA
	public bool IsAnyMenuOpen()
	{
		return InventoryUI.Instance.gameObject.activeInHierarchy;
	}

	// Token: 0x06000295 RID: 661 RVA: 0x0000EAD0 File Offset: 0x0000CCD0
	private void CheckStationUnlock()
	{
		int stationId = this.GetStationId();
		if (stationId == -1)
		{
			return;
		}
		UiEvents.Instance.StationUnlock(stationId);
	}

	// Token: 0x06000296 RID: 662 RVA: 0x0000EAF4 File Offset: 0x0000CCF4
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

	// Token: 0x06000297 RID: 663 RVA: 0x0000EB90 File Offset: 0x0000CD90
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

	// Token: 0x040002A0 RID: 672
	public InventoryExtensions handcrafts;

	// Token: 0x040002A1 RID: 673
	public InventoryExtensions furnace;

	// Token: 0x040002A2 RID: 674
	public InventoryExtensions workbench;

	// Token: 0x040002A3 RID: 675
	public InventoryExtensions anvil;

	// Token: 0x040002A4 RID: 676
	public InventoryExtensions fletch;

	// Token: 0x040002A5 RID: 677
	public InventoryExtensions chest;

	// Token: 0x040002A6 RID: 678
	public InventoryExtensions cauldron;

	// Token: 0x040002A7 RID: 679
	public GameObject hotbar;

	// Token: 0x040002A8 RID: 680
	public GameObject crosshair;

	// Token: 0x040002A9 RID: 681
	public static bool lockCamera;

	// Token: 0x040002AA RID: 682
	private InventoryExtensions _currentCraftingUiMenu;

	// Token: 0x040002AB RID: 683
	public Chest currentChest;

	// Token: 0x040002AC RID: 684
	private Dictionary<int, bool> chestsOpened;

	// Token: 0x040002AD RID: 685
	public static OtherInput Instance;

	// Token: 0x040002AF RID: 687
	public GameObject pauseUi;

	// Token: 0x040002B0 RID: 688
	public GameObject settingsUi;

	// Token: 0x040002B1 RID: 689
	public UiSfx UiSfx;

	// Token: 0x040002B2 RID: 690
	public RectTransform craftingOverlay;

	// Token: 0x0200014A RID: 330
	public enum CraftingState
	{
		// Token: 0x040008AB RID: 2219
		Inventory,
		// Token: 0x040008AC RID: 2220
		Workbench,
		// Token: 0x040008AD RID: 2221
		Anvil,
		// Token: 0x040008AE RID: 2222
		Cauldron,
		// Token: 0x040008AF RID: 2223
		Fletch,
		// Token: 0x040008B0 RID: 2224
		Furnace,
		// Token: 0x040008B1 RID: 2225
		Chest
	}
}
