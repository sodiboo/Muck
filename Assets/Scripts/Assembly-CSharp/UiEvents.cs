
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000FC RID: 252
public class UiEvents : MonoBehaviour
{
	// Token: 0x06000759 RID: 1881 RVA: 0x0002488C File Offset: 0x00022A8C
	private void Awake()
	{
		UiEvents.Instance = this;
		this.idsToUnlock = new Queue<int>();
	}

	// Token: 0x0600075A RID: 1882 RVA: 0x000248A0 File Offset: 0x00022AA0
	private void Start()
	{
		this.unlockedHard = new bool[ItemManager.Instance.allItems.Count];
		this.unlockedSoft = new bool[ItemManager.Instance.allItems.Count];
		this.alertCleared = new bool[ItemManager.Instance.allItems.Count];
		this.stationsUnlocked = new bool[ItemManager.Instance.allItems.Count];
	}

	// Token: 0x0600075B RID: 1883 RVA: 0x00024915 File Offset: 0x00022B15
	public bool IsSoftUnlocked(int id)
	{
		return this.unlockedSoft != null && this.unlockedSoft[id];
	}

	// Token: 0x0600075C RID: 1884 RVA: 0x00024929 File Offset: 0x00022B29
	public bool IsHardUnlocked(int id)
	{
		return this.unlockedHard != null && this.unlockedHard[id];
	}

	// Token: 0x0600075D RID: 1885 RVA: 0x0002493D File Offset: 0x00022B3D
	public bool IsStationUnlocked(int id)
	{
		return this.stationsUnlocked != null && this.stationsUnlocked[id];
	}

	// Token: 0x0600075E RID: 1886 RVA: 0x00024951 File Offset: 0x00022B51
	public void StationUnlock(int id)
	{
		MonoBehaviour.print("unlocked station: " + id);
		this.stationsUnlocked[id] = true;
		this.CheckNewUnlocks(id);
	}

	// Token: 0x0600075F RID: 1887 RVA: 0x00024978 File Offset: 0x00022B78
	public void AddPowerup(Powerup p)
	{
		GameObject gameObject =Instantiate(this.pickupPrefab, this.pickupParent);
		gameObject.GetComponent<ItemPickedupUI>().SetPowerup(p);
		gameObject.transform.SetSiblingIndex(0);
	}

	// Token: 0x06000760 RID: 1888 RVA: 0x000249A4 File Offset: 0x00022BA4
	public void AddPickup(InventoryItem item)
	{
		Hotbar.Instance.UpdateHotbar();
		GameObject gameObject =Instantiate(this.pickupPrefab, this.pickupParent);
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

	// Token: 0x06000761 RID: 1889 RVA: 0x00024A1E File Offset: 0x00022C1E
	public void PlaceInInventory(InventoryItem item)
	{
		if (!this.unlockedHard[item.id])
		{
			this.UnlockItemHard(item.id);
			this.CheckNewUnlocks(item.id);
		}
	}

	// Token: 0x06000762 RID: 1890 RVA: 0x00024A48 File Offset: 0x00022C48
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

	// Token: 0x06000763 RID: 1891 RVA: 0x00024A9F File Offset: 0x00022C9F
	public void CheckProcessedItem(int id)
	{
		if (!this.unlockedHard[id])
		{
			this.UnlockItemHard(id);
			this.CheckNewUnlocks(id);
		}
	}

	// Token: 0x06000764 RID: 1892 RVA: 0x00024ABC File Offset: 0x00022CBC
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

	// Token: 0x06000765 RID: 1893 RVA: 0x00024B88 File Offset: 0x00022D88
	private void UnlockItemHard(int id)
	{
		this.unlockedHard[id] = true;
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}

	// Token: 0x06000766 RID: 1894 RVA: 0x00024BA8 File Offset: 0x00022DA8
	private void UnlockItemSoft(int id)
	{
		this.unlockedSoft[id] = true;
		this.idsToUnlock.Enqueue(id);
	}

	// Token: 0x06000767 RID: 1895 RVA: 0x00024BC0 File Offset: 0x00022DC0
	private void Unlock()
	{
		if (this.idsToUnlock.Count < 1)
		{
			return;
		}
		if (base.IsInvoking("Unlock"))
		{
			return;
		}
		int key = this.idsToUnlock.Dequeue();
		GameObject gameObject =Instantiate(this.unlockPrefab, this.unlockParent);
		gameObject.GetComponent<ItemUnlcokedUI>().SetItem(ItemManager.Instance.allItems[key]);
		gameObject.transform.SetSiblingIndex(0);
		if (this.idsToUnlock.Count > 0)
		{
			base.Invoke("Unlock", 2f);
		}
	}

	// Token: 0x040006EC RID: 1772
	public GameObject pickupPrefab;

	// Token: 0x040006ED RID: 1773
	public Transform pickupParent;

	// Token: 0x040006EE RID: 1774
	public GameObject unlockPrefab;

	// Token: 0x040006EF RID: 1775
	public Transform unlockParent;

	// Token: 0x040006F0 RID: 1776
	private bool[] unlockedHard;

	// Token: 0x040006F1 RID: 1777
	private bool[] unlockedSoft;

	// Token: 0x040006F2 RID: 1778
	private bool[] stationsUnlocked;

	// Token: 0x040006F3 RID: 1779
	public bool[] alertCleared;

	// Token: 0x040006F4 RID: 1780
	public static UiEvents Instance;

	// Token: 0x040006F5 RID: 1781
	private Queue<int> idsToUnlock;
}
