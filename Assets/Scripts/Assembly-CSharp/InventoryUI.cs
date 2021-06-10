
using System.Collections.Generic;
using JetBrains.Annotations;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

// Token: 0x0200007D RID: 125
public class InventoryUI : MonoBehaviour
{
	// Token: 0x06000335 RID: 821 RVA: 0x00010815 File Offset: 0x0000EA15
	private void Awake()
	{
		InventoryUI.Instance = this;
	}

	// Token: 0x06000336 RID: 822 RVA: 0x0001081D File Offset: 0x0000EA1D
	private void Start()
	{
		this.FillCellList();
		this.UpdateMouseSprite();
		this.backDrop.SetActive(false);
	}

	// Token: 0x06000337 RID: 823 RVA: 0x00010838 File Offset: 0x0000EA38
	public bool CanPickup(InventoryItem i)
	{
		if (i == null)
		{
			return false;
		}
		int num = i.amount;
		if (this.IsInventoryFull())
		{
			using (List<InventoryCell>.Enumerator enumerator = this.cells.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					InventoryCell inventoryCell = enumerator.Current;
					if (inventoryCell != null && inventoryCell.currentItem.id == i.id)
					{
						num -= inventoryCell.currentItem.max - inventoryCell.currentItem.amount;
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
		return true;
	}

	// Token: 0x06000338 RID: 824 RVA: 0x000108E4 File Offset: 0x0000EAE4
	public bool IsInventoryFull()
	{
		using (List<InventoryCell>.Enumerator enumerator = this.cells.GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				if (enumerator.Current.currentItem == null)
				{
					return false;
				}
			}
		}
		return true;
	}

	// Token: 0x06000339 RID: 825 RVA: 0x00010944 File Offset: 0x0000EB44
	public void PickupItem(InventoryItem item)
	{
		this.hotbar.UpdateHotbar();
		this.currentMouseItem = item;
		this.UpdateMouseSprite();
	}

	// Token: 0x0600033A RID: 826 RVA: 0x00010944 File Offset: 0x0000EB44
	public void PlaceItem(InventoryItem item)
	{
		this.hotbar.UpdateHotbar();
		this.currentMouseItem = item;
		this.UpdateMouseSprite();
	}

	// Token: 0x0600033B RID: 827 RVA: 0x00010960 File Offset: 0x0000EB60
	private void UpdateMouseSprite()
	{
		if (this.currentMouseItem != null)
		{
			this.mouseItemSprite.sprite = this.currentMouseItem.sprite;
			this.mouseItemSprite.color = Color.white;
			this.mouseItemText.text = this.currentMouseItem.GetAmount();
		}
		else
		{
			this.mouseItemSprite.sprite = null;
			this.mouseItemSprite.color = Color.clear;
			this.mouseItemText.text = "";
		}
		if (this.CraftingUi)
		{
			this.CraftingUi.UpdateCraftables();
		}
	}

	// Token: 0x0600033C RID: 828 RVA: 0x000109FD File Offset: 0x0000EBFD
	private void Update()
	{
		this.mouseItemSprite.transform.position = Input.mousePosition;
	}

	// Token: 0x0600033D RID: 829 RVA: 0x00010A14 File Offset: 0x0000EC14
	public void DropItem([CanBeNull] PointerEventData eventData)
	{
		if (this.currentMouseItem == null)
		{
			return;
		}
		this.hotbar.UpdateHotbar();
		if (eventData == null)
		{
			this.DropItemIntoWorld(this.currentMouseItem);
			this.currentMouseItem = null;
		}
		else
		{
			int num = this.currentMouseItem.amount;
			if (eventData.button == PointerEventData.InputButton.Right)
			{
				num = 1;
			}
			InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem.Copy(this.currentMouseItem, num);
			InventoryItem inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem2.Copy(this.currentMouseItem, this.currentMouseItem.amount - num);
			if (inventoryItem2.amount < 1)
			{
				inventoryItem2 = null;
			}
			this.currentMouseItem = inventoryItem2;
			this.DropItemIntoWorld(inventoryItem);
		}
		this.UpdateMouseSprite();
	}

	// Token: 0x0600033E RID: 830 RVA: 0x00010ABB File Offset: 0x0000ECBB
	public void DropItemIntoWorld(InventoryItem item)
	{
		if (item == null)
		{
			return;
		}
		ClientSend.DropItem(item.id, item.amount);
	}

	// Token: 0x0600033F RID: 831 RVA: 0x00010AD8 File Offset: 0x0000ECD8
	private void FillCellList()
	{
		this.cells = new List<InventoryCell>();
		foreach (InventoryCell item in this.inventoryParent.GetComponentsInChildren<InventoryCell>())
		{
			this.cells.Add(item);
		}
		foreach (InventoryCell item2 in this.hotkeysTransform.GetComponentsInChildren<InventoryCell>())
		{
			this.cells.Add(item2);
		}
	}

	// Token: 0x06000340 RID: 832 RVA: 0x00010B44 File Offset: 0x0000ED44
	public void UpdateAllCells()
	{
		foreach (InventoryCell inventoryCell in this.cells)
		{
			inventoryCell.UpdateCell();
		}
	}

	// Token: 0x06000341 RID: 833 RVA: 0x00010B94 File Offset: 0x0000ED94
	public void ToggleInventory()
	{
		this.backDrop.SetActive(!this.backDrop.activeInHierarchy);
		if (!base.transform.parent.gameObject.activeInHierarchy && this.currentMouseItem != null)
		{
			this.DropItem(null);
		}
	}

	// Token: 0x06000342 RID: 834 RVA: 0x00010BE8 File Offset: 0x0000EDE8
	public int AddItemToInventory(InventoryItem item)
	{
		InventoryItem inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
		inventoryItem.Copy(item, item.amount);
		InventoryCell inventoryCell = null;
		UiSfx.Instance.PlayPickup();
		foreach (InventoryCell inventoryCell2 in this.cells)
		{
			if (inventoryCell2.currentItem == null)
			{
				if (!(inventoryCell != null))
				{
					inventoryCell = inventoryCell2;
				}
			}
			else if (inventoryCell2.currentItem.Compare(inventoryItem) && inventoryCell2.currentItem.stackable)
			{
				if (inventoryCell2.currentItem.amount + inventoryItem.amount <= inventoryCell2.currentItem.max)
				{
					inventoryCell2.currentItem.amount += inventoryItem.amount;
					inventoryCell2.UpdateCell();
					UiEvents.Instance.AddPickup(inventoryItem);
					return 0;
				}
				int num = inventoryCell2.currentItem.max - inventoryCell2.currentItem.amount;
				inventoryCell2.currentItem.amount += num;
				inventoryItem.amount -= num;
				inventoryCell2.UpdateCell();
			}
		}
		if (inventoryCell)
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

	// Token: 0x06000343 RID: 835 RVA: 0x00010D6C File Offset: 0x0000EF6C
	public int GetMoney()
	{
		int num = 0;
		foreach (InventoryCell inventoryCell in this.cells)
		{
			if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.name == "Coin")
			{
				num += inventoryCell.currentItem.amount;
			}
		}
		return num;
	}

	// Token: 0x06000344 RID: 836 RVA: 0x00010DF0 File Offset: 0x0000EFF0
	public void UseMoney(int amount)
	{
		int num = 0;
		InventoryItem itemByName = ItemManager.Instance.GetItemByName("Coin");
		foreach (InventoryCell inventoryCell in this.cells)
		{
			if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(itemByName))
			{
				if (inventoryCell.currentItem.amount > amount)
				{
					int num2 = amount - num;
					inventoryCell.currentItem.amount -= num2;
					inventoryCell.UpdateCell();
					MonoBehaviour.print("taking money");
					break;
				}
				num += inventoryCell.currentItem.amount;
				MonoBehaviour.print("removing money");
				inventoryCell.RemoveItem();
			}
		}
	}

	// Token: 0x06000345 RID: 837 RVA: 0x00010EC8 File Offset: 0x0000F0C8
	public bool IsCraftable(InventoryItem item)
	{
		foreach (InventoryItem.CraftRequirement craftRequirement in item.requirements)
		{
			int num = 0;
			foreach (InventoryCell inventoryCell in this.cells)
			{
				if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(craftRequirement.item))
				{
					num += inventoryCell.currentItem.amount;
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

	// Token: 0x06000346 RID: 838 RVA: 0x00010F80 File Offset: 0x0000F180
	public void CraftItem(InventoryItem item)
	{
		if (!this.IsCraftable(item))
		{
			return;
		}
		if (this.currentMouseItem != null)
		{
			if (!item.Compare(this.currentMouseItem))
			{
				return;
			}
			if (this.currentMouseItem.amount + item.craftAmount > this.currentMouseItem.max)
			{
				return;
			}
		}
		foreach (InventoryItem.CraftRequirement craftRequirement in item.requirements)
		{
			int num = 0;
			foreach (InventoryCell inventoryCell in this.cells)
			{
				if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(craftRequirement.item))
				{
					if (inventoryCell.currentItem.amount > craftRequirement.amount)
					{
						int num2 = craftRequirement.amount - num;
						inventoryCell.currentItem.amount -= num2;
						inventoryCell.UpdateCell();
						break;
					}
					num += inventoryCell.currentItem.amount;
					inventoryCell.RemoveItem();
				}
			}
		}
		this.CraftingUi.UpdateCraftables();
		if (this.currentMouseItem != null)
		{
			this.currentMouseItem.amount += item.craftAmount;
		}
		else
		{
			this.currentMouseItem = ScriptableObject.CreateInstance<InventoryItem>();
			this.currentMouseItem.Copy(item, item.craftAmount);
		}
		UiEvents.Instance.CheckNewUnlocks(item.id);
		this.UpdateMouseSprite();
	}

	// Token: 0x06000347 RID: 839 RVA: 0x0001111C File Offset: 0x0000F31C
	public bool AddArmor(InventoryItem item)
	{
		for (int i = 0; i < this.armorCells.Length; i++)
		{
			if (this.armorCells[i].currentItem == null && item.tag == this.armorCells[i].tags[0])
			{
				this.armorCells[i].currentItem = item;
				this.armorCells[i].UpdateCell();
				return true;
			}
		}
		return false;
	}

	// Token: 0x06000348 RID: 840 RVA: 0x00011186 File Offset: 0x0000F386
	public bool HoldingItem()
	{
		return this.currentMouseItem != null;
	}

	// Token: 0x04000304 RID: 772
	public Transform inventoryParent;

	// Token: 0x04000305 RID: 773
	public Transform hotkeysTransform;

	// Token: 0x04000306 RID: 774
	public Transform armorTransform;

	// Token: 0x04000307 RID: 775
	public Transform leftTransform;

	// Token: 0x04000308 RID: 776
	public InventoryCell[] armorCells;

	// Token: 0x04000309 RID: 777
	public InventoryCell[] hotkeyCells;

	// Token: 0x0400030A RID: 778
	public InventoryCell[] allCells;

	// Token: 0x0400030B RID: 779
	public InventoryCell leftHand;

	// Token: 0x0400030C RID: 780
	public InventoryCell arrows;

	// Token: 0x0400030D RID: 781
	public Hotbar hotbar;

	// Token: 0x0400030E RID: 782
	public List<InventoryCell> cells;

	// Token: 0x0400030F RID: 783
	public InventoryItem currentMouseItem;

	// Token: 0x04000310 RID: 784
	public Image mouseItemSprite;

	// Token: 0x04000311 RID: 785
	public TextMeshProUGUI mouseItemText;

	// Token: 0x04000312 RID: 786
	public static InventoryUI Instance;

	// Token: 0x04000313 RID: 787
	public static readonly float throwForce = 700f;

	// Token: 0x04000314 RID: 788
	public GameObject backDrop;

	// Token: 0x04000315 RID: 789
	public InventoryExtensions CraftingUi;
}
