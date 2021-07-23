using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class InventoryCell : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler
{
    public enum CellType
    {
        Inventory,
        Crafting,
        Chest
    }

    public CellType cellType;

    public TextMeshProUGUI amount;

    public Image itemImage;

    public RawImage slot;

    [HideInInspector]
    public InventoryItem currentItem;

    public InventoryItem spawnItem;

    public int cellId;

    public Color idle;

    public Color hover;

    private bool ready = true;

    private float lastClickTime;

    private float doubleClickThreshold = 0.15f;

    public InventoryItem.ItemTag[] tags;

    public RawImage overlay;

    private void Start()
    {
        if ((bool)spawnItem)
        {
            currentItem = ScriptableObject.CreateInstance<InventoryItem>();
            currentItem.Copy(spawnItem, spawnItem.amount);
        }
        UpdateCell();
    }

    public void UpdateCell()
    {
        if (currentItem == null)
        {
            amount.text = "";
            itemImage.sprite = null;
            itemImage.color = Color.clear;
        }
        else
        {
            amount.text = currentItem.GetAmount();
            itemImage.sprite = currentItem.sprite;
            itemImage.color = Color.white;
        }
        SetColor(idle);
    }

    public void ForceAddItem(InventoryItem item, int amount)
    {
        currentItem = Object.Instantiate(item);
        currentItem.amount = amount;
        UpdateCell();
    }

    public InventoryItem SetItem(InventoryItem pointerItem, PointerEventData eventData)
    {
        InventoryItem inventoryItem = currentItem;
        int num = pointerItem.amount;
        if (eventData.button == PointerEventData.InputButton.Right)
        {
            num = 1;
        }
        InventoryItem inventoryItem2;
        InventoryItem inventoryItem3;
        if (inventoryItem == null)
        {
            inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem2.Copy(pointerItem, num);
            if (pointerItem.amount - num < 1)
            {
                inventoryItem3 = null;
            }
            else
            {
                inventoryItem3 = ScriptableObject.CreateInstance<InventoryItem>();
                inventoryItem3.Copy(pointerItem, pointerItem.amount - num);
            }
        }
        else if (pointerItem.Compare(inventoryItem) && pointerItem.stackable)
        {
            if (inventoryItem.amount + num > inventoryItem.max)
            {
                num = inventoryItem.max - inventoryItem.amount;
            }
            inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem2.Copy(currentItem, currentItem.amount + num);
            if (pointerItem.amount - num < 1)
            {
                inventoryItem3 = null;
            }
            else
            {
                inventoryItem3 = ScriptableObject.CreateInstance<InventoryItem>();
                inventoryItem3.Copy(pointerItem, pointerItem.amount - num);
            }
        }
        else
        {
            inventoryItem2 = pointerItem;
            inventoryItem3 = inventoryItem;
        }
        currentItem = inventoryItem2;
        UpdateCell();
        UiEvents.Instance.PlaceInInventory(currentItem);
        if (cellType == CellType.Chest)
        {
            MonoBehaviour.print("sending chest updates, currentchest:  " + OtherInput.Instance.currentChest.id);
            int itemId = -1;
            int num2 = 0;
            if ((bool)currentItem)
            {
                itemId = currentItem.id;
                num2 = currentItem.amount;
            }
            ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, cellId, itemId, num2);
            Invoke("GetReady", (float)(NetStatus.GetPing() * 3) * 0.01f);
        }
        return inventoryItem3;
    }

    private void GetReady()
    {
        ready = true;
    }

    public InventoryItem PickupItem(PointerEventData eventData)
    {
        if (!currentItem)
        {
            return null;
        }
        InventoryItem inventoryItem;
        InventoryItem inventoryItem2;
        if (eventData.button == PointerEventData.InputButton.Right && currentItem.amount > 1)
        {
            int num = currentItem.amount / 2;
            int num2 = currentItem.amount - num;
            inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem.Copy(currentItem, num);
            inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem2.Copy(currentItem, num2);
        }
        else
        {
            inventoryItem = null;
            inventoryItem2 = currentItem;
        }
        currentItem = inventoryItem;
        UpdateCell();
        if (cellType == CellType.Chest)
        {
            int itemId = -1;
            int num3 = 0;
            if ((bool)currentItem)
            {
                itemId = currentItem.id;
                num3 = currentItem.amount;
            }
            float time = 1f;
            Invoke("GetReady", time);
            ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, cellId, itemId, num3);
        }
        return inventoryItem2;
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        if (!ready)
        {
            return;
        }
        ready = false;
        Invoke("GetReady", Time.deltaTime * 2f);
        if (cellType == CellType.Crafting)
        {
            InventoryUI.Instance.CraftItem(currentItem);
            return;
        }
        if (Time.time - lastClickTime < 0.25f && eventData.button == PointerEventData.InputButton.Left && InventoryUI.Instance.HoldingItem())
        {
            DoubleClick();
            return;
        }
        if (Input.GetKey(KeyCode.LeftShift))
        {
            ShiftClick();
            return;
        }
        if (InventoryUI.Instance.HoldingItem())
        {
            if (IsItemCompatibleWithCell(InventoryUI.Instance.currentMouseItem))
            {
                InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
                InventoryUI.Instance.PlaceItem(SetItem(currentMouseItem, eventData));
            }
        }
        else
        {
            InventoryUI.Instance.PickupItem(PickupItem(eventData));
        }
        if (eventData.button == PointerEventData.InputButton.Left)
        {
            lastClickTime = Time.time;
        }
    }

    private bool IsItemCompatibleWithCell(InventoryItem item)
    {
        if (tags.Length == 0)
        {
            return true;
        }
        InventoryItem.ItemTag[] array = tags;
        foreach (InventoryItem.ItemTag itemTag in array)
        {
            if (item.tag == itemTag)
            {
                return true;
            }
        }
        return false;
    }

    public void RemoveItem()
    {
        currentItem = null;
        UpdateCell();
    }

    private void DoubleClick()
    {
        InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
        if (!currentMouseItem.stackable)
        {
            return;
        }
        foreach (InventoryCell cell in InventoryUI.Instance.cells)
        {
            if (!(cell.currentItem == null) && cell.currentItem.Compare(currentMouseItem))
            {
                if (currentMouseItem.amount + cell.currentItem.amount > currentMouseItem.max)
                {
                    int num = currentMouseItem.max - currentMouseItem.amount;
                    currentMouseItem.amount += num;
                    cell.currentItem.amount -= num;
                    cell.UpdateCell();
                    InventoryUI.Instance.PickupItem(currentMouseItem);
                    return;
                }
                currentMouseItem.amount += cell.currentItem.amount;
                cell.RemoveItem();
            }
        }
        InventoryUI.Instance.PickupItem(currentMouseItem);
    }

    private bool ShiftClick()
    {
        if (cellType == CellType.Chest)
        {
            if (!InventoryUI.Instance.CanPickup(currentItem))
            {
                return false;
            }
            InventoryUI.Instance.AddItemToInventory(currentItem);
            RemoveItem();
            int itemId = -1;
            int num = 0;
            if ((bool)currentItem)
            {
                itemId = currentItem.id;
                num = currentItem.amount;
            }
            ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, cellId, itemId, num);
            AchievementManager.Instance.PickupItem(currentItem);
            return true;
        }
        if (cellType == CellType.Inventory)
        {
            _ = OtherInput.Instance.craftingState;
            _ = 6;
            _ = OtherInput.Instance.craftingState;
            _ = 3;
            _ = OtherInput.Instance.craftingState;
            _ = 5;
        }
        return false;
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        SetColor(hover);
        if (!currentItem)
        {
            return;
        }
        if (cellType == CellType.Inventory || cellType == CellType.Chest)
        {
            string text = currentItem.name + "\n<size=50%><i>" + currentItem.description;
            if (currentItem.IsArmour())
            {
                text = text + "\n+" + currentItem.armor + " armor";
                text = text + "\n" + currentItem.armorComponent.setBonus;
            }
            ItemInfo.Instance.SetText(text);
        }
        else if (cellType == CellType.Crafting)
        {
            string text2 = currentItem.name + "<size=60%>";
            InventoryItem.CraftRequirement[] requirements = currentItem.requirements;
            foreach (InventoryItem.CraftRequirement craftRequirement in requirements)
            {
                text2 = text2 + "\n" + craftRequirement.item.name + " - " + craftRequirement.amount;
            }
            ItemInfo.Instance.SetText(text2);
        }
    }

    public void Eat(int amount)
    {
        currentItem.amount -= amount;
        if (currentItem.amount <= 0)
        {
            RemoveItem();
        }
        UpdateCell();
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        SetColor(idle);
        ItemInfo.Instance.Fade(0f);
    }

    public void SetColor(Color c)
    {
    }

    public void AddItemToChest(InventoryItem item)
    {
    }

    public void AddItemToCauldron()
    {
    }

    public void AddItemToFurnace()
    {
    }

    public void SetOverlayAlpha(float f)
    {
        MonoBehaviour.print("overlay set to: " + f);
        overlay.color = new Color(0f, 0f, 0f, f);
    }
}
