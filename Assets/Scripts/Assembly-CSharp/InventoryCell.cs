using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

// Token: 0x02000093 RID: 147
public class InventoryCell : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerEnterHandler, IPointerExitHandler
{
	// Token: 0x0600035F RID: 863 RVA: 0x000046CB File Offset: 0x000028CB
	private void Start()
	{
		if (this.spawnItem)
		{
			this.currentItem = ScriptableObject.CreateInstance<InventoryItem>();
			this.currentItem.Copy(this.spawnItem, this.spawnItem.amount);
		}
		this.UpdateCell();
	}

	// Token: 0x06000360 RID: 864 RVA: 0x00013990 File Offset: 0x00011B90
	public void UpdateCell()
	{
		if (this.currentItem == null)
		{
			this.amount.text = "";
			this.itemImage.sprite = null;
			this.itemImage.color = Color.clear;
		}
		else
		{
			this.amount.text = this.currentItem.GetAmount();
			this.itemImage.sprite = this.currentItem.sprite;
			this.itemImage.color = Color.white;
		}
		this.SetColor(this.idle);
	}

	// Token: 0x06000361 RID: 865 RVA: 0x00004707 File Offset: 0x00002907
	public void ForceAddItem(InventoryItem item, int amount)
	{
		this.currentItem =Instantiate<InventoryItem>(item);
		this.currentItem.amount = amount;
		this.UpdateCell();
	}

