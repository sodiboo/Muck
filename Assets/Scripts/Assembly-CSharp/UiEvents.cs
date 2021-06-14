using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000152 RID: 338
public class UiEvents : MonoBehaviour
{
	// Token: 0x06000816 RID: 2070 RVA: 0x0000744D File Offset: 0x0000564D
	private void Awake()
	{
		UiEvents.Instance = this;
		this.idsToUnlock = new Queue<int>();
	}

	// Token: 0x06000817 RID: 2071 RVA: 0x00027B50 File Offset: 0x00025D50
	private void Start()
	{
		this.unlockedHard = new bool[ItemManager.Instance.allItems.Count];
		this.unlockedSoft = new bool[ItemManager.Instance.allItems.Count];
		this.alertCleared = new bool[ItemManager.Instance.allItems.Count];
		this.stationsUnlocked = new bool[ItemManager.Instance.allItems.Count];
	}

	// Token: 0x06000818 RID: 2072 RVA: 0x00007460 File Offset: 0x00005660
	public bool IsSoftUnlocked(int id)
	{
		return this.unlockedSoft != null && this.unlockedSoft[id];
	}

	// Token: 0x06000819 RID: 2073 RVA: 0x00007474 File Offset: 0x00005674
	public bool IsHardUnlocked(int id)
	{
		return this.unlockedHard != null && this.unlockedHard[id];
	}

	// Token: 0x0600081A RID: 2074 RVA: 0x00007488 File Offset: 0x00005688
	public bool IsStationUnlocked(int id)
	{
		return this.stationsUnlocked != null && this.stationsUnlocked[id];
	}

	// Token: 0x0600081B RID: 2075 RVA: 0x0000749C File Offset: 0x0000569C
	public void StationUnlock(int id)
	{
		MonoBehaviour.print("unlocked station: " + id);
		this.stationsUnlocked[id] = true;
		this.CheckNewUnlocks(id);
	}

	// Token: 0x0600081C RID: 2076 RVA: 0x000074C3 File Offset: 0x000056C3
	public void AddPowerup(Powerup p)
	{
		GameObject gameObject =Instantiate<GameObject>(this.pickupPrefab, this.pickupParent);
		gameObject.GetComponent<ItemPickedupUI>().SetPowerup(p);
		gameObject.transform.SetSiblingIndex(0);
	}

	// Token: 0x0600081D RID: 2077 RVA: 0x00027BC8 File Offset: 0x00025DC8
	public void AddPickup(InventoryItem item)
	{
		Hotbar.Instance.UpdateHotbar();
		GameObject gameObject =Instantiate<GameObject>(this.pickupPrefab, this.pickupParent);
		gameObject.GetComponent<ItemPickedupUI>().SetItem(item);
		gameObject.transform.SetSiblingIndex(0);
		MonoBehaviour.print("checking");
		if (!this.unlockedHard[item.id])
		{
			MonoBehaviour.print("Unlocking hard");
			this.UnlockItemHard(item.id);
			this.CheckNewUnlocks(item.id);
		}
	}

	// Token: 0x0600081E RID: 2078 RVA: 0x000074ED File Offset: 0x000056ED
	public void PlaceInInventory(InventoryItem item)
	{
		if (!this.unlockedHard[item.id])
		{
			this.UnlockItemHard(item.id);
			this.CheckNewUnlocks(item.id);
		}
	}

	// Token: 0x0600081F RID: 2079 RVA: 0x00027C44 File Offset: 0x00025E44
	private bool CanUnlock(InventoryItem.CraftRequirement[] requirements, bool unlockWithFirstRequirement)
	{
		if (requirements.Length < 1)
		{
			return false;
		}
		if (unlockWithFirstRequirement && this.unlockedHard[requirements[0].item.id])
		{
			return true;
		}
		for (int i = 0; i < requirements.Length; i++)
		{
			if (!this.unlockedHard[requirements[i].item.id])
			{
				return false;
			}
		}
		return true;
	}

	// Token: 0x06000820 RID: 2080 RVA: 0x00007516 File Offset: 0x00005716
	public void CheckProcessedItem(int id)
	{
		if (!this.unlockedHard[id])
		{
			this.UnlockItemHard(id);
			this.CheckNewUnlocks(id);
		}
	}

	// Token: 0x06000821 RID: 2081 RVA: 0x00027C9C File Offset: 0x00025E9C
	public void CheckNewUnlocks(int id)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < this.unlockedHard.Length; i++)
		{
			if (!this.unlockedSoft[i])
			{
				InventoryItem inventoryItem = ItemManager.Instance.allItems[i];
				InventoryItem.CraftRequirement[] requirements = inventoryItem.requirements;
				if ((!(inventoryItem.stationRequirement != null) || this.stationsUnlocked[inventoryItem.stationRequirement.id]) && this.CanUnlock(requirements, inventoryItem.unlockWithFirstRequirementOnly))
				{
					list.Add(i);
				}
			}
		}
		foreach (int id2 in list)
		{
			this.UnlockItemSoft(id2);
		}
		this.Unlock();
	}

	// Token: 0x06000822 RID: 2082 RVA: 0x00007530 File Offset: 0x00005730
	private void UnlockItemHard(int id)
	{
		this.unlockedHard[id] = true;
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}

	// Token: 0x06000823 RID: 2083 RVA: 0x00007550 File Offset: 0x00005750
	private void UnlockItemSoft(int id)
	{
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}

	// Token: 0x06000824 RID: 2084 RVA: 0x00027D68 File Offset: 0x00025F68
	private void Unlock()
	{
		if (this.idsToUnlock.Count < 1)
		{
			return;
		}
		if (base.IsInvoking(nameof(Unlock)))
		{
			return;
		}
		int key = this.idsToUnlock.Dequeue();
		GameObject gameObject =Instantiate<GameObject>(this.unlockPrefab, this.unlockParent);
		gameObject.GetComponent<ItemUnlcokedUI>().SetItem(ItemManager.Instance.allItems[key]);
		gameObject.transform.SetSiblingIndex(0);
		if (this.idsToUnlock.Count > 0)
		{
			base.Invoke(nameof(Unlock), 2f);
		}
	}

	// Token: 0x0400085D RID: 2141
	public GameObject pickupPrefab;

	// Token: 0x0400085E RID: 2142
	public Transform pickupParent;

	// Token: 0x0400085F RID: 2143
	public GameObject unlockPrefab;

	// Token: 0x04000860 RID: 2144
	public Transform unlockParent;

	// Token: 0x04000861 RID: 2145
	private bool[] unlockedHard;

	// Token: 0x04000862 RID: 2146
	private bool[] unlockedSoft;

	// Token: 0x04000863 RID: 2147
	private bool[] stationsUnlocked;

	// Token: 0x04000864 RID: 2148
	public bool[] alertCleared;

	// Token: 0x04000865 RID: 2149
	public static UiEvents Instance;

	// Token: 0x04000866 RID: 2150
	private Queue<int> idsToUnlock;
}
