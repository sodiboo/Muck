using UnityEngine;

public class Hotbar : MonoBehaviour
{
    private InventoryCell[] cells;

    private InventoryCell[] inventoryCells;

    public InventoryUI inventory;

    public InventoryItem currentItem;

    private int oldActive = -1;

    private int currentActive;

    private int max = 6;

    public static Hotbar Instance;

    private float sendDelay = 0.25f;

    private void Start()
    {
        Instance = this;
        inventoryCells = inventory.hotkeysTransform.GetComponentsInChildren<InventoryCell>();
        cells = GetComponentsInChildren<InventoryCell>();
        cells[currentActive].slot.color = cells[currentActive].hover;
        UpdateHotbar();
        Invoke("UpdateHotbar", 1f);
    }

    private void Update()
    {
        for (int i = 1; i < 8; i++)
        {
            if (Input.GetButtonDown("Hotbar" + i))
            {
                currentActive = i - 1;
                UpdateHotbar();
            }
        }
        float y = Input.mouseScrollDelta.y;
        if (y > 0.5f)
        {
            currentActive--;
            if (currentActive < 0)
            {
                currentActive = max;
            }
            UpdateHotbar();
        }
        else if (y < -0.5f)
        {
            currentActive++;
            if (currentActive > max)
            {
                currentActive = 0;
            }
            UpdateHotbar();
        }
    }

    public void UpdateHotbar()
    {
        if (inventoryCells[currentActive].currentItem != currentItem)
        {
            currentItem = inventoryCells[currentActive].currentItem;
            if ((bool)UseInventory.Instance)
            {
                UseInventory.Instance.SetWeapon(currentItem);
            }
            CancelInvoke("SendItemToServer");
            Invoke("SendItemToServer", sendDelay);
        }
        for (int i = 0; i < cells.Length; i++)
        {
            if (i == currentActive)
            {
                cells[i].slot.color = cells[i].hover;
            }
            else
            {
                cells[i].slot.color = cells[i].idle;
            }
        }
        for (int j = 0; j < cells.Length; j++)
        {
            cells[j].itemImage.sprite = inventoryCells[j].itemImage.sprite;
            cells[j].itemImage.color = inventoryCells[j].itemImage.color;
            cells[j].amount.text = inventoryCells[j].amount.text;
        }
    }

    private void SendItemToServer()
    {
        if (currentItem == null)
        {
            ClientSend.WeaponInHand(-1);
            if ((bool)PreviewPlayer.Instance)
            {
                PreviewPlayer.Instance.WeaponInHand(-1);
            }
        }
        else
        {
            ClientSend.WeaponInHand(currentItem.id);
            if ((bool)PreviewPlayer.Instance)
            {
                PreviewPlayer.Instance.WeaponInHand(currentItem.id);
            }
        }
    }

    public void UseItem(int n)
    {
        currentItem.amount -= n;
        if (currentItem.amount <= 0)
        {
            inventoryCells[currentActive].RemoveItem();
        }
        inventoryCells[currentActive].UpdateCell();
        UpdateHotbar();
    }
}
