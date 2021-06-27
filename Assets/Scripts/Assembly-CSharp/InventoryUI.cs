using System;
using System.Collections.Generic;
using JetBrains.Annotations;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class InventoryUI : MonoBehaviour
{
	private void Awake()
	{
		InventoryUI.Instance = this;
	}

	private void Start()
	{
		this.FillCellList();
		this.UpdateMouseSprite();
		this.backDrop.SetActive(false);
	}

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

	public bool pickupCooldown { get; set; }

	public void CooldownPickup()
	{
		this.pickupCooldown = true;
		Invoke(nameof(ResetCooldown), (float)(NetStatus.GetPing() * 2) / 1000f);
	}

	private void ResetCooldown()
	{
		this.pickupCooldown = false;
	}

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

	public void PickupItem(InventoryItem item)
	{
		this.hotbar.UpdateHotbar();
		this.currentMouseItem = item;
		this.UpdateMouseSprite();
	}

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

	private void UpdateMouseSprite()
	{
		if (this.currentMouseItem != null)
		{
			this.mouseItemSprite.sprite = this.currentMouseItem.sprite;
			this.mouseItemSprite.color = Color.white;
			this.mouseItemText.text = this.currentMouseItem.GetAmount();
			mouseItemSprite.preserveAspect = true;
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

	private void Update()
	{
		this.mouseItemSprite.transform.position = Input.mousePosition;
	}

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

	public void DropItemIntoWorld(InventoryItem item)
	{
		if (item == null)
		{
			return;
		}
		ClientSend.DropItem(item.id, item.amount);
	}

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

	public void UpdateAllCells()
	{
		foreach (InventoryCell inventoryCell in this.cells)
		{
			inventoryCell.UpdateCell();
		}
	}

	public void ToggleInventory()
	{
		this.backDrop.SetActive(!this.backDrop.activeInHierarchy);
		if (!base.transform.parent.gameObject.activeInHierarchy && this.currentMouseItem != null)
		{
			this.DropItem(null);
		}
	}

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

	public bool HoldingItem()
	{
		return this.currentMouseItem != null;
	}

	public Transform inventoryParent;

	public Transform hotkeysTransform;

	public Transform armorTransform;

	public Transform leftTransform;

	public InventoryCell[] armorCells;

	public InventoryCell[] hotkeyCells;

	public InventoryCell[] allCells;

	public InventoryCell leftHand;

	public InventoryCell arrows;

	public Hotbar hotbar;

	public List<InventoryCell> cells;

	public InventoryItem currentMouseItem;

	public Image mouseItemSprite;

	public TextMeshProUGUI mouseItemText;

	public static InventoryUI Instance;

	public static readonly float throwForce = 700f;

	public GameObject backDrop;

	public InventoryExtensions CraftingUi;
}
