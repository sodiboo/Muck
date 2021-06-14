using System;
using UnityEngine;

// Token: 0x02000065 RID: 101
public class OtherInput : MonoBehaviour
{
	// Token: 0x17000011 RID: 17
	// (get) Token: 0x06000202 RID: 514 RVA: 0x000038FD File Offset: 0x00001AFD
	// (set) Token: 0x06000203 RID: 515 RVA: 0x00003905 File Offset: 0x00001B05
	public OtherInput.CraftingState craftingState { get; set; }

	// Token: 0x06000204 RID: 516 RVA: 0x0000390E File Offset: 0x00001B0E
	private void Awake()
	{
		OtherInput.Instance = this;
	}

	// Token: 0x06000205 RID: 517 RVA: 0x00003916 File Offset: 0x00001B16
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

	// Token: 0x06000206 RID: 518 RVA: 0x0000394D File Offset: 0x00001B4D
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

	// Token: 0x17000012 RID: 18
	// (get) Token: 0x06000207 RID: 519 RVA: 0x00003984 File Offset: 0x00001B84
	// (set) Token: 0x06000208 RID: 520 RVA: 0x0000398C File Offset: 0x00001B8C
	public bool paused { get; set; }

	// Token: 0x06000209 RID: 521 RVA: 0x0000F30C File Offset: 0x0000D50C
	public bool OtherUiActive()
	{
		return this.pauseUi.activeInHierarchy || this.settingsUi.activeInHierarchy || ChatBox.Instance.typing || Map.Instance.active || RespawnTotemUI.Instance.root.activeInHierarchy || (InventoryUI.Instance.gameObject.activeInHierarchy && this.craftingState != OtherInput.CraftingState.Inventory);
	}

	// Token: 0x0600020A RID: 522 RVA: 0x0000F380 File Offset: 0x0000D580
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

	// Token: 0x0600020B RID: 523 RVA: 0x0000F494 File Offset: 0x0000D694
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

	// Token: 0x0600020C RID: 524 RVA: 0x0000F634 File Offset: 0x0000D834
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

	// Token: 0x0600020D RID: 525 RVA: 0x00003995 File Offset: 0x00001B95
	public bool IsAnyMenuOpen()
	{
		return InventoryUI.Instance.gameObject.activeInHierarchy;
	}

	// Token: 0x0600020E RID: 526 RVA: 0x0000F690 File Offset: 0x0000D890
	private void CheckStationUnlock()
	{
		int stationId = this.GetStationId();
		if (stationId == -1)
		{
			return;
		}
		UiEvents.Instance.StationUnlock(stationId);
	}

	// Token: 0x0600020F RID: 527 RVA: 0x0000F6B4 File Offset: 0x0000D8B4
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

	// Token: 0x06000210 RID: 528 RVA: 0x0000F750 File Offset: 0x0000D950
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

	// Token: 0x0400021C RID: 540
	public InventoryExtensions handcrafts;

	// Token: 0x0400021D RID: 541
	public InventoryExtensions furnace;

	// Token: 0x0400021E RID: 542
	public InventoryExtensions workbench;

	// Token: 0x0400021F RID: 543
	public InventoryExtensions anvil;

	// Token: 0x04000220 RID: 544
	public InventoryExtensions fletch;

	// Token: 0x04000221 RID: 545
	public InventoryExtensions chest;

	// Token: 0x04000222 RID: 546
	public InventoryExtensions cauldron;

	// Token: 0x04000223 RID: 547
	public GameObject hotbar;

	// Token: 0x04000224 RID: 548
	public GameObject crosshair;

	// Token: 0x04000225 RID: 549
	public static bool lockCamera;

	// Token: 0x04000226 RID: 550
	private InventoryExtensions _currentCraftingUiMenu;

	// Token: 0x04000227 RID: 551
	public Chest currentChest;

	// Token: 0x04000228 RID: 552
	public static OtherInput Instance;

	// Token: 0x0400022A RID: 554
	public GameObject pauseUi;

	// Token: 0x0400022B RID: 555
	public GameObject settingsUi;

	// Token: 0x0400022C RID: 556
	public UiSfx UiSfx;

	// Token: 0x0400022D RID: 557
	public RectTransform craftingOverlay;

	// Token: 0x02000066 RID: 102
	public enum CraftingState
	{
		// Token: 0x0400022F RID: 559
		Inventory,
		// Token: 0x04000230 RID: 560
		Workbench,
		// Token: 0x04000231 RID: 561
		Anvil,
		// Token: 0x04000232 RID: 562
		Cauldron,
		// Token: 0x04000233 RID: 563
		Fletch,
		// Token: 0x04000234 RID: 564
		Furnace,
		// Token: 0x04000235 RID: 565
		Chest
	}
}
