using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TradeUi : MonoBehaviour
{
    public new TextMeshProUGUI name;

    public TextMeshProUGUI price;

    public TextMeshProUGUI buyText;

    public RawImage itemIcon;

    public GameObject overlay;

    public GameObject button;

    private WoodmanTrades.Trade trade;

    private bool buy;

    public void SetTrade(WoodmanTrades.Trade t, bool buy)
    {
        name.text = $"{t.item.name} (x{t.amount})";
        price.text = string.Concat(t.price);
        itemIcon.texture = t.item.sprite.texture;
        if (buy)
        {
            if (InventoryUI.Instance.GetMoney() < t.price)
            {
                overlay.SetActive(value: true);
            }
            else
            {
                overlay.SetActive(value: false);
            }
        }
        else
        {
            InventoryItem inventoryItem = Object.Instantiate(t.item);
            inventoryItem.amount = t.amount;
            if (InventoryUI.Instance.HasItem(inventoryItem))
            {
                overlay.SetActive(value: false);
            }
            else
            {
                overlay.SetActive(value: true);
            }
        }
        trade = t;
        this.buy = buy;
        if (buy)
        {
            buyText.text = "Buy";
        }
        else
        {
            buyText.text = "Sell";
        }
    }

    public void BuySell()
    {
        if (buy)
        {
            if (InventoryUI.Instance.GetMoney() < trade.price)
            {
                return;
            }
            InventoryItem inventoryItem = Object.Instantiate(trade.item);
            inventoryItem.amount = trade.amount;
            if (InventoryUI.Instance.CanPickup(inventoryItem))
            {
                InventoryUI.Instance.UseMoney(trade.price);
                InventoryUI.Instance.AddItemToInventory(inventoryItem);
                if (InventoryUI.Instance.GetMoney() < trade.price)
                {
                    overlay.SetActive(value: true);
                }
                else
                {
                    overlay.SetActive(value: false);
                }
            }
            return;
        }
        InventoryItem inventoryItem2 = Object.Instantiate(trade.item);
        inventoryItem2.amount = trade.amount;
        if (InventoryUI.Instance.HasItem(inventoryItem2))
        {
            InventoryUI.Instance.RemoveItem(inventoryItem2);
            InventoryItem inventoryItem3 = Object.Instantiate(ItemManager.Instance.GetItemByName("Coin"));
            inventoryItem3.amount = trade.price;
            InventoryUI.Instance.AddItemToInventory(inventoryItem3);
            if (InventoryUI.Instance.HasItem(inventoryItem2))
            {
                overlay.SetActive(value: false);
            }
            else
            {
                overlay.SetActive(value: true);
            }
        }
    }
}
