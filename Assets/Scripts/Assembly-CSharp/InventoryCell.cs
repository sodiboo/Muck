using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class InventoryCell : MonoBehaviour, IPointerDownHandler, IPointerUpHandler, IPointerClickHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler
{
    private void Start()
    {
        if (this.spawnItem)
        {
            this.currentItem = ScriptableObject.CreateInstance<InventoryItem>();
            this.currentItem.Copy(this.spawnItem, this.spawnItem.amount);
        }
        this.UpdateCell();
    }

    public void UpdateCell()
    {
        if (this.currentItem == null)
        {
            this.amount.text = "";
            this.itemImage.sprite = null;
            this.itemImage.color = Color.clear;
        }
        else
        {
            this.amount.text = this.currentItem.GetAmount();
            this.itemImage.sprite = this.currentItem.sprite;
            this.itemImage.color = Color.white;
            itemImage.preserveAspect = true;
        }
        this.SetColor(this.idle);
    }

    public void ForceAddItem(InventoryItem item, int amount)
    {
        this.currentItem = Instantiate<InventoryItem>(item);
        this.currentItem.amount = amount;
        this.UpdateCell();
    }

    public InventoryItem SetItem(InventoryItem pointerItem, PointerEventData eventData)
    {
        InventoryItem inventoryItem = this.currentItem;
        int num = pointerItem.amount;
        if (eventData.button == PointerEventData.InputButton.Right)
        {
            num = 1;
        }
        InventoryItem inventoryItem2;
        InventoryItem inventoryItem3;
        if (cellType == CellType.Creative)
        {
            if (pointerItem.Compare(inventoryItem)) num = -1;
            var amount = pointerItem.amount - num;
            if (amount == 0) return null;
            var item = ScriptableObject.CreateInstance<InventoryItem>();
            item.Copy(pointerItem, amount);
            return item;
        }
        else if (inventoryItem == null)
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
            inventoryItem2.Copy(this.currentItem, this.currentItem.amount + num);
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
        this.currentItem = inventoryItem2;
        this.UpdateCell();
        UiEvents.Instance.PlaceInInventory(this.currentItem);
        if (this.cellType == InventoryCell.CellType.Chest)
        {
            MonoBehaviour.print("sending chest updates, currentchest:  " + OtherInput.Instance.currentChest.id);
            int itemId = -1;
            int num2 = 0;
            if (this.currentItem)
            {
                itemId = this.currentItem.id;
                num2 = this.currentItem.amount;
            }
            ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num2);
            Invoke(nameof(GetReady), (float)(NetStatus.GetPing() * 3) * 0.01f);
        }
        return inventoryItem3;
    }

    private void GetReady()
    {
        this.ready = true;
    }

    public InventoryItem PickupItem(PointerEventData eventData)
    {
        if (!this.currentItem)
        {
            return null;
        }
        if (cellType == CellType.Creative)
        {
            var item = ScriptableObject.CreateInstance<InventoryItem>();
            var amount = 1;
            if (currentItem.stackable) switch (eventData.button)
                {
                    case PointerEventData.InputButton.Middle: amount = currentItem.max; break;
                    case PointerEventData.InputButton.Right: amount = currentItem.max / 2; break;
                }
            item.Copy(currentItem, amount);
            return item;
        }
        InventoryItem inventoryItem;
        InventoryItem inventoryItem2;
        if (eventData.button == PointerEventData.InputButton.Right && this.currentItem.amount > 1)
        {
            int num = this.currentItem.amount / 2;
            int num2 = this.currentItem.amount - num;
            inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem.Copy(this.currentItem, num);
            inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem2.Copy(this.currentItem, num2);
        }
        else
        {
            inventoryItem = null;
            inventoryItem2 = this.currentItem;
        }
        this.currentItem = inventoryItem;
        this.UpdateCell();
        if (this.cellType == InventoryCell.CellType.Chest)
        {
            int itemId = -1;
            int num3 = 0;
            if (this.currentItem)
            {
                itemId = this.currentItem.id;
                num3 = this.currentItem.amount;
            }
            float time = 1f;
            Invoke(nameof(GetReady), time);
            ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num3);
        }
        return inventoryItem2;
    }

    public void OnPointerDown(PointerEventData eventData)
    {
    }

    public void OnPointerUp(PointerEventData eventData)
    {
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        if (!this.ready)
        {
            return;
        }
        this.ready = false;
        Invoke(nameof(GetReady), Time.deltaTime * 2f);
        if (this.cellType == InventoryCell.CellType.Crafting)
        {
            InventoryUI.Instance.CraftItem(this.currentItem);
            return;
        }
        if (eventData.clickCount == 2 && eventData.button == PointerEventData.InputButton.Left && InventoryUI.Instance.HoldingItem())
        {
            this.DoubleClick();
            return;
        }
        if (Input.GetKey(KeyCode.LeftShift))
        {
            this.ShiftClick();
            return;
        }
        if (InventoryUI.Instance.HoldingItem())
        {
            if (this.IsItemCompatibleWithCell(InventoryUI.Instance.currentMouseItem))
            {
                InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
                InventoryUI.Instance.PlaceItem(this.SetItem(currentMouseItem, eventData));
            }
        }
        else
        {
            InventoryUI.Instance.PickupItem(this.PickupItem(eventData));
        }
    }

    private bool IsItemCompatibleWithCell(InventoryItem item)
    {
        if (this.tags.Length == 0)
        {
            return true;
        }
        foreach (InventoryItem.ItemTag itemTag in this.tags)
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
        if (cellType == CellType.Creative) return;
        this.currentItem = null;
        this.UpdateCell();
    }

    private void DoubleClick()
    {
        if (cellType == CellType.Creative) return;
        InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
        if (!currentMouseItem.stackable)
        {
            return;
        }
        foreach (InventoryCell inventoryCell in InventoryUI.Instance.cells)
        {
            if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(currentMouseItem))
            {
                if (currentMouseItem.amount + inventoryCell.currentItem.amount > currentMouseItem.max)
                {
                    int num = currentMouseItem.max - currentMouseItem.amount;
                    currentMouseItem.amount += num;
                    inventoryCell.currentItem.amount -= num;
                    inventoryCell.UpdateCell();
                    InventoryUI.Instance.PickupItem(currentMouseItem);
                    return;
                }
                currentMouseItem.amount += inventoryCell.currentItem.amount;
                inventoryCell.RemoveItem();
            }
        }
        InventoryUI.Instance.PickupItem(currentMouseItem);
    }

    private bool ShiftClick()
    {
        if (this.cellType == InventoryCell.CellType.Chest)
        {
            if (!InventoryUI.Instance.CanPickup(this.currentItem))
            {
                return false;
            }
            InventoryUI.Instance.AddItemToInventory(this.currentItem);
            this.RemoveItem();
            int itemId = -1;
            int num = 0;
            if (this.currentItem)
            {
                itemId = this.currentItem.id;
                num = this.currentItem.amount;
            }
            ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num);
            return true;
        }
        else if (this.cellType == InventoryCell.CellType.Inventory)
        {
            OtherInput.CraftingState craftingState = OtherInput.Instance.craftingState;
            OtherInput.CraftingState craftingState2 = OtherInput.Instance.craftingState;
            OtherInput.CraftingState craftingState3 = OtherInput.Instance.craftingState;
        }
        else if (cellType == CellType.Creative)
        {
            if (!InventoryUI.Instance.CanPickup(this.currentItem)) return false;
            var item = ScriptableObject.CreateInstance<InventoryItem>();
            item.Copy(currentItem, currentItem.stackable ? currentItem.max : 1);
            InventoryUI.Instance.AddItemToInventory(item);
            return true;
        }
        return false;
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        this.SetColor(this.hover);
        if (this.currentItem)
        {
            if (this.cellType == InventoryCell.CellType.Inventory || this.cellType == InventoryCell.CellType.Chest || cellType == CellType.Creative)
            {
                string text = this.currentItem.name + "\n<size=50%><i>" + this.currentItem.description;
                if (this.currentItem.IsArmour())
                {
                    text = string.Concat(new object[]
                    {
                        text,
                        "\n+",
                        this.currentItem.armor,
                        " armor"
                    });
                    text = text + "\n" + this.currentItem.armorComponent.setBonus;
                }
                ItemInfo.Instance.SetText(text, false);
                return;
            }
            if (this.cellType == InventoryCell.CellType.Crafting)
            {
                string text2 = this.currentItem.name + "<size=60%>";
                foreach (InventoryItem.CraftRequirement craftRequirement in this.currentItem.requirements)
                {
                    text2 = string.Concat(new object[]
                    {
                        text2,
                        "\n",
                        craftRequirement.item.name,
                        " - ",
                        craftRequirement.amount
                    });
                }
                ItemInfo.Instance.SetText(text2, false);
            }
        }
    }

    public void Eat(int amount)
    {
        this.currentItem.amount -= amount;
        if (this.currentItem.amount <= 0)
        {
            this.RemoveItem();
        }
        this.UpdateCell();
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        this.SetColor(this.idle);
        ItemInfo.Instance.Fade(0f, 0.2f);
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
        this.overlay.color = new Color(0f, 0f, 0f, f);
    }

    public InventoryCell.CellType cellType;

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

    private float doubleClickThreshold = 0.15f;

    public InventoryItem.ItemTag[] tags;

    public RawImage overlay;

    public enum CellType
    {
        Inventory,
        Crafting,
        Chest,
        Creative,
    }
}
