using System;
using System.Collections.Generic;
using UnityEngine;


public class UiEvents : MonoBehaviour
{

	private void Awake()
	{
		UiEvents.Instance = this;
		this.idsToUnlock = new Queue<int>();
	}


	private void Start()
	{
		this.unlockedHard = new bool[ItemManager.Instance.allItems.Count];
		this.unlockedSoft = new bool[ItemManager.Instance.allItems.Count];
		this.alertCleared = new bool[ItemManager.Instance.allItems.Count];
		this.stationsUnlocked = new bool[ItemManager.Instance.allItems.Count];
	}


	public bool IsSoftUnlocked(int id)
	{
		return this.unlockedSoft != null && this.unlockedSoft[id];
	}


	public bool IsHardUnlocked(int id)
	{
		return this.unlockedHard != null && this.unlockedHard[id];
	}


	public bool IsStationUnlocked(int id)
	{
		return this.stationsUnlocked != null && this.stationsUnlocked[id];
	}


	public void StationUnlock(int id)
	{
		MonoBehaviour.print("unlocked station: " + id);
		this.stationsUnlocked[id] = true;
		this.CheckNewUnlocks(id);
	}


	public void AddPowerup(Powerup p)
	{
		GameObject gameObject =Instantiate<GameObject>(this.pickupPrefab, this.pickupParent);
		gameObject.GetComponent<ItemPickedupUI>().SetPowerup(p);
		gameObject.transform.SetSiblingIndex(0);
	}


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


	public void PlaceInInventory(InventoryItem item)
	{
		if (!this.unlockedHard[item.id])
		{
			this.UnlockItemHard(item.id);
			this.CheckNewUnlocks(item.id);
		}
	}


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


	public void CheckProcessedItem(int id)
	{
		if (!this.unlockedHard[id])
		{
			this.UnlockItemHard(id);
			this.CheckNewUnlocks(id);
		}
	}


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


	private void UnlockItemHard(int id)
	{
		this.unlockedHard[id] = true;
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}


	private void UnlockItemSoft(int id)
	{
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}


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
}
