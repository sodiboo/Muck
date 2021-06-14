using System;
using System.Collections.Generic;
using JetBrains.Annotations;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

// Token: 0x0200009B RID: 155
public class InventoryUI : MonoBehaviour
{
	// Token: 0x0600037A RID: 890 RVA: 0x00004848 File Offset: 0x00002A48
	private void Awake()
	{
		InventoryUI.Instance = this;
	}

	// Token: 0x0600037B RID: 891 RVA: 0x00004850 File Offset: 0x00002A50
	private void Start()
	{
		this.FillCellList();
		this.UpdateMouseSprite();
		this.backDrop.SetActive(false);
	}

	// Token: 0x0600037C RID: 892 RVA: 0x00014388 File Offset: 0x00012588
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

	// Token: 0x0600037D RID: 893 RVA: 0x00014434 File Offset: 0x00012634
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

	// Token: 0x17000025 RID: 37
	// (get) Token: 0x0600037E RID: 894 RVA: 0x0000486A File Offset: 0x00002A6A
	// (set) Token: 0x0600037F RID: 895 RVA: 0x00004872 File Offset: 0x00002A72
	public bool pickupCooldown { get; set; }

	// Token: 0x06000380 RID: 896 RVA: 0x0000487B File Offset: 0x00002A7B
	public void CooldownPickup()
	{
		this.pickupCooldown = true;
		base.Invoke(nameof(ResetCooldown), (float)(NetStatus.GetPing() * 2) / 1000f);
	}

	// Token: 0x06000381 RID: 897 RVA: 0x0000489D File Offset: 0x00002A9D
	private void ResetCooldown()
	{
		this.pickupCooldown = false;
	}

	// Token: 0x06000382 RID: 898 RVA: 0x00014494 File Offset: 0x00012694
	public void CheckInventoryAlmostFull()
	{
		int num = 0;
		using (List<InventoryCell>.Enumerator enumerator = this.cells.GetEnumerator())
		{
			while (enumerator.MoveNext())
			{
				if (enumerator.Current.currentItem == null)
				{
					num++;
					if (num > 2)
					{
						return;
					}
				}
			}
		}
		if (num == 1)
		{
			this.CooldownPickup();
		}
	}

	// Token: 0x06000383 RID: 899 RVA: 0x000048A6 File Offset: 0x00002AA6
	public void PickupItem(InventoryItem item)
	{
		this.hotbar.UpdateHotbar();
		this.currentMouseItem = item;
		this.UpdateMouseSprite();
	}

	// Token: 0x06000384 RID: 900 RVA: 0x000048A6 File Offset: 0x00002AA6
	public void PlaceItem(InventoryItem item)
	{
		this.hotbar.UpdateHotbar();
		this.currentMouseItem = item;
		this.UpdateMouseSprite();
	}

	// Token: 0x06000385 RID: 901 RVA: 0x00014504 File Offset: 0x00012704
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

	// Token: 0x06000386 RID: 902 RVA: 0x000048C0 File Offset: 0x00002AC0
	private void Update()
	{
		this.mouseItemSprite.transform.position = Input.mousePosition;
	}

	// Token: 0x06000387 RID: 903 RVA: 0x000145A4 File Offset: 0x000127A4
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

	// Token: 0x06000388 RID: 904 RVA: 0x000048D7 File Offset: 0x00002AD7
	public void DropItemIntoWorld(InventoryItem item)
	{
		if (item == null)
		{
			return;
		}
		ClientSend.DropItem(item.id, item.amount);
	}

	// Token: 0x06000389 RID: 905 RVA: 0x0001464C File Offset: 0x0001284C
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

	// Token: 0x0600038A RID: 906 RVA: 0x000146B8 File Offset: 0x000128B8
	public void UpdateAllCells()
	{
		foreach (InventoryCell inventoryCell in this.cells)
		{
			inventoryCell.UpdateCell();
		}
	}

	// Token: 0x0600038B RID: 907 RVA: 0x00014708 File Offset: 0x00012908
	public void ToggleInventory()
	{
		this.backDrop.SetActive(!this.backDrop.activeInHierarchy);
		if (!base.transform.parent.gameObject.activeInHierarchy && this.currentMouseItem != null)
		{
			this.DropItem(null);
		}
	}

	// Token: 0x0600038C RID: 908 RVA: 0x0001475C File Offset: 0x0001295C
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

	// Token: 0x0600038D RID: 909 RVA: 0x000148E0 File Offset: 0x00012AE0
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

	// Token: 0x0600038E RID: 910 RVA: 0x00014964 File Offset: 0x00012B64
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

	// Token: 0x0600038F RID: 911 RVA: 0x00014A3C File Offset: 0x00012C3C
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

	// Token: 0x06000390 RID: 912 RVA: 0x00014AF4 File Offset: 0x00012CF4
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

	// Token: 0x06000391 RID: 913 RVA: 0x00014C90 File Offset: 0x00012E90
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

	// Token: 0x06000392 RID: 914 RVA: 0x000048F4 File Offset: 0x00002AF4
	public bool HoldingItem()
	{
		return this.currentMouseItem != null;
	}

	// Token: 0x0400038E RID: 910
	public Transform inventoryParent;

	// Token: 0x0400038F RID: 911
	public Transform hotkeysTransform;

	// Token: 0x04000390 RID: 912
	public Transform armorTransform;

	// Token: 0x04000391 RID: 913
	public Transform leftTransform;

	// Token: 0x04000392 RID: 914
	public InventoryCell[] armorCells;

	// Token: 0x04000393 RID: 915
	public InventoryCell[] hotkeyCells;

	// Token: 0x04000394 RID: 916
	public InventoryCell[] allCells;

	// Token: 0x04000395 RID: 917
	public InventoryCell leftHand;

	// Token: 0x04000396 RID: 918
	public InventoryCell arrows;

	// Token: 0x04000397 RID: 919
	public Hotbar hotbar;

	// Token: 0x04000398 RID: 920
	public List<InventoryCell> cells;

	// Token: 0x04000399 RID: 921
	public InventoryItem currentMouseItem;

	// Token: 0x0400039A RID: 922
	public Image mouseItemSprite;

	// Token: 0x0400039B RID: 923
	public TextMeshProUGUI mouseItemText;

	// Token: 0x0400039C RID: 924
	public static InventoryUI Instance;

	// Token: 0x0400039E RID: 926
	public static readonly float throwForce = 700f;

	// Token: 0x0400039F RID: 927
	public GameObject backDrop;

	// Token: 0x040003A0 RID: 928
	public InventoryExtensions CraftingUi;
}