	// Token: 0x06000362 RID: 866 RVA: 0x00013A24 File Offset: 0x00011C24
	public InventoryItem SetItem(InventoryItem pointerItem, PointerEventData eventData)
	{
		InventoryItem inventoryItem = this.currentItem;
		int num = pointerItem.amount;
		if (eventData.button == PointerEventData.InputButton.Right)
		{
			num = 1;
		}
		InventoryItem inventoryItem2;
		InventoryItem inventoryItem3;
		if (inventoryItem == null)
		{
			inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem2.Copy(pointerItem, num);
			if (pointerItem.amount - num < 1)
			{
				inventoryItem3 = null;
			}
			else
			{
				inventoryItem3 = ScriptableObject.CreateInstance<InventoryItem>();
				inventoryItem3.Copy(pointerItem, pointerItem.amount - num);
			}
		}
		else if (pointerItem.Compare(inventoryItem) && pointerItem.stackable)
		{
			if (inventoryItem.amount + num > inventoryItem.max)
			{
				num = inventoryItem.max - inventoryItem.amount;
			}
			inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem2.Copy(this.currentItem, this.currentItem.amount + num);
			if (pointerItem.amount - num < 1)
			{
				inventoryItem3 = null;
			}
			else
			{
				inventoryItem3 = ScriptableObject.CreateInstance<InventoryItem>();
				inventoryItem3.Copy(pointerItem, pointerItem.amount - num);
			}
		}
		else
		{
			inventoryItem2 = pointerItem;
			inventoryItem3 = inventoryItem;
		}
		this.currentItem = inventoryItem2;
		this.UpdateCell();
		UiEvents.Instance.PlaceInInventory(this.currentItem);
		if (this.cellType == InventoryCell.CellType.Chest)
		{
			MonoBehaviour.print("sending chest updates, currentchest:  " + OtherInput.Instance.currentChest.id);
			int itemId = -1;
			int num2 = 0;
			if (this.currentItem)
			{
				itemId = this.currentItem.id;
				num2 = this.currentItem.amount;
			}
			ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num2);
			base.Invoke(nameof(GetReady), (float)(NetStatus.GetPing() * 3) * 0.01f);
		}
		return inventoryItem3;
	}

	// Token: 0x06000363 RID: 867 RVA: 0x00004727 File Offset: 0x00002927
	private void GetReady()
	{
		this.ready = true;
	}

	// Token: 0x06000364 RID: 868 RVA: 0x00013BB4 File Offset: 0x00011DB4
	public InventoryItem PickupItem(PointerEventData eventData)
	{
		if (!this.currentItem)
		{
			return null;
		}
		InventoryItem inventoryItem;
		InventoryItem inventoryItem2;
		if (eventData.button == PointerEventData.InputButton.Right && this.currentItem.amount > 1)
		{
			int num = this.currentItem.amount / 2;
			int num2 = this.currentItem.amount - num;
			inventoryItem = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem.Copy(this.currentItem, num);
			inventoryItem2 = ScriptableObject.CreateInstance<InventoryItem>();
			inventoryItem2.Copy(this.currentItem, num2);
		}
		else
		{
			inventoryItem = null;
			inventoryItem2 = this.currentItem;
		}
		this.currentItem = inventoryItem;
		this.UpdateCell();
		if (this.cellType == InventoryCell.CellType.Chest)
		{
			int itemId = -1;
			int num3 = 0;
			if (this.currentItem)
			{
				itemId = this.currentItem.id;
				num3 = this.currentItem.amount;
			}
			float time = 1f;
			base.Invoke(nameof(GetReady), time);
			ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num3);
		}
		return inventoryItem2;
	}

	// Token: 0x06000365 RID: 869 RVA: 0x00013CAC File Offset: 0x00011EAC
	public void OnPointerDown(PointerEventData eventData)
	{
		if (!this.ready)
		{
			return;
		}
		this.ready = false;
		base.Invoke(nameof(GetReady), Time.deltaTime * 2f);
		if (this.cellType == InventoryCell.CellType.Crafting)
		{
			InventoryUI.Instance.CraftItem(this.currentItem);
			return;
		}
		if (Time.time - this.lastClickTime < 0.25f && eventData.button == PointerEventData.InputButton.Left && InventoryUI.Instance.HoldingItem())
		{
			this.DoubleClick();
			return;
		}
		if (Input.GetKey(KeyCode.LeftShift))
		{
			this.ShiftClick();
			return;
		}
		if (InventoryUI.Instance.HoldingItem())
		{
			if (this.IsItemCompatibleWithCell(InventoryUI.Instance.currentMouseItem))
			{
				InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
				InventoryUI.Instance.PlaceItem(this.SetItem(currentMouseItem, eventData));
			}
		}
		else
		{
			InventoryUI.Instance.PickupItem(this.PickupItem(eventData));
		}
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			this.lastClickTime = Time.time;
		}
	}

	// Token: 0x06000366 RID: 870 RVA: 0x00013D9C File Offset: 0x00011F9C
	private bool IsItemCompatibleWithCell(InventoryItem item)
	{
		if (this.tags.Length == 0)
		{
			return true;
		}
		foreach (InventoryItem.ItemTag itemTag in this.tags)
		{
			if (item.tag == itemTag)
			{
				return true;
			}
		}
		return false;
	}

	// Token: 0x06000367 RID: 871 RVA: 0x00004730 File Offset: 0x00002930
	public void RemoveItem()
	{
		this.currentItem = null;
		this.UpdateCell();
	}

	// Token: 0x06000368 RID: 872 RVA: 0x00013DDC File Offset: 0x00011FDC
	private void DoubleClick()
	{
		InventoryItem currentMouseItem = InventoryUI.Instance.currentMouseItem;
		if (!currentMouseItem.stackable)
		{
			return;
		}
		foreach (InventoryCell inventoryCell in InventoryUI.Instance.cells)
		{
			if (!(inventoryCell.currentItem == null) && inventoryCell.currentItem.Compare(currentMouseItem))
			{
				if (currentMouseItem.amount + inventoryCell.currentItem.amount > currentMouseItem.max)
				{
					int num = currentMouseItem.max - currentMouseItem.amount;
					currentMouseItem.amount += num;
					inventoryCell.currentItem.amount -= num;
					inventoryCell.UpdateCell();
					InventoryUI.Instance.PickupItem(currentMouseItem);
					return;
				}
				currentMouseItem.amount += inventoryCell.currentItem.amount;
				inventoryCell.RemoveItem();
			}
		}
		InventoryUI.Instance.PickupItem(currentMouseItem);
	}

	// Token: 0x06000369 RID: 873 RVA: 0x00013EEC File Offset: 0x000120EC
	private bool ShiftClick()
	{
		if (this.cellType != InventoryCell.CellType.Chest)
		{
			if (this.cellType == InventoryCell.CellType.Inventory)
			{
				OtherInput.CraftingState craftingState = OtherInput.Instance.craftingState;
				OtherInput.CraftingState craftingState2 = OtherInput.Instance.craftingState;
				OtherInput.CraftingState craftingState3 = OtherInput.Instance.craftingState;
			}
			return false;
		}
		if (!InventoryUI.Instance.CanPickup(this.currentItem))
		{
			return false;
		}
		InventoryUI.Instance.AddItemToInventory(this.currentItem);
		this.RemoveItem();
		int itemId = -1;
		int num = 0;
		if (this.currentItem)
		{
			itemId = this.currentItem.id;
			num = this.currentItem.amount;
		}
		ClientSend.ChestUpdate(OtherInput.Instance.currentChest.id, this.cellId, itemId, num);
		return true;
	}

	// Token: 0x0600036A RID: 874 RVA: 0x00013FA4 File Offset: 0x000121A4
	public void OnPointerEnter(PointerEventData eventData)
	{
		this.SetColor(this.hover);
		if (this.currentItem)
		{
			if (this.cellType == InventoryCell.CellType.Inventory)
			{
				string text = this.currentItem.name + "\n<size=50%><i>" + this.currentItem.description;
				if (this.currentItem.IsArmour())
				{
					text = string.Concat(new object[]
					{
						text,
						"\n+",
						this.currentItem.armor,
						" armor"
					});
					text = text + "\n" + this.currentItem.armorComponent.setBonus;
				}
				ItemInfo.Instance.SetText(text, false);
				return;
			}
			if (this.cellType == InventoryCell.CellType.Crafting)
			{
				string text2 = this.currentItem.name + "<size=60%>";
				foreach (InventoryItem.CraftRequirement craftRequirement in this.currentItem.requirements)
				{
					text2 = string.Concat(new object[]
					{
						text2,
						"\n",
						craftRequirement.item.name,
						" - ",
						craftRequirement.amount
					});
				}
				ItemInfo.Instance.SetText(text2, false);
			}
		}
	}

	// Token: 0x0600036B RID: 875 RVA: 0x0000473F File Offset: 0x0000293F
	public void Eat(int amount)
	{
		this.currentItem.amount -= amount;
		if (this.currentItem.amount <= 0)
		{
			this.RemoveItem();
		}
		this.UpdateCell();
	}

	// Token: 0x0600036C RID: 876 RVA: 0x0000476E File Offset: 0x0000296E
	public void OnPointerExit(PointerEventData eventData)
	{
		this.SetColor(this.idle);
		ItemInfo.Instance.Fade(0f, 0.2f);
	}

	// Token: 0x0600036D RID: 877 RVA: 0x00002147 File Offset: 0x00000347
	public void SetColor(Color c)
	{
	}

	// Token: 0x0600036E RID: 878 RVA: 0x00002147 File Offset: 0x00000347
	public void AddItemToChest(InventoryItem item)
	{
	}

	// Token: 0x0600036F RID: 879 RVA: 0x00002147 File Offset: 0x00000347
	public void AddItemToCauldron()
	{
	}

	// Token: 0x06000370 RID: 880 RVA: 0x00002147 File Offset: 0x00000347
	public void AddItemToFurnace()
	{
	}

	// Token: 0x06000371 RID: 881 RVA: 0x00004790 File Offset: 0x00002990
	public void SetOverlayAlpha(float f)
	{
		MonoBehaviour.print("overlay set to: " + f);
		this.overlay.color = new Color(0f, 0f, 0f, f);
	}

	// Token: 0x04000331 RID: 817
	public InventoryCell.CellType cellType;

	// Token: 0x04000332 RID: 818
	public TextMeshProUGUI amount;

	// Token: 0x04000333 RID: 819
	public Image itemImage;

	// Token: 0x04000334 RID: 820
	public RawImage slot;

	// Token: 0x04000335 RID: 821
	[HideInInspector]
	public InventoryItem currentItem;

	// Token: 0x04000336 RID: 822
	public InventoryItem spawnItem;

	// Token: 0x04000337 RID: 823
	public int cellId;

	// Token: 0x04000338 RID: 824
	public Color idle;

	// Token: 0x04000339 RID: 825
	public Color hover;

	// Token: 0x0400033A RID: 826
	private bool ready = true;

	// Token: 0x0400033B RID: 827
	private float lastClickTime;

	// Token: 0x0400033C RID: 828
	private float doubleClickThreshold = 0.15f;

	// Token: 0x0400033D RID: 829
	public InventoryItem.ItemTag[] tags;

	// Token: 0x0400033E RID: 830
	public RawImage overlay;

	// Token: 0x02000094 RID: 148
	public enum CellType
	{
		// Token: 0x04000340 RID: 832
		Inventory,
		// Token: 0x04000341 RID: 833
		Crafting,
		// Token: 0x04000342 RID: 834
		Chest
	}
}
