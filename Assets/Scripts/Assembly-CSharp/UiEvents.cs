using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200012D RID: 301
public class UiEvents : MonoBehaviour
{
	// Token: 0x060008A0 RID: 2208 RVA: 0x0002B1AD File Offset: 0x000293AD
	private void Awake()
	{
		UiEvents.Instance = this;
		this.idsToUnlock = new Queue<int>();
	}

	// Token: 0x060008A1 RID: 2209 RVA: 0x0002B1C0 File Offset: 0x000293C0
	private void Start()
	{
		this.unlockedHard = new bool[ItemManager.Instance.allItems.Count];
		this.unlockedSoft = new bool[ItemManager.Instance.allItems.Count];
		this.alertCleared = new bool[ItemManager.Instance.allItems.Count];
		this.stationsUnlocked = new bool[ItemManager.Instance.allItems.Count];
	}

	// Token: 0x060008A2 RID: 2210 RVA: 0x0002B235 File Offset: 0x00029435
	public bool IsSoftUnlocked(int id)
	{
		return this.unlockedSoft != null && this.unlockedSoft[id];
	}

	// Token: 0x060008A3 RID: 2211 RVA: 0x0002B249 File Offset: 0x00029449
	public bool IsHardUnlocked(int id)
	{
		return this.unlockedHard != null && this.unlockedHard[id];
	}

	// Token: 0x060008A4 RID: 2212 RVA: 0x0002B25D File Offset: 0x0002945D
	public bool IsStationUnlocked(int id)
	{
		return this.stationsUnlocked != null && this.stationsUnlocked[id];
	}

	// Token: 0x060008A5 RID: 2213 RVA: 0x0002B271 File Offset: 0x00029471
	public void StationUnlock(int id)
	{
		MonoBehaviour.print("unlocked station: " + id);
		this.stationsUnlocked[id] = true;
		this.CheckNewUnlocks(id);
	}

	// Token: 0x060008A6 RID: 2214 RVA: 0x0002B298 File Offset: 0x00029498
	public void AddPowerup(Powerup p)
	{
		GameObject gameObject = Instantiate<GameObject>(this.pickupPrefab, this.pickupParent);
		gameObject.GetComponent<ItemPickedupUI>().SetPowerup(p);
		gameObject.transform.SetSiblingIndex(0);
	}

	// Token: 0x060008A7 RID: 2215 RVA: 0x0002B2C4 File Offset: 0x000294C4
	public void AddPickup(InventoryItem item)
	{
		Hotbar.Instance.UpdateHotbar();
		GameObject gameObject = Instantiate<GameObject>(this.pickupPrefab, this.pickupParent);
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

	// Token: 0x060008A8 RID: 2216 RVA: 0x0002B33E File Offset: 0x0002953E
	public void PlaceInInventory(InventoryItem item)
	{
		if (!this.unlockedHard[item.id])
		{
			this.UnlockItemHard(item.id);
			this.CheckNewUnlocks(item.id);
		}
	}

	// Token: 0x060008A9 RID: 2217 RVA: 0x0002B368 File Offset: 0x00029568
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

	// Token: 0x060008AA RID: 2218 RVA: 0x0002B3BF File Offset: 0x000295BF
	public void CheckProcessedItem(int id)
	{
		if (!this.unlockedHard[id])
		{
			this.UnlockItemHard(id);
			this.CheckNewUnlocks(id);
		}
	}

	// Token: 0x060008AB RID: 2219 RVA: 0x0002B3DC File Offset: 0x000295DC
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

	// Token: 0x060008AC RID: 2220 RVA: 0x0002B4A8 File Offset: 0x000296A8
	private void UnlockItemHard(int id)
	{
		this.unlockedHard[id] = true;
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}

	// Token: 0x060008AD RID: 2221 RVA: 0x0002B4C8 File Offset: 0x000296C8
	private void UnlockItemSoft(int id)
	{
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}

	// Token: 0x060008AE RID: 2222 RVA: 0x0002B4E0 File Offset: 0x000296E0
	private void Unlock()
	{
		if (this.idsToUnlock.Count < 1)
		{
			return;
		}
		if (IsInvoking(nameof(Unlock)))
		{
			return;
		}
		int key = this.idsToUnlock.Dequeue();
		GameObject gameObject = Instantiate<GameObject>(this.unlockPrefab, this.unlockParent);
		gameObject.GetComponent<ItemUnlcokedUI>().SetItem(ItemManager.Instance.allItems[key]);
		gameObject.transform.SetSiblingIndex(0);
		if (this.idsToUnlock.Count > 0)
		{
			Invoke(nameof(Unlock), 2f);
		}
	}

	// Token: 0x04000834 RID: 2100
	public GameObject pickupPrefab;

	// Token: 0x04000835 RID: 2101
	public Transform pickupParent;

	// Token: 0x04000836 RID: 2102
	public GameObject unlockPrefab;

	// Token: 0x04000837 RID: 2103
	public Transform unlockParent;

	// Token: 0x04000838 RID: 2104
	private bool[] unlockedHard;

	// Token: 0x04000839 RID: 2105
	private bool[] unlockedSoft;

	// Token: 0x0400083A RID: 2106
	private bool[] stationsUnlocked;

	// Token: 0x0400083B RID: 2107
	public bool[] alertCleared;

	// Token: 0x0400083C RID: 2108
	public static UiEvents Instance;

	// Token: 0x0400083D RID: 2109
	private Queue<int> idsToUnlock;
}
