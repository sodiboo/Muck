using System.Collections.Generic;
using UnityEngine;

public class UiEvents : MonoBehaviour
{
    public GameObject pickupPrefab;

    public Transform pickupParent;

    public GameObject unlockPrefab;

    public Transform unlockParent;

    private bool[] unlockedHard;

    private bool[] unlockedSoft;

    private bool[] stationsUnlocked;

    public bool[] alertCleared;

    public static UiEvents Instance;

    private Queue<int> idsToUnlock;

    private void Awake()
    {
        Instance = this;
        idsToUnlock = new Queue<int>();
    }

    private void Start()
    {
        unlockedHard = new bool[ItemManager.Instance.allItems.Count];
        unlockedSoft = new bool[ItemManager.Instance.allItems.Count];
        alertCleared = new bool[ItemManager.Instance.allItems.Count];
        stationsUnlocked = new bool[ItemManager.Instance.allItems.Count];
    }

    public bool IsSoftUnlocked(int id)
    {
        if (unlockedSoft == null)
        {
            return false;
        }
        return unlockedSoft[id];
    }

    public bool IsHardUnlocked(int id)
    {
        if (unlockedHard == null)
        {
            return false;
        }
        return unlockedHard[id];
    }

    public bool IsStationUnlocked(int id)
    {
        if (stationsUnlocked == null)
        {
            return false;
        }
        return stationsUnlocked[id];
    }

    public void StationUnlock(int id)
    {
        MonoBehaviour.print("unlocked station: " + id);
        stationsUnlocked[id] = true;
        CheckNewUnlocks(id);
    }

    public void AddPowerup(Powerup p)
    {
        GameObject obj = Object.Instantiate(pickupPrefab, pickupParent);
        obj.GetComponent<ItemPickedupUI>().SetPowerup(p);
        obj.transform.SetSiblingIndex(0);
    }

    public void AddPickup(InventoryItem item)
    {
        Hotbar.Instance.UpdateHotbar();
        GameObject obj = Object.Instantiate(pickupPrefab, pickupParent);
        obj.GetComponent<ItemPickedupUI>().SetItem(item);
        obj.transform.SetSiblingIndex(0);
        MonoBehaviour.print("checking");
        if (!unlockedHard[item.id])
        {
            MonoBehaviour.print("Unlocking hard");
            UnlockItemHard(item.id);
            CheckNewUnlocks(item.id);
        }
    }

    public void PlaceInInventory(InventoryItem item)
    {
        if (!unlockedHard[item.id])
        {
            UnlockItemHard(item.id);
            CheckNewUnlocks(item.id);
        }
    }

    private bool CanUnlock(InventoryItem.CraftRequirement[] requirements, bool unlockWithFirstRequirement)
    {
        if (requirements.Length < 1)
        {
            return false;
        }
        if (unlockWithFirstRequirement && unlockedHard[requirements[0].item.id])
        {
            return true;
        }
        for (int i = 0; i < requirements.Length; i++)
        {
            if (!unlockedHard[requirements[i].item.id])
            {
                return false;
            }
        }
        return true;
    }

    public void CheckProcessedItem(int id)
    {
        if (!unlockedHard[id])
        {
            UnlockItemHard(id);
            CheckNewUnlocks(id);
        }
    }

    public void CheckNewUnlocks(int id)
    {
        List<int> list = new List<int>();
        for (int i = 0; i < unlockedHard.Length; i++)
        {
            if (!unlockedSoft[i])
            {
                InventoryItem inventoryItem = ItemManager.Instance.allItems[i];
                InventoryItem.CraftRequirement[] requirements = inventoryItem.requirements;
                if ((!(inventoryItem.stationRequirement != null) || stationsUnlocked[inventoryItem.stationRequirement.id]) && CanUnlock(requirements, inventoryItem.unlockWithFirstRequirementOnly))
                {
                    list.Add(i);
                }
            }
        }
        foreach (int item in list)
        {
            UnlockItemSoft(item);
        }
        Unlock();
    }

    private void UnlockItemHard(int id)
    {
        unlockedHard[id] = true;
        unlockedSoft[id] = true;
        idsToUnlock.Enqueue(id);
    }

    private void UnlockItemSoft(int id)
    {
        unlockedSoft[id] = true;
        idsToUnlock.Enqueue(id);
    }

    private void Unlock()
    {
        if (idsToUnlock.Count >= 1 && !IsInvoking("Unlock"))
        {
            int key = idsToUnlock.Dequeue();
            GameObject obj = Object.Instantiate(unlockPrefab, unlockParent);
            obj.GetComponent<ItemUnlcokedUI>().SetItem(ItemManager.Instance.allItems[key]);
            obj.transform.SetSiblingIndex(0);
            if (idsToUnlock.Count > 0)
            {
                Invoke("Unlock", 2f);
            }
        }
    }
}
