using System.Collections.Generic;
using JetBrains.Annotations;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class InventoryUI : MonoBehaviour
{
    public Transform inventoryParent;

    public Transform hotkeysTransform;

    public Transform armorTransform;

    public Transform leftTransform;

    public InventoryCell[] armorCells;

    public InventoryCell[] hotkeyCells;

    public InventoryCell[] allCells;

    public InventoryCell leftHand;

    public InventoryCell arrows;

    public Hotbar hotbar;

    public List<InventoryCell> cells;

    public InventoryItem currentMouseItem;

    public Image mouseItemSprite;

    public TextMeshProUGUI mouseItemText;

    public static InventoryUI Instance;

    public static readonly float throwForce = 700f;

    public GameObject backDrop;

    public InventoryExtensions CraftingUi;

    public bool pickupCooldown { get; set; }

    private void Awake()
    {
        Instance = this;
    }

    private void Start()
    {
        FillCellList();
        UpdateMouseSprite();
        backDrop.SetActive(value: false);
    }

    public bool CanPickup(InventoryItem i)
    {
        if (i == null)
        {
            return false;
        }
        int num = i.amount;
        if (IsInventoryFull())
        {
            foreach (InventoryCell cell in cells)
            {
                if (cell != null && cell.currentItem.id == i.id)
                {
                    num -= cell.currentItem.max - cell.currentItem.amount;
                    if (num <= 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }
        return true;
    }

    public bool IsInventoryFull()
    {
        foreach (InventoryCell cell in cells)
        {
            if (cell.currentItem == null)
            {
                return false;
            }
        }
        return true;
    }

    public void CooldownPickup()
    {
        pickupCooldown = true;
        Invoke(nameof(ResetCooldown), (float)(NetStatus.GetPing() * 2) / 1000f);
    }

    private void ResetCooldown()
    {
        pickupCooldown = false;
    }

    public void CheckInventoryAlmostFull()
    {
        int num = 0;
        foreach (InventoryCell cell in cells)
        {
            if (cell.currentItem == null)
            {
                num++;
                if (num > 2)
                {
                    return;
                }
            }
        }
        if (num == 1)
        {
            CooldownPickup();
        }
    }

    public void PickupItem(InventoryItem item)
    {
        hotbar.UpdateHotbar();
        currentMouseItem = item;
        UpdateMouseSprite();
    }

    public void PlaceItem(InventoryItem item)
    {
        hotbar.UpdateHotbar();
        currentMouseItem = item;
        UpdateMouseSprite();
        if ((bool)Boat.Instance)
        {
            Boat.Instance.CheckForMap();
        }
    }

    private void UpdateMouseSprite()
    {
        if (currentMouseItem != null)
        {
            mouseItemSprite.sprite = currentMouseItem.sprite;
            mouseItemSprite.color = Color.white;
            mouseItemText.text = currentMouseItem.GetAmount();
        }
        else
        {
            mouseItemSprite.sprite = null;
            mouseItemSprite.color = Color.clear;
            mouseItemText.text = "";
        }
        if ((bool)CraftingUi)
        {
            CraftingUi.UpdateCraftables();
        }
    }

    private void Update()
    {
        mouseItemSprite.transform.position = Input.mousePosition;
    }

    public void DropItem([CanBeNull] PointerEventData eventData)
    {
        if (currentMouseItem == null)
        {
            return;
        }
        hotbar.UpdateHotbar();
        if (eventData == null)
        {
            DropItemIntoWorld(currentMouseItem);
            currentMouseItem = null;
        }
        else
        {
            int num = currentMouseItem.amount;
            if (eventData.button == PointerEventData.InputButton.Right)
            {
                num = 1;
            }
            InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem.Copy(currentMouseItem, num);
            InventoryItem inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
            inventoryItem2.Copy(currentMouseItem, currentMouseItem.amount - num);
            if (inventoryItem2.amount < 1)
            {
                inventoryItem2 = null;
            }
            currentMouseItem = inventoryItem2;
            DropItemIntoWorld(inventoryItem);
        }
        UpdateMouseSprite();
    }

    public void DropItemIntoWorld(InventoryItem item)
    {
        if (!(item == null))
        {
            ClientSend.DropItem(item.id, item.amount);
        }
    }

    private void FillCellList()
    {
        cells = new List<InventoryCell>();
        InventoryCell[] componentsInChildren = inventoryParent.GetComponentsInChildren<InventoryCell>();
        foreach (InventoryCell item in componentsInChildren)
        {
            cells.Add(item);
        }
        componentsInChildren = hotkeysTransform.GetComponentsInChildren<InventoryCell>();
        foreach (InventoryCell item2 in componentsInChildren)
        {
            cells.Add(item2);
        }
    }

    public void UpdateAllCells()
    {
        foreach (InventoryCell cell in cells)
        {
            cell.UpdateCell();
        }
    }

    public void ToggleInventory()
    {
        backDrop.SetActive(!backDrop.activeInHierarchy);
        if (!base.transform.parent.gameObject.activeInHierarchy && currentMouseItem != null)
        {
            DropItem(null);
        }
    }

    public int AddItemToInventory(InventoryItem item)
    {
        InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
        inventoryItem.Copy(item, item.amount);
        InventoryCell inventoryCell = null;
        UiSfx.Instance.PlayPickup();
        if ((bool)AchievementManager.Instance)
        {
            AchievementManager.Instance.PickupItem(item);
        }
        foreach (InventoryCell cell in cells)
        {
            if (cell.currentItem == null)
            {
                if (!(inventoryCell != null))
                {
                    inventoryCell = cell;
                }
            }
            else if (cell.currentItem.Compare(inventoryItem) && cell.currentItem.stackable)
            {
                if (cell.currentItem.amount + inventoryItem.amount <= cell.currentItem.max)
                {
                    cell.currentItem.amount += inventoryItem.amount;
                    cell.UpdateCell();
                    UiEvents.Instance.AddPickup(inventoryItem);
                    return 0;
                }
                int num = cell.currentItem.max - cell.currentItem.amount;
                cell.currentItem.amount += num;
                inventoryItem.amount -= num;
                cell.UpdateCell();
            }
        }
        if ((bool)inventoryCell)
        {
            inventoryCell.currentItem = inventoryItem;
            inventoryCell.UpdateCell();
            MonoBehaviour.print("added to available cell");
            UiEvents.Instance.AddPickup(inventoryItem);
            return 0;
        }
        UiEvents.Instance.AddPickup(inventoryItem);
        return inventoryItem.amount;
    }

    public int GetMoney()
    {
        int num = 0;
        foreach (InventoryCell cell in cells)
        {
            if (!(cell.currentItem == null) && cell.currentItem.name == "Coin")
            {
                num += cell.currentItem.amount;
            }
        }
        return num;
    }

    public void UseMoney(int amount)
    {
        int num = 0;
        InventoryItem itemByName = ItemManager.Instance.GetItemByName("Coin");
        foreach (InventoryCell cell in cells)
        {
            if (!(cell.currentItem == null) && cell.currentItem.Compare(itemByName))
            {
                if (cell.currentItem.amount > amount)
                {
                    int num2 = amount - num;
                    cell.currentItem.amount -= num2;
                    cell.UpdateCell();
                    MonoBehaviour.print("taking money");
                    break;
                }
                num += cell.currentItem.amount;
                MonoBehaviour.print("removing money");
                cell.RemoveItem();
            }
        }
    }

    public bool IsCraftable(InventoryItem item)
    {
        InventoryItem.CraftRequirement[] requirements = item.requirements;
        foreach (InventoryItem.CraftRequirement craftRequirement in requirements)
        {
            int num = 0;
            foreach (InventoryCell cell in cells)
            {
                if (!(cell.currentItem == null) && cell.currentItem.Compare(craftRequirement.item))
                {
                    num += cell.currentItem.amount;
                    if (num >= craftRequirement.amount)
                    {
                        break;
                    }
                }
            }
            if (num < craftRequirement.amount)
            {
                return false;
            }
        }
        return true;
    }

    public void CraftItem(InventoryItem item)
    {
        if (!IsCraftable(item) || (currentMouseItem != null && (!item.Compare(currentMouseItem) || currentMouseItem.amount + item.craftAmount > currentMouseItem.max)))
        {
            return;
        }
        InventoryItem.CraftRequirement[] requirements = item.requirements;
        foreach (InventoryItem.CraftRequirement craftRequirement in requirements)
        {
            int num = 0;
            foreach (InventoryCell cell in cells)
            {
                if (!(cell.currentItem == null) && cell.currentItem.Compare(craftRequirement.item))
                {
                    if (cell.currentItem.amount > craftRequirement.amount)
                    {
                        int num2 = craftRequirement.amount - num;
                        cell.currentItem.amount -= num2;
                        cell.UpdateCell();
                        break;
                    }
                    num += cell.currentItem.amount;
                    cell.RemoveItem();
                }
            }
        }
        CraftingUi.UpdateCraftables();
        if (currentMouseItem != null)
        {
            currentMouseItem.amount += item.craftAmount;
        }
        else
        {
            currentMouseItem = ScriptableObject.CreateInstance<InventoryItem>();
            currentMouseItem.Copy(item, item.craftAmount);
        }
        UiEvents.Instance.CheckNewUnlocks(item.id);
        UpdateMouseSprite();
        AchievementManager.Instance.ItemCrafted(currentMouseItem, item.craftAmount);
    }

    public void RemoveItem(InventoryItem requirement)
    {
        int num = 0;
        foreach (InventoryCell cell in cells)
        {
            if (!(cell.currentItem == null) && cell.currentItem.Compare(requirement))
            {
                if (cell.currentItem.amount > requirement.amount)
                {
                    int num2 = requirement.amount - num;
                    cell.currentItem.amount -= num2;
                    cell.UpdateCell();
                    break;
                }
                num += cell.currentItem.amount;
                cell.RemoveItem();
            }
        }
    }

    public bool CanRepair(InventoryItem[] requirements)
    {
        foreach (InventoryItem requirement in requirements)
        {
            if (!HasItem(requirement))
            {
                return false;
            }
        }
        return true;
    }

    public bool Repair(InventoryItem[] requirements)
    {
        InventoryItem[] array = requirements;
        foreach (InventoryItem requirement in array)
        {
            if (!HasItem(requirement))
            {
                return false;
            }
        }
        array = requirements;
        foreach (InventoryItem inventoryItem in array)
        {
            int num = 0;
            foreach (InventoryCell cell in cells)
            {
                if (!(cell.currentItem == null) && cell.currentItem.Compare(inventoryItem))
                {
                    if (cell.currentItem.amount > inventoryItem.amount)
                    {
                        int num2 = inventoryItem.amount - num;
                        cell.currentItem.amount -= num2;
                        cell.UpdateCell();
                        break;
                    }
                    num += cell.currentItem.amount;
                    cell.RemoveItem();
                }
            }
        }
        return true;
    }

    public bool HasItem(InventoryItem requirement)
    {
        int num = 0;
        foreach (InventoryCell cell in cells)
        {
            if (!(cell.currentItem == null) && cell.currentItem.Compare(requirement))
            {
                num += cell.currentItem.amount;
                if (num >= requirement.amount)
                {
                    break;
                }
            }
        }
        if (num < requirement.amount)
        {
            return false;
        }
        return true;
    }

    public bool AddArmor(InventoryItem item)
    {
        for (int i = 0; i < armorCells.Length; i++)
        {
            if (armorCells[i].currentItem == null && item.tag == armorCells[i].tags[0])
            {
                armorCells[i].currentItem = item;
                armorCells[i].UpdateCell();
                return true;
            }
        }
        return false;
    }

    public bool HoldingItem()
    {
        return currentMouseItem != null;
    }
}
