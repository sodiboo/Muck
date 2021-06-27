using System;
using System.Collections.Generic;
using JetBrains.Annotations;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

// Token: 0x020000A3 RID: 163
public class InventoryUI : MonoBehaviour
{
	// Token: 0x06000418 RID: 1048 RVA: 0x000150D5 File Offset: 0x000132D5
	private void Awake()
	{
		InventoryUI.Instance = this;
	}

	// Token: 0x06000419 RID: 1049 RVA: 0x000150DD File Offset: 0x000132DD
	private void Start()
	{
		this.FillCellList();
		this.UpdateMouseSprite();
		this.backDrop.SetActive(false);
	}

	// Token: 0x0600041A RID: 1050 RVA: 0x000150F8 File Offset: 0x000132F8
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

	// Token: 0x0600041B RID: 1051 RVA: 0x000151A4 File Offset: 0x000133A4
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

	// Token: 0x1700002B RID: 43
	// (get) Token: 0x0600041C RID: 1052 RVA: 0x00015204 File Offset: 0x00013404
	// (set) Token: 0x0600041D RID: 1053 RVA: 0x0001520C File Offset: 0x0001340C
	public bool pickupCooldown { get; set; }

	// Token: 0x0600041E RID: 1054 RVA: 0x00015215 File Offset: 0x00013415
	public void CooldownPickup()
	{
		this.pickupCooldown = true;
		Invoke(nameof(ResetCooldown), (float)(NetStatus.GetPing() * 2) / 1000f);
	}

	// Token: 0x0600041F RID: 1055 RVA: 0x00015237 File Offset: 0x00013437
	private void ResetCooldown()
	{
		this.pickupCooldown = false;
	}

	// Token: 0x06000420 RID: 1056 RVA: 0x00015240 File Offset: 0x00013440
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

	// Token: 0x06000421 RID: 1057 RVA: 0x000152B0 File Offset: 0x000134B0
	public void PickupItem(InventoryItem item)
	{
		this.hotbar.UpdateHotbar();
		this.currentMouseItem = item;
		this.UpdateMouseSprite();
	}

	// Token: 0x06000422 RID: 1058 RVA: 0x000152CA File Offset: 0x000134CA
	public void PlaceItem(InventoryItem item)
	{
		this.hotbar.UpdateHotbar();
		this.currentMouseItem = item;
		this.UpdateMouseSprite();
		if (Boat.Instance)
		{
			Boat.Instance.CheckForMap();
		}
	}

	// Token: 0x06000423 RID: 1059 RVA: 0x000152FC File Offset: 0x000134FC
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

	// Token: 0x06000424 RID: 1060 RVA: 0x00015399 File Offset: 0x00013599
	private void Update()
	{
		this.mouseItemSprite.transform.position = Input.mousePosition;
	}

	// Token: 0x06000425 RID: 1061 RVA: 0x000153B0 File Offset: 0x000135B0
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

	// Token: 0x06000426 RID: 1062 RVA: 0x00015457 File Offset: 0x00013657
	public void DropItemIntoWorld(InventoryItem item)
	{
		if (item == null)
		{
			return;
		}
		ClientSend.DropItem(item.id, item.amount);
	}

	// Token: 0x06000427 RID: 1063 RVA: 0x00015474 File Offset: 0x00013674
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

	// Token: 0x06000428 RID: 1064 RVA: 0x000154E0 File Offset: 0x000136E0
	public void UpdateAllCells()
	{
		foreach (InventoryCell inventoryCell in this.cells)
		{
			inventoryCell.UpdateCell();
		}
	}

	// Token: 0x06000429 RID: 1065 RVA: 0x00015530 File Offset: 0x00013730
	public void ToggleInventory()
	{
		this.backDrop.SetActive(!this.backDrop.activeInHierarchy);
		if (!base.transform.parent.gameObject.activeInHierarchy && this.currentMouseItem != null)
		{
			this.DropItem(null);
		}
	}

	// Token: 0x0600042A RID: 1066 RVA: 0x00015584 File Offset: 0x00013784
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

