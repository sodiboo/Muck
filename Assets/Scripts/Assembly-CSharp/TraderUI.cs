using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class TraderUI : MonoBehaviour
{
    public TextMeshProUGUI title;

    private List<WoodmanTrades.Trade> buy;

    private List<WoodmanTrades.Trade> sell;

    public Transform listParent;

    public GameObject tradePrefab;

    public GameObject root;

    private bool buying = true;

    public static TraderUI Instance;

    private void Awake()
    {
        Instance = this;
    }

    public void SetTrades(List<WoodmanTrades.Trade> buy, List<WoodmanTrades.Trade> sell, WoodmanBehaviour.WoodmanType type)
    {
        if (!root.activeInHierarchy)
        {
            this.buy = buy;
            this.sell = sell;
            title.text = type.ToString() + " Trader";
            OpenBuy();
            Show();
        }
    }

    public void FillTrades()
    {
        for (int num = listParent.childCount - 1; num >= 0; num--)
        {
            Object.Destroy(listParent.GetChild(num).gameObject);
        }
        if (buying)
        {
            foreach (WoodmanTrades.Trade item in buy)
            {
                Object.Instantiate(tradePrefab, listParent).GetComponent<TradeUi>().SetTrade(item, buy: true);
            }
            return;
        }
        foreach (WoodmanTrades.Trade item2 in sell)
        {
            Object.Instantiate(tradePrefab, listParent).GetComponent<TradeUi>().SetTrade(item2, buy: false);
        }
    }

    public void Show()
    {
        OtherInput.Instance.ToggleInventory(OtherInput.CraftingState.Inventory);
        root.SetActive(value: true);
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }

    public void Hide()
    {
        root.SetActive(value: false);
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
        OtherInput.Instance.ToggleInventory(OtherInput.CraftingState.Inventory);
    }

    public void OpenBuy()
    {
        buying = true;
        FillTrades();
    }

    public void OpenSell()
    {
        buying = false;
        FillTrades();
    }
}
