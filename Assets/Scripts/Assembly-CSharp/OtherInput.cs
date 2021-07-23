using System.Collections.Generic;
using UnityEngine;

public class OtherInput : MonoBehaviour
{
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

    private Dictionary<int, bool> chestsOpened;

    public static OtherInput Instance;

    public GameObject pauseUi;

    public GameObject settingsUi;

    public UiSfx UiSfx;

    public RectTransform craftingOverlay;

    public CraftingState craftingState { get; set; }

    public bool paused { get; set; }

    private void Awake()
    {
        Instance = this;
        chestsOpened = new Dictionary<int, bool>();
    }

    public void Unpause()
    {
        if (GameManager.gameSettings.multiplayer == GameSettings.Multiplayer.Off)
        {
            Time.timeScale = 1f;
        }
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
        paused = false;
        pauseUi.SetActive(value: false);
    }

    public void Pause()
    {
        if (GameManager.gameSettings.multiplayer == GameSettings.Multiplayer.Off)
        {
            Time.timeScale = 0f;
        }
        Cursor.visible = true;
        Cursor.lockState = CursorLockMode.None;
        paused = true;
        pauseUi.SetActive(value: true);
    }

    public bool OtherUiActive()
    {
        if (pauseUi.activeInHierarchy || settingsUi.activeInHierarchy)
        {
            return true;
        }
        if (ChatBox.Instance.typing)
        {
            return true;
        }
        if (Map.Instance.active)
        {
            return true;
        }
        if (RespawnTotemUI.Instance.root.activeInHierarchy || TraderUI.Instance.root.activeInHierarchy)
        {
            return true;
        }
        if (InventoryUI.Instance.gameObject.activeInHierarchy && craftingState != 0)
        {
            return true;
        }
        return false;
    }

    private void Update()
    {
        if (GameManager.state == GameManager.GameState.GameOver)
        {
            return;
        }
        if (pauseUi.activeInHierarchy || settingsUi.activeInHierarchy)
        {
            if (Input.GetKeyDown(KeyCode.Escape))
            {
                if (settingsUi.activeInHierarchy)
                {
                    settingsUi.SetActive(value: false);
                    pauseUi.SetActive(value: true);
                }
                else
                {
                    Unpause();
                }
            }
        }
        else
        {
            if (RespawnTotemUI.Instance.root.activeInHierarchy || TraderUI.Instance.root.activeInHierarchy || ChatBox.Instance.typing)
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
                ToggleInventory(CraftingState.Inventory);
            }
            if (Input.GetButton("Cancel") && InventoryUI.Instance.gameObject.activeInHierarchy)
            {
                ToggleInventory(CraftingState.Inventory);
                return;
            }
            if (Input.GetKeyDown(InputManager.interact))
            {
                DetectInteractables.Instance.currentInteractable?.Interact();
            }
            if (Input.GetKeyDown(KeyCode.Escape))
            {
                Pause();
            }
        }
    }

    public void ToggleInventory(CraftingState state)
    {
        craftingState = state;
        InventoryUI.Instance.ToggleInventory();
        lockCamera = InventoryUI.Instance.gameObject.activeInHierarchy;
        if (InventoryUI.Instance.gameObject.activeInHierarchy)
        {
            UiSfx.PlayInventory(open: true);
            Cursor.visible = true;
            Cursor.lockState = CursorLockMode.None;
            crosshair.SetActive(value: false);
            hotbar.SetActive(value: false);
            FindCurrentCraftingState();
            InventoryUI.Instance.CraftingUi = _currentCraftingUiMenu;
            _currentCraftingUiMenu.gameObject.SetActive(value: true);
            _currentCraftingUiMenu.UpdateCraftables();
            CheckStationUnlock();
            CenterInventory();
        }
        else
        {
            UiSfx.PlayInventory(open: false);
            Cursor.visible = false;
            Cursor.lockState = CursorLockMode.Locked;
            crosshair.SetActive(value: true);
            hotbar.SetActive(value: true);
            InventoryUI.Instance.CraftingUi = null;
            _currentCraftingUiMenu.gameObject.SetActive(value: false);
            _currentCraftingUiMenu = null;
            if ((bool)currentChest)
            {
                MonoBehaviour.print("closing chest");
                ClientSend.RequestChest(currentChest.id, use: false);
                state = CraftingState.Inventory;
                currentChest = null;
            }
            ItemInfo.Instance.Fade(0f, 0f);
        }
        switch (state)
        {
        case CraftingState.Chest:
        {
            bool addMap = false;
            if ((bool)Boat.Instance && !chestsOpened.ContainsKey(currentChest.id) && Boat.Instance.status == Boat.BoatStatus.Hidden)
            {
                chestsOpened.Add(currentChest.id, value: true);
                if (currentChest.transform.root.GetComponent<BuildInfo>() == null)
                {
                    addMap = true;
                }
                else
                {
                    Debug.LogError("failed2");
                }
            }
            ((ChestUI)chest).CopyChest(currentChest, addMap);
            break;
        }
        case CraftingState.Furnace:
            ((FurnaceUI)furnace).CopyChest(currentChest);
            break;
        case CraftingState.Cauldron:
            ((CauldronUI)cauldron).CopyChest(currentChest);
            break;
        }
    }

    private void CenterInventory()
    {
        if (!_currentCraftingUiMenu)
        {
            Debug.LogError("no current ui menu");
            return;
        }
        float y = _currentCraftingUiMenu.GetComponent<RectTransform>().sizeDelta.y;
        float num = 400f - y;
        craftingOverlay.offsetMax = new Vector2(0f, 0f - num);
    }

    public bool IsAnyMenuOpen()
    {
        if (InventoryUI.Instance.gameObject.activeInHierarchy)
        {
            return true;
        }
        return false;
    }

    private void CheckStationUnlock()
    {
        int stationId = GetStationId();
        if (stationId != -1)
        {
            UiEvents.Instance.StationUnlock(stationId);
        }
    }

    private int GetStationId()
    {
        switch (craftingState)
        {
        case CraftingState.Workbench:
            return ItemManager.Instance.GetItemByName("Workbench").id;
        case CraftingState.Furnace:
            return ItemManager.Instance.GetItemByName("Furnace").id;
        case CraftingState.Anvil:
            return ItemManager.Instance.GetItemByName("Anvil").id;
        case CraftingState.Fletch:
            return ItemManager.Instance.GetItemByName("Fletching Table").id;
        case CraftingState.Cauldron:
            return ItemManager.Instance.GetItemByName("Cauldron").id;
        default:
            return -1;
        }
    }

    private void FindCurrentCraftingState()
    {
        switch (craftingState)
        {
        case CraftingState.Inventory:
            _currentCraftingUiMenu = handcrafts;
            break;
        case CraftingState.Workbench:
            _currentCraftingUiMenu = workbench;
            break;
        case CraftingState.Furnace:
            _currentCraftingUiMenu = furnace;
            break;
        case CraftingState.Anvil:
            _currentCraftingUiMenu = anvil;
            break;
        case CraftingState.Fletch:
            _currentCraftingUiMenu = fletch;
            break;
        case CraftingState.Cauldron:
            _currentCraftingUiMenu = cauldron;
            break;
        case CraftingState.Chest:
            _currentCraftingUiMenu = chest;
            break;
        }
    }
}