	// Token: 0x0600042B RID: 1067 RVA: 0x00015708 File Offset: 0x00013908
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

	// Token: 0x0600042C RID: 1068 RVA: 0x0001578C File Offset: 0x0001398C
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

	// Token: 0x0600042D RID: 1069 RVA: 0x00015864 File Offset: 0x00013A64
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

	// Token: 0x0600042E RID: 1070 RVA: 0x0001591C File Offset: 0x00013B1C
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

	// Token: 0x0600042F RID: 1071 RVA: 0x00015AB8 File Offset: 0x00013CB8
	public bool CanRepair(InventoryItem[] requirements)
	{
		foreach (InventoryItem requirement in requirements)
		{
			if (!this.HasItem(requirement))
			{
				return false;
			}
		}
		return true;
	}

	// Token: 0x06000430 RID: 1072 RVA: 0x00015AE8 File Offset: 0x00013CE8
	public bool Repair(InventoryItem[] requirements)
	{
		foreach (InventoryItem requirement in requirements)
		{
			if (!this.HasItem(requirement))
			{
				return false;
			}
		}
		foreach (InventoryItem inventoryItem in requirements)
		{
			int num = 0;
			foreach (InventoryCell inventoryCell in this.cells)
			{
				if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(inventoryItem))
				{
					if (inventoryCell.currentItem.amount > inventoryItem.amount)
					{
						int num2 = inventoryItem.amount - num;
						inventoryCell.currentItem.amount -= num2;
						inventoryCell.UpdateCell();
						break;
					}
					num += inventoryCell.currentItem.amount;
					inventoryCell.RemoveItem();
				}
			}
		}
		return true;
	}

	// Token: 0x06000431 RID: 1073 RVA: 0x00015BEC File Offset: 0x00013DEC
	public bool HasItem(InventoryItem requirement)
	{
		int num = 0;
		foreach (InventoryCell inventoryCell in this.cells)
		{
			if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(requirement))
			{
				num += inventoryCell.currentItem.amount;
				if (num >= requirement.amount)
				{
					break;
				}
			}
		}
		return num >= requirement.amount;
	}

	// Token: 0x06000432 RID: 1074 RVA: 0x00015C7C File Offset: 0x00013E7C
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

	// Token: 0x06000433 RID: 1075 RVA: 0x00015CE6 File Offset: 0x00013EE6
	public bool HoldingItem()
	{
		return this.currentMouseItem != null;
	}

	// Token: 0x040003FF RID: 1023
	public Transform inventoryParent;

	// Token: 0x04000400 RID: 1024
	public Transform hotkeysTransform;

	// Token: 0x04000401 RID: 1025
	public Transform armorTransform;

	// Token: 0x04000402 RID: 1026
	public Transform leftTransform;

	// Token: 0x04000403 RID: 1027
	public InventoryCell[] armorCells;

	// Token: 0x04000404 RID: 1028
	public InventoryCell[] hotkeyCells;

	// Token: 0x04000405 RID: 1029
	public InventoryCell[] allCells;

	// Token: 0x04000406 RID: 1030
	public InventoryCell leftHand;

	// Token: 0x04000407 RID: 1031
	public InventoryCell arrows;

	// Token: 0x04000408 RID: 1032
	public Hotbar hotbar;

	// Token: 0x04000409 RID: 1033
	public List<InventoryCell> cells;

	// Token: 0x0400040A RID: 1034
	public InventoryItem currentMouseItem;

	// Token: 0x0400040B RID: 1035
	public Image mouseItemSprite;

	// Token: 0x0400040C RID: 1036
	public TextMeshProUGUI mouseItemText;

	// Token: 0x0400040D RID: 1037
	public static InventoryUI Instance;

	// Token: 0x0400040F RID: 1039
	public static readonly float throwForce = 700f;

	// Token: 0x04000410 RID: 1040
	public GameObject backDrop;

	// Token: 0x04000411 RID: 1041
	public InventoryExtensions CraftingUi;
}
