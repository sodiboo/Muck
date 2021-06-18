using System;
using UnityEngine;


public class OtherInput : MonoBehaviour
{



    public OtherInput.CraftingState craftingState { get; set; }


    private void Awake()
    {
        OtherInput.Instance = this;
    }


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




    public bool paused { get; set; }


    public bool OtherUiActive()
    {
        return this.pauseUi.activeInHierarchy || this.settingsUi.activeInHierarchy || ChatBox.Instance.typing || Map.Instance.active || RespawnTotemUI.Instance.root.activeInHierarchy || (InventoryUI.Instance.gameObject.activeInHierarchy && this.craftingState != OtherInput.CraftingState.Inventory);
    }


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
            if (currentCar != null)
            {
                var target = MoveCamera.Instance.transform.parent.gameObject;
                MoveCamera.Instance.transform.SetParent(null);
                MoveCamera.Instance.state = MoveCamera.CameraState.Player;
                PlayerMovement.Instance.GetPlayerCollider().enabled = true;
                PlayerMovement.Instance.GetRb().isKinematic = false;
                Hotbar.Instance.gameObject.SetActive(true);
                currentCar.breaking = true;
                currentCar.throttle = 0f;
                currentCar.steering = 0f;
                currentCar.inUse = false;
                currentCar = null;
                Destroy(target);
            }
            else
            {
                Interactable currentInteractable = DetectInteractables.Instance.currentInteractable;
                if (currentInteractable != null)
                {
                    currentInteractable.Interact();
                }
            }
        }
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            this.Pause();
        }
    }


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


    public bool IsAnyMenuOpen()
    {
        return InventoryUI.Instance.gameObject.activeInHierarchy;
    }


    private void CheckStationUnlock()
    {
        int stationId = this.GetStationId();
        if (stationId == -1)
        {
            return;
        }
        UiEvents.Instance.StationUnlock(stationId);
    }


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

    public Car currentCar;

    public InventoryExtensions handcrafts;


    public InventoryExtensions furnace;


    public InventoryExtensions workbench;


    public InventoryExtensions anvil;


    public InventoryExtensions fletch;


    public InventoryExtensions chest;


    public InventoryExtensions cauldron;


    public GameObject hotbar;


    public GameObject crosshair;


    public static bool lockCamera;


    private InventoryExtensions _currentCraftingUiMenu;


    public Chest currentChest;


    public static OtherInput Instance;


    public GameObject pauseUi;


    public GameObject settingsUi;


    public UiSfx UiSfx;


    public RectTransform craftingOverlay;


    public enum CraftingState
    {

        Inventory,

        Workbench,

        Anvil,

        Cauldron,

        Fletch,

        Furnace,

        Chest
    }
}
